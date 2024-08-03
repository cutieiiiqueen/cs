package uuu.cs.test;

import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.cs.entity.Customer;
import uuu.cs.exception.CSDataInvalidException;
import uuu.cs.exception.CSException;
import uuu.cs.service.CustomerService;

public class TestCustomerService_register {

	public static void main(String[] args) {
		Customer c = new Customer();
		c.setEmail("n1006406@gmail.com");
		c.setPhone("0912345678");
		c.setPassword("@N1006406Gmail");
		c.setName("克蘿伊");
		c.setGender(Customer.FEMALE);
		c.setBirthday("1992-10-15");
		
		CustomerService cService = new CustomerService();
		
		try {
			cService.register(c);
			System.out.println("註冊成功!");
		} catch (CSDataInvalidException e) { //使用者輸入資料有誤
			System.out.println(e.getMessage()); //for user
		} catch (CSException e) { 
			Logger.getLogger("").log(Level.SEVERE, e.getMessage(), e); //for admin, developer, tester
			System.out.println(e.getMessage()+" 請聯絡管理人員(Admin)"); //for user
		} catch (Exception e) { 
			Logger.getLogger("").log(Level.SEVERE, "發生非預期錯誤", e);
			System.out.println("發生系統錯誤: " + e.getMessage() +" 請聯絡管理人員(Admin)");
		}
	}

}
