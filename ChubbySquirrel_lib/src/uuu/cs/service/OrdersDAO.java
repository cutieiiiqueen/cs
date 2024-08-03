package uuu.cs.service;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import uuu.cs.entity.Customer;
import uuu.cs.entity.Order;
import uuu.cs.entity.OrderItem;
import uuu.cs.entity.OrderStatusLog;
import uuu.cs.entity.PaymentType;
import uuu.cs.entity.Product;
import uuu.cs.entity.ShippingType;
import uuu.cs.entity.Spec;
import uuu.cs.entity.VIP;
import uuu.cs.exception.CSException;
import uuu.cs.exception.StockShortageException;
import uuu.cs.exception.CSException;
import uuu.cs.service.MySQLConnection;
class OrdersDAO {
	
	//修改庫存	
	private static final String UPDATE_PRODUCTS = "UPDATE products SET stock = stock-?  WHERE id =? AND stock >= ?";
	private static final String UPDATE_PRODUCT_SPECS = "UPDATE product_specs SET stock = stock-?  WHERE product_id =? AND stock >= ? AND spec_name=?";
	
	private static final String INSERT_ORDERS = "INSERT INTO orders"
			+ " (id, customer_email, created_date, created_time, status,"
			+ " shipping_type, shipping_fee, payment_type, payment_fee,"
			+ " recipient_name, recipient_email, recipient_phone, shipping_address, sub_total, discount_amount, total_amount)"
			+ " VALUES(?,?,?,?,?, ?,?,?,?, ?,?,?,?, ?,?,?);";
	
	private static final String INSERT_ORDER_ITEMS = "INSERT INTO order_items"
			+ " (order_id, product_id, spec_name, price, quantity)"
			+ " VALUES(?,?,?,?,?);";
	
