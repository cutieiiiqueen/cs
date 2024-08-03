package uuu.cs.test;

import java.sql.*;
import java.util.ResourceBundle;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.cs.entity.Customer;

/**
 * SQL injection示範
 */
public class TestMySQLCustomerLogin_user_input {
		//blank (static) final variables: 
		private static final String driver;//="com.mysql.jdbc.Diver";
		private static final String url;//="jdbc:mysql://localhost:3306/vgb"; //blank static final屬性
		private static final String userid;//="root"; //mysql 內建管理者帳號
		private static final String pwd;//="1234"; //root的密碼
	
		static {
			ResourceBundle jdbcBundle = ResourceBundle.getBundle("uuu.cs.service.mysql_jdbc");
			
			driver = jdbcBundle.getString("jdbc.driver");
			System.out.println(driver);
			
			url = jdbcBundle.getString("jdbc.url");
			System.out.println(url);
			
			userid = jdbcBundle.getString("jdbc.userid");
			System.out.println(userid);
			
			pwd = jdbcBundle.getString("jdbc.pwd");
			System.out.println(pwd);
			
		}

		public static void main(String[] args) {
			//1.輸入帳號, 密碼
			Scanner scanner = new Scanner(System.in);
			
			System.out.println("請輸入帳號(email):");
			String email =  scanner.next(); //若輸入'OR''=', 會發生SQL Injection
			System.out.println("請輸入密碼:");
			String password = scanner.next();//若輸入'OR''=', 會發生SQL Injection

			//2.呼叫商業邏輯
//			final String sql = String.format("SELECT email, phone, password, name, gender, "
//			+ "birthday, address, discount FROM customers"
//			+ " WHERE email='"+ email +"' AND password = '"+password +"';");
			
			final String sql = String.format("SELECT email, phone, password, name, gender, "
					+ "birthday, address, discount FROM customers"
					+ " WHERE email='%s' AND password = '%s';",email,password);
						
			System.out.println(sql);
			
			try {
				Class.forName(driver); //1.載入Driver
				
				try (
						Connection connection = DriverManager.getConnection(url, userid, pwd); //2.建立連線
						Statement stmt = connection.createStatement(); //3.建立空的(沒有sql)指令
						ResultSet rs = stmt.executeQuery(sql); //4.執行指令時才傳入(指令+資料)sql
					){ //6.try-with-resources關閉物件, Java 7
					
						while(rs.next()) { //5.讀取rs
							Customer c = new Customer();
							c.setEmail(rs.getString("email"));
							c.setPhone(rs.getString("phone"));
							c.setPassword(rs.getString("password"));
							c.setName(rs.getString("name"));
							c.setGender(rs.getString("gender").charAt(0));
							c.setBirthday(rs.getString("birthday"));
							c.setAddress(rs.getString("address"));
							
							//3.輸出結果
							System.out.println(c);
						}
					
					} catch (SQLException e) {
						//e.printStackTrace();
						Logger.getLogger("MySQLCustomerLogin").log(Level.SEVERE, "建立連線失敗", e);
					}
				
					//TODO: 搬到DAO, 3.輸出結果
				
			} catch (ClassNotFoundException e) { 
				//e.printStackTrace();
				Logger.getLogger("MySQLCustomerLogin").log(Level.SEVERE, "載入JDBC Driver失敗", e);
			}
		}
}
