package uuu.cs.test;

import java.time.LocalDate;

import uuu.cs.entity.Customer;
import uuu.cs.entity.VIP;

public class TestPolymophism {

	public static void main(String[] args) {
		Object o1 = new Object(); //一般的宣告和指派
		Object o2 = "Hello";  //多型的宣告
		String s = "Hello"; //一般的宣告
		
		System.out.printf("o1.toString():%s\n",o1.toString()); //java.lang.Object@5aaa6d82
		System.out.printf("o2.toString():%s\n",o2.toString()); //Hello //只可以用到Object的11支程式 //舊方法新邏輯
//		System.out.printf("o2.length():%s\n",o2.length()); // compile-time error
//		System.out.printf("o2.charAt():%s\n",o2.charAt(0)); // compile-time error
		System.out.printf("((String)o2).length():%s\n",((String)o2).length()); // 轉型後就恢復String特有功能, 5
		
		o2 = LocalDate.now();
		//if(o2 instanceof String) {
		if(o2.getClass()==String.class) {
			System.out.printf("((String)o2).charAt():%s\n",((String)o2).charAt(0)); // 轉型後就恢復String特有功能, H
		}
		
		
		System.out.printf("s.toString():%s\n",s.toString()); //Hello
		System.out.printf("s.length():%s\n",s.length()); //5
		System.out.printf("s.charAt():%s\n",s.charAt(0)); //H
		
//		Object o3 = 1;
//		System.out.println(o3.toString());
//		Number n1 = 1.0;
		
		Customer c = new Customer("A123456001","韓諾亞","@Haminyu1101Gmail",'F');
		Customer c2 = new VIP();

	}

}