	//因為ORDER_ITEMS要抓ORDER自動建立的id，所以要放在同個連線才能抓得到
	void insert(Order order) throws CSException {
		
		try (
				Connection connection = MySQLConnection.getConnection(); //1&2 取得連線
				PreparedStatement pstmt01 = connection.prepareStatement(UPDATE_PRODUCTS);
				PreparedStatement pstmt02 = connection.prepareStatement(UPDATE_PRODUCT_SPECS);
				
				PreparedStatement pstmt1 = connection.prepareStatement(INSERT_ORDERS, Statement.RETURN_GENERATED_KEYS); //3.orders 準備指令, 回傳資料庫產生的自動給號
				PreparedStatement pstmt2 = connection.prepareStatement(INSERT_ORDER_ITEMS); //3.order_items 準備指令
				){
			
				//開始交易控制
				//connection.beginTrans(); //java沒有提供這支程式
				//connection.setTransactionIsolation(0); //鎖定
				connection.setAutoCommit(false); //可視為beginTransaction
				try {
					
					//庫存管理
					for(OrderItem orderItem:order.getOrderItemSet()) {
						PreparedStatement pstmt;
						if(orderItem.getTheSpec()!=null) {
							pstmt = pstmt02;	
							pstmt.setString(4, orderItem.getSpecName());
						}else {
							pstmt = pstmt01;
						}
						
						pstmt.setInt(1, orderItem.getQuantity());
						pstmt.setInt(2, orderItem.getProductId());
						pstmt.setInt(3, orderItem.getQuantity());
						
						//4.執行指令
						int rows = pstmt.executeUpdate();
						if(rows==0) {
							throw new StockShortageException("庫存不足", orderItem);
						}
					}
					
					
					//3.1.orders 傳入?
					pstmt1.setInt(1, order.getId()); //給0會觸發資料庫的自動給號
					pstmt1.setString(2, order.getMember().getEmail());
					pstmt1.setString(3, order.getCreatedDate().toString());
					pstmt1.setString(4, order.getCreatedTime().toString());
					pstmt1.setInt(5, order.getStatus());
					
					pstmt1.setString(6, order.getShippingType().name());
					pstmt1.setDouble(7, order.getShippingFee());
					pstmt1.setString(8, order.getPaymentType().name());
					pstmt1.setDouble(9, order.getPaymentFee());
					
					pstmt1.setString(10, order.getRecipientName());
					pstmt1.setString(11, order.getRecipientEmail());
					pstmt1.setString(12, order.getRecipientPhone());
					pstmt1.setString(13, order.getShippingAddress());
					
					pstmt1.setDouble(14, order.getSubtotal());
					pstmt1.setDouble(15, order.getDiscountAmount());
					pstmt1.setDouble(16, order.getTotalAmount());
					
					//4.orders 執行指令
					pstmt1.executeUpdate();
					
					//取得auto-increment的訂單id
					ResultSet rs = pstmt1.getGeneratedKeys(); //讀取order id的自動給號 (23行:Statement.RETURN_GENERATED_KEYS) 有打開才能接收
					while(rs.next()) { //指向下一個(第一個)
						int id = rs.getInt(1); //1號欄位的值
						order.setId(id); //存回order.id
					}
					
					for(OrderItem orderItem:order.getOrderItemSet()) {
						//3.1.建立 order_items  傳入?
						pstmt2.setInt(1, order.getId());
						pstmt2.setInt(2, orderItem.getProductId());
						pstmt2.setString(3, orderItem.getSpecName());
						pstmt2.setDouble(4, orderItem.getPrice());
						pstmt2.setInt(5, orderItem.getQuantity());
						
						//4.order_items 執行指令
						pstmt2.executeUpdate();
					}
										
					//交易控制結束					
					//1. commit
					connection.commit(); //確認交易
				}catch(Exception e) {
					//2. rollback
					connection.rollback();	//發生任何錯誤皆須取消交易
					throw e; //把原錯回歸到原本錯誤處理的行列
				}finally {
					connection.setAutoCommit(true); //為了將來可能有[connection pooling 連線儲存池]機制，建議在finally還原預設設定
				}				
		} catch (SQLException e) {
			throw new CSException("建立訂單失敗", e);
		}
		
		
	}
	
	private static final String SELECT_ORDERS_HISTORY = "SELECT id, customer_email, created_date, created_time, status,"
			+ "	 shipping_type, shipping_fee, payment_type, payment_fee,"
			+ "  sub_total, discount_amount, total_amount"
			+ "	 FROM orders JOIN order_items ON orders.id = order_items.order_id"
			+ "     WHERE customer_email = ?"
			+ "		AND created_date BETWEEN DATE_ADD(curdate(), INTERVAL ? MONTH) AND curdate()"
			+ "     GROUP BY orders.id"
			+ "     ORDER BY created_date DESC, created_time DESC";
	
