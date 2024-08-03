package uuu.cs.test;

import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.cs.entity.Customer;
import uuu.cs.exception.CSDataInvalidException;
import uuu.cs.exception.CSException;
import uuu.cs.service.CustomerService;

public class TestCustomerService_update {

	public static void main(String[] args) {
		CustomerService cService = new CustomerService();
			
		try {
			Customer c = cService.login("test005@gmail.com", "qaz456");
			c.setEmail("test006@gmail.com");//PKEY 不可修改
			c.setPhone("0912345673");
			cService.update(c);
			System.out.println("會員修改成功!");
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
