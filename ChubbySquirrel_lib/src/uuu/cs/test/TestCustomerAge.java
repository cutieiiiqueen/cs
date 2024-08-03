package uuu.cs.test;

import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.cs.entity.Customer;
import uuu.cs.exception.CSDataInvalidException;

public class TestCustomerAge {
	public static void main(String[] args) {
		try {
		Customer customer = new Customer();
		
		//指派屬性的值
		//customer.setId("A123123123");
		customer.setEmail("test123@uuu.com.tw");
		customer.setPhone("0987654321");
		//customer.password = "12345;Lkj"; //2024-03-25, Customer的password屬性已經完成封裝
		customer.setPassword("12345;Lkj");
		//customer.name = "狄會貴"; //2024-03-25, Customer的name屬性已經完成封裝
		customer.setName("狄會貴");
		customer.setGender('M'); //77;
		//customer.setGender((char)77);
		//customer.setBirthday("1998-01-12"); //若JDK8.0(含)以後使用java.time.LocalDate //若出生年為萬年前面要+ 
		//customer.setBirthday(1999,1,12);
		customer.setBirthday(LocalDate.of(2010, 01, 12));
//		customer.setBirthday((String)null);
		customer.setBirthday("2002/01/01");
		
		//customer.birthday = LocalDate.parse("2000-01-12"); //直接指派是最不好的方式
		//customer.birthday = new SimpleDateFormat("yyyy-MM-dd").parse("2000-01-12"); //若JDK7.0以前使用java.util.Date
				
//		System.out.printf("customer.id: %s\n", customer.getId());
//		System.out.printf("customer.name: %s\n", customer.getName());
//		System.out.printf("customer.password長度: %s\n", customer.getPassword()!=null?customer.getPassword().length():"沒有密碼");
//		System.out.printf("customer.phone: %s\n", customer.getPhone());
//		System.out.printf("customer.email: %s\n", customer.getEmail());
//		System.out.printf("customer.gender: %s\n", customer.getGender());
//		System.out.printf("customer.birthday: %s\n", customer.getBirthday());
//		
//		System.out.printf("customer.address: %s\n", customer.getAddress());
//		System.out.printf("customer.subscribed: %s\n", customer.isSubscribed());
		System.out.printf("customer:%s",customer);
		
		int age = customer.getAge()==null? -1:customer.getAge();
		System.out.printf("customer年齡為: %s歲\n",age);
		System.out.printf("customer年齡為: %s歲\n",Customer.getAge(LocalDate.of(2024,04,16)));
		//System.out.printf("customer id check: %s\n",Customer.checkId("C221422449"));
		System.out.printf("customer年齡為: %s歲\n",customer.getAge());
		
		}catch(CSDataInvalidException e) {
			System.err.println(e.getMessage());
		}catch(Exception e) {
			Logger.getLogger("").log(Level.SEVERE, "系統發生非預期錯誤", e);//for developer, admin, tester
			System.err.println("系統發生錯誤" + e.getMessage()+", 請聯絡系統管理人員(admin)"); //for user
		}

	}
}