	List<Order> selectOrdersHistory(String email, int rangeNumber) throws CSException{
		List<Order> list = new ArrayList<>();
		try (
				Connection connection = MySQLConnection.getConnection(); //1&2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDERS_HISTORY);
				){
		
					//3.1.orders 傳入?
					pstmt.setString(1, email);
					pstmt.setInt(2, -rangeNumber);
										
					try(
							ResultSet rs = pstmt.executeQuery(); //4.執行SELECT指令
					){
						//5.讀取rs
						while(rs.next()) {
							Order order = new Order();
							order.setId(rs.getInt("id"));
							
							Customer c = new Customer();
							c.setEmail(rs.getString("customer_email"));							
							order.setMember(c);
							
							order.setCreatedDate(LocalDate.parse(rs.getString("created_date")));
							order.setCreatedTime(LocalTime.parse(rs.getString("created_time")));
							order.setStatus(rs.getInt("status"));
							
							order.setShippingType(ShippingType.valueOf(rs.getString("shipping_type")));
							order.setShippingFee(rs.getDouble("shipping_fee"));
							
							order.setPaymentType(PaymentType.valueOf(rs.getString("payment_type")));
							order.setPaymentFee(rs.getDouble("payment_fee"));
							order.setTotalAmount(rs.getDouble("total_amount"));
							
							order.setSubtotal(rs.getDouble("sub_total"));
							order.setDiscountAmount(rs.getDouble("discount_amount"));
							order.setTotalAmount(rs.getDouble("total_amount"));
							
							list.add(order);
						}
					}	
		} catch (SQLException e) {
			throw new CSException("查詢歷史訂單失敗", e);
		}	
		return list;
	}	
	
	
	private static final String SELECT_ORDER_BY_ID = "  SELECT orders.id, customer_email, orders.created_date, orders.created_time, orders.status,"
			+ "shipping_type, shipping_fee, shipping_note, payment_type, payment_fee, payment_note,"
			+ " recipient_name, recipient_email, recipient_phone, shipping_address,"
			+ " sub_total, discount_amount, total_amount,"
			+ " order_id, order_items.product_id, products.name, order_items.spec_name, price, quantity,"
			+ " product_specs.spec_name AS s_name,"
			+ " IFNULL(product_specs.photo_url, products.photo_url) AS photo_url"
			+ " FROM orders JOIN order_items ON orders.id = order_items.order_id"
			+ "	LEFT JOIN products ON order_items.product_id = products.id"
			+ "    LEFT JOIN product_specs ON order_items.product_id = product_specs.product_id AND order_items.spec_name = product_specs.spec_name"
			+ " WHERE customer_email= ? AND orders.id = ?";
	Order selectOrderById(String email, String orderId) throws CSException {
		
		Order order = null;		
		
		try (
				Connection connection = MySQLConnection.getConnection(); //1&2建立連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDER_BY_ID); //3.準備指令
				){
				
				//3.1傳入?
				pstmt.setString(1, email);
				pstmt.setString(2, orderId);
				
				try(
						ResultSet rs = pstmt.executeQuery(); //4.執行SELECT指令
				){
					//5.讀取rs
					while(rs.next()) {
						if(order==null) {
							order = new Order();
							order.setId(rs.getInt("id"));
							
							Customer c = new Customer();
							c.setEmail(rs.getString("customer_email"));
							order.setMember(c);
							
							order.setCreatedDate(LocalDate.parse(rs.getString("created_date")));
							order.setCreatedTime(LocalTime.parse(rs.getString("created_time")));
							order.setStatus(rs.getInt("status"));
							
							order.setShippingType(ShippingType.valueOf(rs.getString("shipping_type")));
							order.setShippingFee(rs.getDouble("shipping_fee"));
							order.setShippingNote(rs.getString("shipping_note"));
							
							order.setPaymentType(PaymentType.valueOf(rs.getString("payment_type")));
							order.setPaymentFee(rs.getDouble("payment_fee"));
							order.setPaymentNote(rs.getString("payment_note"));
							
							order.setRecipientName(rs.getString("recipient_name"));
							order.setRecipientPhone(rs.getString("recipient_phone"));
							order.setRecipientEmail(rs.getString("recipient_email"));
							order.setShippingAddress(rs.getString("shipping_address"));
							
							order.setSubtotal(rs.getDouble("sub_total"));
							order.setDiscountAmount(rs.getDouble("discount_amount"));
							order.setTotalAmount(rs.getDouble("total_amount"));
							
							//order.setTotalAmount(rs.getDouble("total_amount"));// 這裡沒有資料庫加總的金額，有之後讀取的明細來加總
							
						}
						
						OrderItem orderItem = new OrderItem();
						orderItem.setOrderId(order.getId());
						
						Product p = new Product();
						p.setId(rs.getInt("product_id"));
						p.setName(rs.getString("name"));
						p.setPhotoUrl(rs.getString("photo_url"));
						orderItem.setProduct(p);
						
						orderItem.setPrice(rs.getDouble("price"));
						orderItem.setQuantity(rs.getInt("quantity"));
						
						String specName = rs.getString("s_name");
						if(specName!=null && specName.length()>0) {
							Spec spec = new Spec();
							spec.setSpecName(specName);
							orderItem.setTheSpec(spec);
						}
						order.add(orderItem);
					}
				}	
			
			
		} catch (SQLException e) {
			throw new CSException("查詢歷史訂單失敗", e);
		}		
		return order;
	}
	
