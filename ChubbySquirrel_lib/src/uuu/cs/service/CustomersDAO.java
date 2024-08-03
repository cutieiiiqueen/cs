package uuu.cs.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

import uuu.cs.entity.Customer;
import uuu.cs.entity.VIP;
import uuu.cs.exception.CSDataInvalidException;
import uuu.cs.exception.CSException;

class CustomersDAO {
	
	private static final String SELECT_CUSTOMER_BY_ID = "SELECT email, phone, password, name, gender, "
			+ "birthday, address, discount FROM customers"
			+ " WHERE email=? OR phone=?";
	
	Customer selectCustomerById(String id) throws CSException {
		Customer c = null; 
		
		try (
			Connection connection = MySQLConnection.getConnection();//1&2 載入Driver並取得連線
			PreparedStatement pstmt = connection.prepareStatement(SELECT_CUSTOMER_BY_ID); //3.準備指令
		){
			//3.1傳入?的值
			pstmt.setString(1,id);
			pstmt.setString(2,id);
			
			try(
					ResultSet rs = pstmt.executeQuery(); //4.執行SELECT指令
			){
				//5.讀取rs
				//會員登入
				//從資料庫讀取資料後定給c物件(為了回傳到前端)
				while(rs.next()) {
					int discount = rs.getInt("discount");
					if(discount>0) {
						c = new VIP();
						((VIP)c).setDiscount(discount);
					}else {
						c = new Customer();
					}
					c.setEmail(rs.getString("email"));
					c.setPhone(rs.getString("phone"));
					c.setPassword(rs.getString("password"));
					c.setName(rs.getString("name"));
					c.setGender(rs.getString("gender").charAt(0));
					c.setBirthday(rs.getString("birthday"));
					c.setAddress(rs.getString("address"));
				}
			}
			return c;
		} catch (SQLException e) {
			//throw new RuntimeException("查詢客戶失敗", e); //throw new XxxException
			throw new CSException("查詢客戶失敗", e); //拋出錯誤訊息讓前端知道
		}

	}
	
	private static final String INSERT_CUSTOMERS = "INSERT INTO customers (email,phone,password, name,gender,birthday,"
			+ " address)"
			+ "	VALUES (?,?,?, ?,?,?, ?)";
	
		void insert(Customer c) throws CSException{
			
			try(
					Connection connection = MySQLConnection.getConnection(); //1&2 載入Driver並取得連線
					PreparedStatement pstmt = connection.prepareStatement(INSERT_CUSTOMERS); //3.準備指令
					){
					//3.1傳入?的值
				
					//會員註冊
					//從c物件(前端)讀取資料後設定進資料庫
					pstmt.setString(1, c.getEmail());
					pstmt.setString(2, c.getPhone());
					pstmt.setString(3, c.getPassword());
					pstmt.setString(4, c.getName());
					pstmt.setString(5, (String.valueOf(c.getGender())));
					pstmt.setString(6, c.getBirthday().toString());
					pstmt.setString(7, c.getAddress());
				
					pstmt.executeUpdate();//4.執行指令
			
			
			}catch (SQLIntegrityConstraintViolationException e){
				//主鍵值重複
				String colName="email";
				//如果欄位是null
				if(e.getMessage().lastIndexOf("null")>0) {
					throw new CSException("建立客戶失敗" + e.getErrorCode(),e);
				//如果phone重複
				}else if (e.getMessage().lastIndexOf("phone_UNIQUE")>0) {
					colName="phone";
				}
				String errMsg = String.format("%s已經重複註冊", colName);
				throw new CSDataInvalidException(errMsg, e);
			}catch (SQLException e) {
				throw new CSException("建立客戶失敗"+e.getErrorCode(),e);
			}
		}
		
		
	private static final String UPDATE_CUSTOMERS = "UPDATE customers SET phone = ?, password = ?, name = ?, gender = ?, address = ?"
			+ " WHERE (email = ?)";
	
