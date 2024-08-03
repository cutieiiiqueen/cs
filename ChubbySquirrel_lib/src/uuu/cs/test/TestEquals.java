package uuu.cs.test;

import uuu.cs.entity.Customer;
import uuu.cs.entity.Product;
import uuu.cs.entity.SpecialOffer;
import uuu.cs.entity.VIP;

public class TestEquals {
	public static void main(String[] args) {
		
		String s = "Hello"; //都沒有字串時會自動new一個新的物件
		String s1 = "Hello"; //String pool:不要浪費字串物件，直接將s指派給s1 //改了就等於new新物件
		String s2 = new String ("Hello");  //new一個新的物件
		
		System.out.println("s1變大寫:"+s1.toUpperCase());
		System.out.println("s1:"+s1);
		System.out.printf("s==s1:%s\n" , s==s1);//==是否用到同一個物件
		System.out.printf("s==s2:%s\n" , s==s2);
		System.out.println("s.equals(s1): "+s.equals(s1));//equals物件內容是否相同
		System.out.println("s.equals(s2): "+s.equals(s2));
		
//		s1 += " World";
//		
//		System.out.println(s);
//		System.out.println(s1);
//		
//		System.out.println(s==s1);
//		System.out.println(s.equals(s1));
		System.out.println();
		Customer c1 = new Customer("A123123123", "張三豐", "12345678");
		c1.setEmail("test123@uuu.com.tw");
		Customer c2 = new Customer(new String("A123123123"), "張三豐", "12345678");
		c2.setEmail("test123@uuu.com.tw");
		Customer c3 = new Customer("A123123123", "張三豐", "12345678");
		c1.setEmail("test123@uuu.com.tw");
		System.out.printf("c1==c2:%s\n",c1==c2);//false, c1跟c2有沒有參考到同一個物件
		System.out.printf("c1==c3:%s\n",c1==c3);//false, c1跟c2有沒有參考到同一個物件
		//System.out.printf("c1.getId()==c2.getId():%s\n",c1.getId() == c2.getId());//false
		//System.out.printf("c1.getId()==c3.getId():%s\n",c1.getId() == c3.getId());//true //String poor
		System.out.printf("c1.equals(c2):%s\n",c1.equals(c2));	//true, 覆蓋Customer類別equals方法
		System.out.printf("c1.equals(c3):%s\n",c1.equals(c3));	//true, 覆蓋Customer類別equals方法
		System.out.println();
		
		VIP vip = new VIP();
		//vip.setId("A123123123");
		VIP vip1 = new VIP();
		//vip1.setId("A123123123");
		
		System.out.printf("c1.equals(c2):%s\n",c1.equals(c2)); //true
		System.out.printf("c1.equals(vip):%s\n",c1.equals(vip)); //true
		System.out.printf("vip.equals(vip1):%s\n",vip.equals(vip1)); //true
		
		System.out.println();
		Product p1 = new Product(2,"經典腰果",250,10);
		Product p2 = new Product(2,"腰果",250,10);
		SpecialOffer so1 = new SpecialOffer();
		so1.setId(2);
		so1.setName("經典腰果");
		so1.setStock(10);
		so1.setDiscount(10);
		
		System.out.printf("p1.equals(p2):%s\n",p1.equals(p2)); 
		//false, 覆蓋Product類別equals方法後即為true
		System.out.printf("p1.equals(so1):%s\n",p1.equals(so1)); 
		//false, 覆蓋Product類別equals方法後即為false -> 不同類別
	
	}

	
	
}