    private static final String UPDATE_STATUS_TO_TRANSFERED = "UPDATE orders SET orders.status=1" //狀態設定為已轉帳
            + ", payment_note=? WHERE orders.status=0"
            + " AND payment_type='" + PaymentType.ATM.name() + "'"
            + " AND customer_email=? AND id=? ";  
	
	void updateStatusToTransfered(String customerEmail, int orderId, String paymentNote) throws CSException{
		
		try (
				Connection connection = MySQLConnection.getConnection(); //1&2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(UPDATE_STATUS_TO_TRANSFERED); //3.準備指令
				){
				
				//3.1傳入?的值
				pstmt.setString(1, paymentNote);
				pstmt.setString(2, customerEmail);
				pstmt.setInt(3, orderId);
				
				//4.執行指令
				pstmt.executeUpdate();
		} catch (SQLException ex) {
			throw new CSException("[通知轉帳]失敗!", ex);
		}
	}
	
	private static final String SELECT_ORDER_STATUS_LOG = "SELECT order_id, update_time, old_status, new_status"
			+ " FROM order_logs WHERE order_id = ?";
	
	List<OrderStatusLog> selecOrderStatusLog(String orderId) throws CSException{
		
		List<OrderStatusLog> list = new ArrayList<>();
		
		try (
				Connection connection = MySQLConnection.getConnection(); //1&2.取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDER_STATUS_LOG); //3.取得指令
				){
				
			//3.1傳入?值
			pstmt.setString(1, orderId);
			
			//4執行指令
			try (ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {
					OrderStatusLog log = new OrderStatusLog();
					log.setId(rs.getInt("order_id"));
					log.setOldStatus(rs.getInt("old_status"));
					log.setStatus(rs.getInt("new_status"));
					log.setLogTime(rs.getString("update_time"));
					list.add(log);
				}			
			}
			return list;

		} catch (SQLException ex) {
			throw new CSException("查詢訂單狀態Log失敗",ex);
		}
	}
	
	private static final String SELECT_ORDERS = "SELECT orders.id, customer_email, orders.created_date, orders.created_time, orders.status,shipping_type, shipping_fee,"
			+ " shipping_note, payment_type, payment_fee, payment_note, recipient_name, recipient_email, recipient_phone, shipping_address,"
			+ " order_id, order_items.product_id, products.name, order_items.spec_name, price, quantity FROM orders JOIN order_items ON orders.id = order_items.order_id"
			+ " LEFT JOIN products ON order_items.product_id = products.id";
	
