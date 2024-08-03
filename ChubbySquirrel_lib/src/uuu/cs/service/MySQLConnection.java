package uuu.cs.service;

import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.cs.exception.CSException;

import java.sql.*; //手動先載

class MySQLConnection {
	//blank (static) final variables: 
	private static final String driver;//="com.mysql.jdbc.Diver";
	private static final String url;//="jdbc:mysql://localhost:3306/cs(你的資料庫名稱)"; //blank static final屬性
	private static final String userid;//="root"; //mysql 內建管理者帳號
	private static final String pwd;//="1234"; //root的密碼

	static {
		ResourceBundle jdbcBundle = ResourceBundle.getBundle("uuu.cs.service.mysql_jdbc"); //如果換資料庫程式就改這邊
		
		driver = jdbcBundle.getString("jdbc.driver");
		//System.out.println(driver);
		
		url = jdbcBundle.getString("jdbc.url");
		//System.out.println(url);
		
		userid = jdbcBundle.getString("jdbc.userid");
		//System.out.println(userid);
		
		pwd = jdbcBundle.getString("jdbc.pwd");
		//System.out.println(pwd);
		
	}
	
	static Connection getConnection() throws CSException {
		
		try {
			Class.forName(driver);//1.載入Driver
			
			try {
				Connection connection = DriverManager.getConnection(url, userid, pwd);//2.建立連線
				return connection;
			} catch (SQLException e) {
				//e.printStackTrace();
				//Logger.getLogger("MySQLConnection").log(Level.SEVERE, "建立連線失敗", e);
				//throw new RuntimeException("連線失敗",e); //通知前端錯誤訊息 //改成throw new Xxx(專案名)Exception //throw new CSException (ChubbySquirrel)
				throw new CSException("連線失敗",e);
			} 
		} catch (ClassNotFoundException e) {
			//e.printStackTrace();
			//Logger.getLogger("MySQLConnection").log(Level.SEVERE,"載入JDBC Drive失敗", e); //for admin
//		    throw new RuntimeException("載入JDBC Drive失敗", e); //通知前端錯誤訊息 //TODO: 改成throw new CSException
			throw new CSException("連線失敗",e);
		} 	
		//return null; -> (X)  前端沒有收到錯誤訊息，當掉
	}
}
