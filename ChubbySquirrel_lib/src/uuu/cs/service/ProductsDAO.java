package uuu.cs.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import uuu.cs.entity.Product;
import uuu.cs.entity.Spec;
import uuu.cs.entity.SpecialOffer;
import uuu.cs.exception.CSException;

class ProductsDAO {
	
	// SQL查詢語句，用於選擇所有產品
	private static final String SELECT_ALL_PRODUCTS = "SELECT id, name, category, unit_price, stock, "
			+ "release_date, photo_url, description, discount, status FROM products_list_view ";
	// 方法：查詢所有產品
	List<Product> selectAllProducts() throws CSException{
		// 創建一個Product列表來存儲查詢結果
		List<Product> list = new ArrayList<>(); //目的是如果有查詢到資料，add時才不會來不及new, 且因為list.add時.左邊不得為null
			
		try (
				Connection connection = MySQLConnection.getConnection(); //1.&2.載入Driver並取得連線	
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ALL_PRODUCTS); //3. 準備查詢指令 //產品查詢沒有問號，但也可以用PreparedStatement
				){
			
				//3.1傳入?的值, 查詢全部產品沒有?不用寫
			
				try(
						ResultSet rs= pstmt.executeQuery(); // 4. 執行SELECT指令，獲取結果集
						){
						//5.讀取rs
						while(rs.next()) { //資料庫查詢不確定會查詢到幾筆, 所以用while(0-多)
							Product p;
							int discount = rs.getInt("discount"); //先讀取discount的值
		 					if(discount==0) { 
								p = new Product(); //如果discount是0, 就建立一個Product類別的物件
							}else {
								p = new SpecialOffer(); //如果discount不是0,就建立一個SpecialOffer類別的物件
								((SpecialOffer)p).setDiscount(discount); //把discount的值設定成p物件的屬性discount, 但是Product類別沒有discount屬性及方法,所以要強轉成SpecialOffer
							}
							
		 					//從資料庫讀取資料後給p物件回傳
							p.setId(rs.getInt("id"));
							p.setName(rs.getString("name"));
							p.setCategory(rs.getString("category"));
							p.setUnitPrice(rs.getDouble("unit_price"));
							p.setStock(rs.getInt("stock"));
							p.setReleaseDate(rs.getString("release_date"));
							p.setPhotoUrl(rs.getString("photo_url"));
							p.setDescription(rs.getString("description"));
							p.setStatus(rs.getInt("status"));
							
							list.add(p);	// 將p物件添加到列表中					
						}
					}		
				} catch (SQLException e) {
					//throw new RuntimeException("[查詢全部產品]失敗",e); //throw new XxxExceptioin
					throw new CSException("[查詢全部產品]失敗",e); // 捕獲SQL異常並拋出自定義異常
				} 
		return list; // 返回包含所有產品的列表
	}
	
	private static final String SELECT_PRODUCTS_BY_CATEGORY = SELECT_ALL_PRODUCTS
			+ " WHERE category = ?";
	List<Product> selectProductsByCategory(String category) throws CSException{
		List<Product> list = new ArrayList<>();
		
		try(
				Connection connection = MySQLConnection.getConnection();//1.&2.載入Driver並取得連線	
				PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCTS_BY_CATEGORY); //3.準備指令
				){
				//3.1傳入?的值
				pstmt.setString(1,category);
			
				try(
						ResultSet rs= pstmt.executeQuery(); //4.執行SELECT指令
						){
						//5.讀取rs
						while(rs.next()) { //資料庫查詢不確定會查詢到幾筆所以用while(0-多)
							Product p;
							int discount = rs.getInt("discount"); //先讀取discount的值
		 					if(discount==0) { 
								p = new Product(); //如果discount是0,就建立成Product類別的物件
							}else {
								p = new SpecialOffer(); //如果discount不是0,就建立成SpecialOffer類別的物件
								((SpecialOffer)p).setDiscount(discount); //把discount的值設定成p物件的屬性discount,但是Product類別沒有discount屬性及方法,所以要強轉成SpecialOffer
							}
		 					
		 					//從資料庫讀取資料後給p物件回傳
							p.setId(rs.getInt("id"));
							p.setName(rs.getString("name"));
							p.setCategory(rs.getString("category"));
							p.setUnitPrice(rs.getDouble("unit_price"));
							p.setStock(rs.getInt("stock"));
							p.setReleaseDate(rs.getString("release_date"));
							p.setPhotoUrl(rs.getString("photo_url"));
							p.setDescription(rs.getString("description"));
							p.setStatus(rs.getInt("status"));
							
							list.add(p);						
						}				
					}
				} catch (SQLException e) {
					//throw new RuntimeException("[依分類查詢產品]失敗",e);
					throw new CSException("[依分類查詢產品]失敗",e);
				}
		return list;
	}
	
	private static final String SELECT_PRODUCTS_BY_KEYWORD = SELECT_ALL_PRODUCTS
			+ " WHERE name LIKE ?";
		List<Product> selectProductsByKeyword(String keyword) throws CSException {
			List<Product> list = new ArrayList<>();
		
			try(
					Connection connection = MySQLConnection.getConnection();//1.&2.載入Driver並取得連線	
					PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCTS_BY_KEYWORD); //3.準備指令
					){
					//3.1傳入?的值
					pstmt.setString(1, "%"+keyword+"%"); //前後+%在字串的任何位置進行模糊匹配
				
					try(
							ResultSet rs= pstmt.executeQuery(); //4.執行SELECT指令
							){
							//5.讀取rs
							while(rs.next()) { //資料庫查詢不確定會查詢到幾筆, 所以用while(0-多)
								Product p;
								int discount = rs.getInt("discount"); //先讀取discount的值
			 					if(discount==0) { 
									p = new Product(); //如果discount是0,就新建立成Product類別的物件
								}else {
									p = new SpecialOffer(); //如果discount不是0,就建立成SpecialOffer類別的物件
									((SpecialOffer)p).setDiscount(discount); //把discount的值設定成p物件的屬性discount,但是Product類別沒有discount屬性及方法,所以要強轉成SpecialOffer
								}
			 					
			 					//查詢產品
			 					//從資料庫讀取資料後設定給p物件(為了回傳到前端)
								p.setId(rs.getInt("id"));
								p.setName(rs.getString("name"));
								p.setCategory(rs.getString("category"));
								p.setUnitPrice(rs.getDouble("unit_price"));
								p.setStock(rs.getInt("stock"));
								p.setReleaseDate(rs.getString("release_date"));
								p.setPhotoUrl(rs.getString("photo_url"));
								p.setDescription(rs.getString("description"));
								p.setStatus(rs.getInt("status"));
								
								list.add(p);						
							}				
						}
					} catch (SQLException e) { //SQLException 是 checked exception
						//e.printStackTrace(); //等同於Syserr //for developer, admin(前端收不到)
						//throw new RuntimeException("[依關鍵字查詢產品]失敗",e); //RuntimeException只能用在可防範/使用者輸入的錯誤, 改掉
						throw new CSException("[依關鍵字查詢產品]失敗",e);
					}
			return list;
		}	
		
		
		private static final int LIMIT_NUMBER = 5;
		private static final String SELECT_NEWEST_PRODUCTS = SELECT_ALL_PRODUCTS
				+ " ORDER BY release_date DESC LIMIT " + LIMIT_NUMBER;
		
		List<Product> selectNewestProducts()throws CSException{
			List<Product> list = new ArrayList<>();
					
			try (
					Connection connection = MySQLConnection.getConnection();//1.&2.載入Driver並取得連線
					PreparedStatement pstmt = connection.prepareStatement(SELECT_NEWEST_PRODUCTS); //3.準備指令
					//沒有3.1所以4.可以寫一起
					ResultSet rs = pstmt.executeQuery(); //4.執行SELECT指令
					){
						//5.讀取rs
						//int count = 0;
						//while(rs.next() && count++ < LIMIT_NUMBER) { //把限制比數寫在java語法
						while(rs.next()) {
							Product p;
							int discount = rs.getInt("discount"); //先讀取discount的值
		 					if(discount==0) { 
								p = new Product(); //如果discount是0,就新建立成Product類別的物件
							}else {
								p = new SpecialOffer(); //如果discount不是0,就建立成SpecialOffer類別的物件
								((SpecialOffer)p).setDiscount(discount); //把discount的值設定成p物件的屬性discount,但是Product類別沒有discount屬性及方法,所以要強轉成SpecialOffer
							}
		 					
		 					//查詢產品
		 					//從資料庫讀取資料後設定給p物件(為了回傳到前端)
							p.setId(rs.getInt("id"));
							p.setName(rs.getString("name"));
							p.setCategory(rs.getString("category"));
							p.setUnitPrice(rs.getDouble("unit_price"));
							p.setStock(rs.getInt("stock"));
							p.setReleaseDate(rs.getString("release_date"));
							p.setPhotoUrl(rs.getString("photo_url"));
							p.setDescription(rs.getString("description"));
							p.setStatus(rs.getInt("status"));
							
							list.add(p);						
						}
				
					} catch (SQLException e) {
						throw new CSException("[查詢最新上架產品]失敗"+e.getErrorCode(),e);
					}			
			return list;
		}
		
		private static final String SELECT_PRODUCTS_BY_PRICE_IN_RANGE = "SELECT id, name, category, unit_price, stock, release_date, photo_url, description, discount, status,"
				+ " unit_price*(100-discount)/100 as price "
				+ " FROM products"
				+ " WHERE unit_price * (100 - discount) / 100 BETWEEN ? AND ?";
				//PreparedStatement會自動轉型
		List<Product> SelectProductsByPriceInRange(String minPrice, String maxPrice) throws CSException{
			List<Product> list = new ArrayList<>();
			
			try(
					Connection connection = MySQLConnection.getConnection();//1.&2.載入Driver並取得連線	
					PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCTS_BY_PRICE_IN_RANGE); //3.準備指令
					){
					//3.1傳入?的值
					pstmt.setString(1,minPrice);
					pstmt.setString(2,maxPrice);
				
					try(
							ResultSet rs= pstmt.executeQuery(); //4.執行SELECT指令
							){
							//5.讀取rs
							while(rs.next()) { //資料庫查詢不確定會查詢到幾筆所以用while(0-多)
								Product p;
								int discount = rs.getInt("discount"); //先讀取discount的值
			 					if(discount==0) { 
									p = new Product(); //如果discount是0,就建立成Product類別的物件
								}else {
									p = new SpecialOffer(); //如果discount不是0,就建立成SpecialOffer類別的物件
									((SpecialOffer)p).setDiscount(discount); //把discount的值設定成p物件的屬性discount,但是Product類別沒有discount屬性及方法,所以要強轉成SpecialOffer
								}
			 					
			 					//從資料庫讀取資料後給p物件回傳
								p.setId(rs.getInt("id"));
								p.setName(rs.getString("name"));
								p.setCategory(rs.getString("category"));
								p.setUnitPrice(rs.getDouble("unit_price"));
								p.setStock(rs.getInt("stock"));
								p.setReleaseDate(rs.getString("release_date"));
								p.setPhotoUrl(rs.getString("photo_url"));
								p.setDescription(rs.getString("description"));
								p.setStatus(rs.getInt("status"));
								
								list.add(p);						
							}				
						}
					} catch (SQLException e) {
						//throw new RuntimeException("[依分類查詢產品]失敗",e);
						throw new CSException("[依價格區間查詢產品]失敗",e);
					}
			return list;
		}
		
		// SQL查詢語句，用於通過ID選擇產品
		private static final String SELECT_PRODUCT_BY_ID =  " SELECT id, name, category, products.unit_price, products.stock, release_date, products.photo_url, description, discount, status, "
				+ "		product_id, spec_name, product_specs.unit_price AS list_price, product_specs.unit_price*(100-discount)/100 AS price, product_specs.stock AS spec_stock,  product_specs.photo_url AS spec_photo"
				+ "			FROM products LEFT JOIN product_specs	ON products.id = product_specs.product_id"
				+ "				WHERE products.id = ?";
				
				//"SELECT id, name, category, unit_price, stock, release_date, photo_url, description, discount\r\n"
				//+ " FROM products WHERE id = ?";
		
		// 方法：通過ID查詢產品
		Product selectProductById(String id) throws CSException{
			Product p = null; // 用於存儲查詢結果的Product列表
			
			try (
				Connection connection = MySQLConnection.getConnection(); //1., 2.取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCT_BY_ID); //3.準備指令	
			){
				//3.1傳入?的值
				pstmt.setString(1, id);
				
				try(
					ResultSet rs = pstmt.executeQuery(); //4.執行指令	
				){	
					//5.處理rs
					while(rs.next()) { //資料庫的資料指標在第一筆之前所以要.next()
						if(p==null) {
							int discount = rs.getInt("discount"); //先讀取discount的值
		 					if(discount==0) { 
								p = new Product(); //如果discount是0,就建立成Product類別的物件
							}else {
								p = new SpecialOffer(); //如果discount不是0,就建立成SpecialOffer類別的物件
								((SpecialOffer)p).setDiscount(discount); //把discount的值設定成p物件的屬性discount,但是Product類別沒有discount屬性及方法,所以要強轉成SpecialOffer
							}		 					
		 					// 設定產品屬性
							p.setId(rs.getInt("id"));
							p.setName(rs.getString("name"));
							p.setCategory(rs.getString("category"));
							p.setUnitPrice(rs.getDouble("unit_price"));
							p.setStock(rs.getInt("stock"));
							p.setReleaseDate(rs.getString("release_date"));
							p.setPhotoUrl(rs.getString("photo_url"));
							p.setDescription(rs.getString("description"));
							p.setStatus(rs.getInt("status"));
						}
						
						//讀取Spec資料
						String product_specs = rs.getString("spec_name");
						if(product_specs != null) {
							Spec spec = new Spec();
							spec.setSpecName(product_specs);
							spec.setStock(rs.getInt("spec_stock"));
							spec.setListPrice(rs.getDouble("list_price"));
							spec.setPrice(rs.getDouble("price"));
							spec.setPhotoUrl(rs.getString("spec_photo"));
							
							p.add(spec); // 將Spec添加到產品中
						}
					}	
				}				
			} catch (SQLException e) {
				 // 捕獲SQL異常並拋出自定義異常
				throw new CSException("[用id查詢產品]失敗",e);
			}
			
			return p; // 返回查詢到的產品
		}
	
		
		private static final String SELECT_STOCK_BY_PRODUCTID_SPECNAME = "SELECT id,name,"
				+ " IFNULL(product_specs.spec_name,'') as spec_name,"
				+ " IFNULL(product_specs.stock, products.stock) as stock"
				+ " FROM products 	LEFT JOIN product_specs ON products.id=product_specs.product_id"
				+ " WHERE products.id = ?"
				+ "	HAVING spec_name= ?";
		
		int selectStockByProductIdSpecName(int productId, String specName) throws CSException{
			int stock = 0;
			
			try (
					Connection connection = MySQLConnection.getConnection(); //1&2.建立連線
					PreparedStatement pstmt = connection.prepareStatement(SELECT_STOCK_BY_PRODUCTID_SPECNAME); //3.準備指令
					){
				
					//3.1傳入?值
					pstmt.setInt(1, productId);
					pstmt.setString(2, specName==null?"":specName);
					
				try(ResultSet rs = pstmt.executeQuery()){
					while (rs.next()) {
						stock = rs.getInt("stock");
					}
				}				
					
			} catch (SQLException e) {
				throw new CSException("[查詢產品庫存]失敗",e);
			}
			
			return stock;
		}
		
	    private static final String UPDATE_PRODUCT = "UPDATE products SET name=?, category=?, unit_price=?, stock=?, release_date=?, photo_url=?, description=?,discount=? WHERE id=?";

	    void updateProduct(SpecialOffer product) throws CSException {
	        try (
	        		Connection connection = MySQLConnection.getConnection(); //1.2.建立連線
	            	PreparedStatement pstmt = connection.prepareStatement(UPDATE_PRODUCT); //3.準備指令
	            	){
	        	
		        	//3.1傳入?的值
		            pstmt.setString(1, product.getName());
		            pstmt.setString(2, product.getCategory());
		            pstmt.setDouble(3, product.getListPrice());
		            pstmt.setInt(4, product.getStock());
		            pstmt.setString(5, product.getReleaseDate().toString());
		            pstmt.setString(6, product.getPhotoUrl());
		            pstmt.setString(7, product.getDescription());
		            pstmt.setInt(8, product.getDiscount());
		            pstmt.setInt(9, product.getId());
		            
		            //4.執行指令
		            pstmt.executeUpdate();
		            
	        } catch (SQLException e) {
	            throw new CSException("更新商品失敗", e);
	        }
	    }
	    
	    //TODO:改成上架/下架
	    private static final String DELETE_PRODUCT = "DELETE FROM products WHERE id=?";

	    void deleteProduct(int id) throws CSException {
	        try (
	        		Connection connection = MySQLConnection.getConnection(); //1.2.建立連線
	        		PreparedStatement pstmt = connection.prepareStatement(DELETE_PRODUCT) //3.準備指令
	        		){
	        	
	        		//3.1傳入?值
	            	pstmt.setInt(1, id);
	            	
	            	//4.執行指令
	            	pstmt.executeUpdate();
	            	
	        } catch (SQLException e) {
	            throw new CSException("刪除商品失敗", e);
	        }
	    }

	    private static final String INSERT_PRODUCT = "INSERT INTO products (name, category, unit_price, stock, release_date, photo_url, description) VALUES (?, ?, ?, ?, ?, ?, ?)";
	    
	    void insertProduct(Product product) throws CSException {
	        try (Connection connection = MySQLConnection.getConnection();
	             PreparedStatement pstmt = connection.prepareStatement(INSERT_PRODUCT)) {

	            pstmt.setString(1, product.getName());
	            pstmt.setString(2, product.getCategory());
	            pstmt.setDouble(3, product.getUnitPrice());
	            pstmt.setInt(4, product.getStock());
	            pstmt.setString(5, product.getReleaseDate().toString());
	            pstmt.setString(6, product.getPhotoUrl());
	            pstmt.setString(7, product.getDescription());

	            pstmt.executeUpdate();
	        } catch (SQLException e) {
	            throw new CSException("新增商品失敗", e);
	        }
	    }
	    
	    private static final String SELECT_PRODUCTID = "SELECT id FROM products WHERE name = ?";
	    
	    int selectProductId(String name) throws CSException {
	    	int id = 0;
	        try (
	        		Connection connection = MySQLConnection.getConnection(); //1.&2.建立連線
		             PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCTID) //3.準備指令
		            ){
	        		//3.1 傳入?的值
		            pstmt.setString(1, name);
		            
					try(
							ResultSet rs= pstmt.executeQuery(); // 4. 執行SELECT指令，獲取結果
							){
							
							//5.讀取rs
							if(rs.next()) {
								id = (rs.getInt("id"));
							} else {
								throw new CSException("查不到產品"); 
							}
					}
			} catch (SQLException e) {
				throw new CSException("[查詢產品id]失敗",e); 
			} 
			return id; // 返回包含所有產品的列表
	    }
	    
	    private static final String UPDATE_PHOTO_URL = "UPDATE products SET photo_url =? WHERE id = ?";
		void UpdatePhotoUrl(String photourl, int productId) throws CSException {
	        try (
	        		Connection connection = MySQLConnection.getConnection(); //1.&2.建立連線
		             PreparedStatement pstmt = connection.prepareStatement(UPDATE_PHOTO_URL) //3.準備指令
		            ){
	        		//3.1 傳入?的值
		            pstmt.setString(1, photourl);
		            pstmt.setInt(2, productId);
		            
		            pstmt.executeUpdate(); //4.執行指令
		            
			} catch (SQLException e) {
				throw new CSException("[更新產品圖片]失敗",e); 
			} 
		}
		private static final String UPDATE_STATUS = "UPDATE products SET status =? WHERE id = ?";
		void updateStatus(String productId, String status)  throws CSException {
	        try (
	        		Connection connection = MySQLConnection.getConnection(); //1.&2.建立連線
		             PreparedStatement pstmt = connection.prepareStatement(UPDATE_STATUS) //3.準備指令
		            ){
	        		//3.1 傳入?的值
		            pstmt.setString(1, status);
		            pstmt.setString(2, productId);
		            
		            pstmt.executeUpdate(); //4.執行指令
		            
			} catch (SQLException e) {
				throw new CSException("[更新產品狀態]失敗",e); 
			} 			
		}

}
