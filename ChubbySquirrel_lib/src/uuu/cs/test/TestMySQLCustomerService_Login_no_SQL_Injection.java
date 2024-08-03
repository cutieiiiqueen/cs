package uuu.cs.test;

import java.sql.*;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import uuu.cs.entity.Customer;
import uuu.cs.exception.CSDataInvalidException;
import uuu.cs.exception.CSException;
import uuu.cs.exception.LoginFailedException;
import uuu.cs.service.CustomerService;

/**
 * 由PrepareedStatement防止SQL injection示範
 */
public class TestMySQLCustomerService_Login_no_SQL_Injection {

	public static void main(String[] args) {
		//1.輸入帳號, 密碼
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("請輸入帳號(email)或手機:");
		String id =  scanner.next(); //若輸入'OR''=', 會發生SQL Injection
		System.out.println("請輸入密碼:");
		String password = scanner.next();//若輸入'OR''=', 會發生SQL Injection

		//2.呼叫商業邏輯
		CustomerService cService = new CustomerService(); 
		try{
			Customer c = cService.login(id, password);
			System.out.println("登入成功: " + c);
		}catch(LoginFailedException e) {
			//Logger.getLogger("").log(Level.SEVERE, e.getMessage()+", 請聯絡系統管理人員(admin)",e); //for developer, admin, tester
			System.err.println(e.getMessage());
		}catch(CSException e){
			Logger.getLogger("").log(Level.SEVERE, e.getMessage()+", 請聯絡系統管理人員(Admin)",e); //for developer, admin, tester
			//System.err.println(e.getMessage()); //for user
		}catch(CSDataInvalidException e) {
			System.err.println(e.getMessage() + ", 請修改資料");//for user 
		}catch(Exception e) {
			Logger.getLogger("系統發生錯誤").log(Level.SEVERE, ", 請聯絡系統管理人員(Admin)",e); //for developer, admin, tester
			System.err.println(e.getMessage()); //for user
		}
		System.out.println("The End");
	}
}
