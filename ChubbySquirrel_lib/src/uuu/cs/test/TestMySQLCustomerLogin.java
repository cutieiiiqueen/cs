package uuu.cs.test;

import java.sql.*;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.cs.entity.Customer;

public class TestMySQLCustomerLogin {
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
			final String sql = "SELECT email, phone, password, name, gender, "
					+ "birthday, address, discount FROM customers";
			try {
				Class.forName(driver); //1.載入Driver
				
				try (
						Connection connection = DriverManager.getConnection(url, userid, pwd); //2.建立連線
						Statement stmt = connection.createStatement(); //3.建立指令物件
						ResultSet rs = stmt.executeQuery(sql); //4.執行指令
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
							
							System.out.println(c);
						}
					
					} catch (SQLException e) {
						//e.printStackTrace();
						Logger.getLogger("MySQLCustomerLogin").log(Level.SEVERE, "建立連線失敗", e);
					}
				
			} catch (ClassNotFoundException e) { 
				//e.printStackTrace();
				Logger.getLogger("MySQLCustomerLogin").log(Level.SEVERE, "載入JDBC Driver失敗", e);
			}
		}
}
