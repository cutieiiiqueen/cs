package uuu.cs.test;

public class TestMath {
	public static void main(String[] args) {
		System.out.println(Math.round(5.5));//6, double
		System.out.println(Math.floor(5.7));//5, double
		System.out.println(Math.ceil(5.4));//6, double
		
		System.out.println(Math.floor(-5.5));//-6, double
		System.out.println(Math.ceil(-5.4));//-5, double
		
		long a = Math.round(5.5);
		int b = Math.round(5.5F);
		System.out.println(a);
		System.out.println(b);
		
		System.out.println(Math.PI);
		System.out.println(Math.E);
	}

}
