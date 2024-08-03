package uuu.cs.test;

import java.sql.*;
import java.util.ResourceBundle;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.cs.entity.Customer;
import uuu.cs.service.CustomerService;
//import uuu.cs.service.MySQLConnection; //因為MySQLConnection已經改為default，所以不能import

/**
 * 由PrepareedStatement防止SQL injection示範
 */
public class TestMySQLCustomerLogin_user_input_no_SQL_injection {

	public static void main(String[] args) {
		//1.輸入帳號, 密碼
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("請輸入帳號(email)或手機:");
		String id =  scanner.next(); //若輸入'OR''=', 會發生SQL Injection
		System.out.println("請輸入密碼:");
		String password = scanner.next();//若輸入'OR''=', 會發生SQL Injection

//		//2.呼叫商業邏輯
////			final String sql = String.format("SELECT email, phone, password, name, gender, "
////			+ "birthday, address, discount FROM customers"
////			+ " WHERE email='"+ email +"' AND password = '"+password +"';");
//		
////			final String sql = String.format("SELECT email, phone, password, name, gender, "
////					+ "birthday, address, discount FROM customers"
////					+ " WHERE email='%s' AND password = '%s';",email,password);
//		
//		final String sql = "SELECT email, phone, password, name, gender, "
//				+ "birthday, address, discount FROM customers"
//				+ " WHERE email=? OR phone=? AND password=?"; //String.format不用了，因為資料跟指令要分開，資料用?分開
//		
//		System.out.println(sql);
//		Customer c = null; //初始化 //假設查不到s若沒有給初值就沒有結果可回傳
//					
//			try (
//					Connection connection = MySQLConnection.getConnection(); //(1)(2)載入Driver類別&取得連線						
//					PreparedStatement pstmt = connection.prepareStatement(sql); //(3)準備(有sql)指令
//					
//			 ){ //6.try-with-resources關閉物件寫在()裡面, Java 7
//				
//				//Driver diver1 = new com.mysql.cj.jdbc.Driver;  //降低耦合
//				
//				//(3.1) 傳入?的值
//				pstmt.setString(1, id);  //第1個?的值
//				pstmt.setString(2, id);  //第2個?的值
//				pstmt.setString(3, password);
//				
//				try(
//					ResultSet rs = pstmt.executeQuery(); //(4)執行指令
//				 ){
//						while(rs.next()) { ///(5)讀取rs
//							c = new Customer();
//							c.setEmail(rs.getString("email"));
//							c.setPhone(rs.getString("phone"));
//							c.setPassword(rs.getString("password"));
//							c.setName(rs.getString("name"));
//							c.setGender(rs.getString("gender").charAt(0));
//							c.setBirthday(rs.getString("birthday"));
//							c.setAddress(rs.getString("address"));
//							
//							//3.輸出結果
//							System.out.println(c);
//						}
//					}
//				} catch (SQLException e) {
//					//e.printStackTrace();
//					Logger.getLogger("MySQLCustomerLogin").log(Level.SEVERE, "準備/執行指令失敗", e);
//				}
//			
//				//搬到DAO, 3.輸出結果
//			
//				if(c!=null && password!=null && password.equals(c.getPassword())) {
//					System.out.printf("登入成功:%s\n",c);
//				}else {
//					System.out.printf("登入失敗, 帳號或密碼不正確");
//				}
		
		//2.呼叫商業邏輯
		CustomerService cService = new CustomerService(); 
		try{
			Customer c = cService.login(id, password);
			System.out.println("登入成功: "+c);
		}catch(Exception e) {
			Logger.getLogger("").log(Level.SEVERE, e.getMessage(),e); //for developer, admin, tester
//			System.err.println(e.getMessage()); //for user
		}
		System.out.println("The End");
	}
}
