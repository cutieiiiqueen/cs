package uuu.cs.test;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import uuu.cs.entity.Product;

public class TestWrapperClasses {
	public static void main(String[] args) {
		//將String資料轉換成對應的基本型別
		String qtyString = "5";
		int qty = Integer.parseInt(qtyString); //String資料轉為int型別
		
		String sizeString = "9.5";
		double size = Double.parseDouble(sizeString); //String資料轉為double型別
		
		double price = 2000; //from database
		
		System.out.printf("%s尺寸的鞋子:%s雙, 共%s元\n",size,qty,price*qty);
				
		String subscribedString = "true";
		boolean subscribed = Boolean.parseBoolean(subscribedString); //String資料轉為boolean
		System.out.printf("%s訂閱電子報\n",subscribed?"要":"不"); 
		
		String genderString = "M";
		char gender = genderString.charAt(0); //String資料轉為char型別
		System.out.println(gender);
//		char gender = Character.perseChar("M"); //無此方法, 要用charAt()
		
		//box:將基本型別建立為對應的包裝類別的物件
		byte a = 1;
		Byte theA = a; //Byte theA = new Byte(a); //boxing, java 5.0後可以藉由auto-boxing自動完成,不用new
		Byte theOne = 1; 
		//Byte theOne = new Byte(1)        ->(X), 因為宣告成Byte的一定要是byte的值, 這裡的1會當成int
		//Byte theOne = new Byte((byte)1)
		
		List<Byte> byteList = new ArrayList<>();		
		List<Byte> byteList1 = new LinkedList<>();		
		byteList.add(a); //等同 byteList.add(new Byte(a)); //JDK 5.0以前無法編譯, java 5.0後可以藉由auto-boxing自動完成(先auto-boxing為Byte物件，再加入集合)
		byteList.add(theA);
		byteList.add(theOne);
		//List<byte> byteList = new ArrayList<>(); ->(X), 編譯失敗, 基本型別不能加入集合物件(List/Set/Map)中
		
		List<Integer> qtyList = new ArrayList<>();
		qtyList.add(1); //auto-boxing為Integer物件，再加入集合
		
		List<Product> productsList = new ArrayList<>();
		
		//double d = 1; -> promotion
		//Double d = 1; -> Double d = new Integer(1); ->(X), 先將int的1,auto-boxing為Integer物件，無法指派給Double型別的變數
		Double d = new Double(1);
		Double d1 = 1D;                             //->(O), auto-boxing為Double物件，再指派給Double型別的變數
		Double d2 = 1.0;                            //->(O), auto-boxing為Double物件，再指派給Double型別的變數
		Double d3 = (double)1;                      //->(O), 先將int的1轉型成double, 再auto-boxing為Double物件，指派給Double型別的變數
		
		
		//unboxing
		//[課程練習-Mod10-partII,第一題]
		Integer var1 = 1;
		Double var2 = 2.2;
		Float var3 = 3.5F;
		
		Number var4 = var1.intValue()+var2.doubleValue()+var3.floatValue(); //unboxing, 可執行
		Number var5 = var1+var2+var3; //先auto-unboxing(Integer.intValue, Double.doubleValue, Float.floatValue), 再auto-boxing包裝成Double物件, 指派給多型的變數
		System.out.println(var4);
		System.out.println(var5);
		
		Number var6 = 1;
		Number var7 = 2.2;
		//Number var8 = var6+var7; //-> (X), 因為會不知道要用哪一個(intValue, doubleVale,floatValue)
		Number var9 = var6.intValue()+var7.doubleValue();
		System.out.println(var9);
		
		//String和8個Wrapper Class的物件是immutable/constants
		Integer theI = 1;
		Integer theJ = theI;
		theI++; //Java 5.0才可以
		System.out.printf("theI:%s, theJ:%s \n",theI,theJ);
		
		//theI++又等於下面:
		//int data = theI.intValue();
		//data++;
		//theI = new Integer(data);
		
		
	}
}
