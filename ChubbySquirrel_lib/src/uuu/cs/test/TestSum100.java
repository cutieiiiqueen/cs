package uuu.cs.test;

public class TestSum100 {
	public static void main(String[] args) {
		int sum = 0;
		for(int i=1;i<=100;i++) {
			sum += i; //=放左邊->sum = sum+i
		}
		System.out.println(sum);
		
		byte a=1, b=1, d=(byte)(a+b);
		double c=2.5;
		a*=b-c; 
		//->a=(byte)(a*(b-c)); 
		//a = a*(b-c); X
		System.out.println(a);
		System.out.println(d);
		
		char ch = '1';
		ch *= '2'; //s= s*'2' -> 49*50
		System.out.println((int)ch);
		
		String s = "Hello";
		System.out.println(s+" world");
	}	
}