		void update(Customer c) throws CSException {
			
			try (
				Connection connection = MySQLConnection.getConnection();//1&2 載入Driver並取得連線
				PreparedStatement pstmt = connection.prepareStatement(UPDATE_CUSTOMERS); //3.準備指令
			){
				//3.1傳入?的值
				pstmt.setString(1,c.getPhone());
				pstmt.setString(2,c.getPassword());
				pstmt.setString(3,c.getName());
				pstmt.setString(4,(String.valueOf(c.getGender())));
				pstmt.setString(5,c.getAddress());
				pstmt.setString(6,c.getEmail());
				
				pstmt.executeUpdate();//4.執行指令
				
			}catch (SQLIntegrityConstraintViolationException e){
				//主鍵值重複
				String colName="email";
				//如果欄位是null
				if(e.getMessage().lastIndexOf("null")>0) {
					throw new CSException("[修改客戶]失敗" + e.getErrorCode(),e);
				//如果phone重複
				}else if (e.getMessage().lastIndexOf("phone_UNIQUE")>0) {
					colName="phone";
				}
				String errMsg = String.format("%s已經與其他客戶重複", colName);
				throw new CSDataInvalidException(errMsg, e);
			}catch (SQLException e) {
				throw new CSException("建立客戶失敗"+e.getErrorCode(),e);
			}
				
		}
		
		
	private static final String UPDATE_PASSWORD = "UPDATE customers"
			+ " SET password = ?"
			+ " WHERE email = ? OR phone = ?";
	
		void updatePassword(Customer c) throws CSException {
			
			try (
				Connection connection = MySQLConnection.getConnection();//1&2 載入Driver並取得連線
				PreparedStatement pstmt = connection.prepareStatement(UPDATE_PASSWORD); //3.準備指令
			){
				//3.1傳入?的值
				pstmt.setString(1,c.getPassword());
				pstmt.setString(2,c.getEmail());
				pstmt.setString(3,c.getPhone());
				
				pstmt.executeUpdate();//4.執行指令
				
			} catch (SQLException e) {
				throw new CSException("更新客戶密碼失敗", e); //拋出錯誤訊息讓前端知道
			}
				
		}
	
		private static final String SELECT_ALL_CUSTOMER = "SELECT email, phone, password, name, gender, birthday, address, discount FROM customers";
		//查詢所有用戶
		List<VIP> selectAllCustomer() throws CSException {
			List<VIP> list = new ArrayList<>();
			try (
				Connection connection = MySQLConnection.getConnection();//1&2 載入Driver並取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ALL_CUSTOMER); //3.準備指令
			){
				VIP vip = null; 
				try(
						ResultSet rs = pstmt.executeQuery(); //4.執行SELECT指令
				){
					//從資料庫讀取資料後定給c物件(為了回傳到前端)
					while(rs.next()) {
						vip = new VIP();
						
						vip.setEmail(rs.getString("email"));
						vip.setPhone(rs.getString("phone"));
						vip.setPassword(rs.getString("password"));
						vip.setName(rs.getString("name"));
						vip.setGender(rs.getString("gender").charAt(0));
						vip.setBirthday(rs.getString("birthday"));
						vip.setAddress(rs.getString("address"));
						vip.setDiscount(rs.getInt("discount"));
						list.add(vip);
					}
				}
				return list;
			} catch (SQLException e) {
				throw new CSException("查詢全部客戶失敗", e); 
			}

		}
		
		private static final String UPDATE_CUSTOMER = "UPDATE customers SET phone = ?, password = ?, name = ?, gender =?, birthday = ?,address = ?, discount = ? WHERE email = ?";
		
        void updateCustomer(VIP c) throws CSException {
			
			try (
				Connection connection = MySQLConnection.getConnection();//1&2 載入Driver並取得連線
				PreparedStatement pstmt = connection.prepareStatement(UPDATE_CUSTOMER); //3.準備指令
			){
				//3.1傳入?的值
				pstmt.setString(1,c.getPhone());
				pstmt.setString(2,c.getPassword());
				pstmt.setString(3,c.getName());
				pstmt.setString(4, (String.valueOf(c.getGender())));
				pstmt.setString(5,c.getBirthday().toString());
				pstmt.setString(6,c.getAddress());
				pstmt.setDouble(7,c.getDiscount());
				pstmt.setString(8,c.getEmail());
								
				pstmt.executeUpdate();//4.執行指令
				
			}catch (SQLException e) {
				throw new CSException("修改客戶失敗"+e.getErrorCode(),e);
			}
		}
        
        private static final String DELETE_CUSTOMER = "delete from customers WHERE email = ?";
        
        void delete(String email) throws CSException {
			
			try (
				Connection connection = MySQLConnection.getConnection();//1&2 載入Driver並取得連線
				PreparedStatement pstmt = connection.prepareStatement(DELETE_CUSTOMER); //3.準備指令
			){
				//3.1傳入?的值
				pstmt.setString(1,email);
				
				pstmt.executeUpdate();//4.執行指令
				
			}catch (SQLException e) {
				throw new CSException("刪除客戶失敗"+e.getErrorCode(),e);
			}
		}
	
}


