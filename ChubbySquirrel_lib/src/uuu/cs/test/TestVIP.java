package uuu.cs.test;

import uuu.cs.entity.VIP;

public class TestVIP {
	public static void main(String[] args) {
		VIP vip = new VIP();
		//vip.setId("A123123123");
		vip.setEmail("test123123@uuu.com.tw");
		vip.setPhone("0912345678");
		vip.setPassword("123456;Lkj");
		vip.setName("張三豐");
		vip.setGender('M');
		vip.setBirthday("2001-01-01");
		vip.setDiscount(10);
		
//		System.out.printf("vip.id: %s\n", vip.getId());
//		System.out.printf("vip.name: %s\n", vip.getName());
//		System.out.printf("vip.password長度: %s\n", 
//				vip.getPassword()!=null?vip.getPassword().length():"沒有密碼");
//		System.out.printf("vip.phone: %s\n", vip.getPhone());
//		System.out.printf("vip.email: %s\n", vip.getEmail());
//		System.out.printf("vip.gender: %s\n", vip.getGender());
//		System.out.printf("vip.birthday: %s\n", vip.getBirthday());
//		System.out.printf("vip: %s享有 %s 優惠\n",vip.getName(), vip.getDiscountString());
//		System.out.printf("vip.discount: %s%% off\n", vip.getDiscount());
		
		System.out.printf("vip:%s",vip);
	}
}