	List<Order> selectOrders() throws CSException{
		Map<Integer, Order> ordersMap = new HashMap<>();
		try (
				Connection connection = MySQLConnection.getConnection(); //1&2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDERS);
				){
		
					try(
							ResultSet rs = pstmt.executeQuery(); //4.執行SELECT指令
					){
						//5.讀取rs
						while (rs.next()) {
							int orderId = rs.getInt("id");
				            Order order = ordersMap.get(orderId);

			                if (order == null) {
			                    order = new Order();
			                    order.setId(orderId);
			                    
			                    CustomersDAO customersDao = new CustomersDAO();
			                    Customer c = customersDao.selectCustomerById(rs.getString("customer_email"));
								order.setMember(c);
								
			                    order.setCreatedDate(LocalDate.parse(rs.getString("created_date")));
			                    order.setCreatedTime(LocalTime.parse(rs.getString("created_time")));
			                    order.setStatus(rs.getInt("status"));
			                    order.setShippingType(ShippingType.valueOf(rs.getString("shipping_type")));
			                    order.setShippingFee(rs.getDouble("shipping_fee"));
			                    order.setShippingNote(rs.getString("shipping_note"));
			                    order.setPaymentType(PaymentType.valueOf(rs.getString("payment_type")));
			                    order.setPaymentFee(rs.getDouble("payment_fee"));
			                    order.setPaymentNote(rs.getString("payment_note"));
			                    order.setRecipientName(rs.getString("recipient_name"));
			                    order.setRecipientEmail(rs.getString("recipient_email"));
			                    order.setRecipientPhone(rs.getString("recipient_phone"));
			                    order.setShippingAddress(rs.getString("shipping_address"));

			                    ordersMap.put(orderId, order);
			                }

			                OrderItem item = new OrderItem();
			                item.setOrderId(orderId);
			                Product product = new Product();
			                product.setId(rs.getInt("product_id"));
			                product.setName(rs.getString("name"));
			                item.setProduct(product);
			                Spec spec = new Spec();
			                spec.setSpecName(rs.getString("spec_name"));
			                item.setTheSpec(spec);
			                item.setPrice(rs.getDouble("price"));
			                item.setQuantity(rs.getInt("quantity"));
			                order.add(item);
			            }
					}	
		} catch (SQLException e) {
			throw new CSException("查詢訂單失敗", e);
		}	
		return new ArrayList<>(ordersMap.values());
	}	
	
	private static final String UPDATE_ORDER_STATUS = "UPDATE orders SET orders.status =?, orders.payment_note = ?, orders.shipping_note = ?  WHERE id = ?";
	
    void updateOrderStatus(int orderId, int status,String paymentNote, String shippingNote) throws CSException {  	
        
        
        try (
        		Connection connection = MySQLConnection.getConnection(); //1.&2.建立連線
        		PreparedStatement pstmt = connection.prepareStatement(UPDATE_ORDER_STATUS) //3.準備指令
            	) {
            	
	        	//3.1傳入?的值
	        	pstmt.setInt(1, status);	            
	            pstmt.setString(2, paymentNote);
	            pstmt.setString(3, shippingNote);
	            pstmt.setInt(4, orderId);
	            
	            pstmt.executeUpdate(); //執行指令
	            
        } catch (SQLException e) {
            throw new CSException("更新訂單狀態失敗", e);
        }
    }
	private static final String UPDATE_STATUS_TO_PAID = "UPDATE orders"
	        + " SET status=2"   //狀態設定為已付款
	            + ", payment_note=? WHERE customer_email=? AND id=?"
	            + " AND status=0" + " AND payment_type='" + PaymentType.CARD.name() + "'";
	   /**
	    * 紀錄信用卡付款相關資料
	    * @param memberId: 訂購人
	    * @param orderId: 訂單編號
	    * @param paymentNote: 紀錄信用卡付款相關資料(信用卡號，有效年月、授權碼等)
	    * @throws VGBException
	    */
	    void updateOrderStatusToPAID(String customerEmail, int orderId, String paymentNote) throws CSException {
	        try (Connection connection = MySQLConnection.getConnection(); //2. 建立連線
	             PreparedStatement pstmt = connection.prepareStatement(UPDATE_STATUS_TO_PAID) //3. 準備指令
	        ) {
	            //3.1 傳入?的值
	            pstmt.setString(1, paymentNote);
	            pstmt.setString(2, customerEmail);
	            pstmt.setInt(3, orderId);
	            
	            //4. 執行指令
	            pstmt.executeUpdate();
	        } catch (SQLException ex) {
	            System.out.println("修改信用卡付款狀態失敗-" + ex);
	            throw new CSException("修改信用卡付款狀態失敗!", ex);
	        }
	    }

}
