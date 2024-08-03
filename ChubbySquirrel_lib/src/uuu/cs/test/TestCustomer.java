package uuu.cs.test;

import java.io.File;
import java.time.LocalDate;

import uuu.cs.entity.Customer;

public class TestCustomer {
	public static void main(String[] args) {
		
		Customer customer = new Customer();
		
		//指派屬性的值
//		customer.setId("A123456789");
		customer.setEmail("test123@uuu.com.tw");
		customer.setPhone("0987654321");
		customer.setPassword("12345;Lkj");
		customer.setName("狄會貴");
		customer.setGender('M'); //77;
		customer.setBirthday(LocalDate.of(2000, 01, 12));		
		
//		System.out.printf("customer.id: %s\n", customer.getId());
//		System.out.printf("customer.name: %s\n", customer.getName());
//		System.out.printf("customer.password長度: %s\n",
//				customer.getPassword()!=null?customer.getPassword().length():"沒有密碼");
//		System.out.printf("customer.phone: %s\n", customer.getPhone());
//		System.out.printf("customer.email: %s\n", customer.getEmail());
//		System.out.printf("customer.gender: %s\n", customer.getGender());
//		System.out.printf("customer.birthday: %s\n", customer.getBirthday());
//		
//		System.out.printf("customer.address: %s\n", customer.getAddress());
//		System.out.printf("customer.subscribed: %s\n", customer.isSubscribed());
		
		System.out.printf("customer:%s", customer.toString());
	}
}
