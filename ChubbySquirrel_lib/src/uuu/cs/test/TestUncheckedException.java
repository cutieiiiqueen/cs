package uuu.cs.test;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;

/**
 * 示範UnChecked Exception
 */
public class TestUncheckedException {
	public static void main(String[] args) {
		String s = null;
		//從資料庫查詢字串指派給s，查無此資料
		//System.out.println(s.length()); //Complier不會檢查
		//自己做Null檢查 (程式技巧防範)
		//System.out.println(s==null?null:s.length());
		if(s!=null) { 
			System.out.println(s.length()); //若無前一行判斷，這裡可能發生NullPointerException
		}
		int i = 0;
		//從資料庫查詢出來的整數指派給i，i為0
		if(i!=0) {
			System.out.println(1/i); //整數除法分母不得為0, 否則發生ArithmeticException
		}
		
		Object o = "Hello";
		System.out.println(((String)o).length());
		
		o = LocalDate.now();
		if(o instanceof String) {
			System.out.println(((String)o).length()); //若無前一行判斷，這裡可能發生ClassCastException
		}else {
			System.err.printf("o參考的不是String物件, 而是%s\n",o.getClass().getSimpleName());
		}
		
		int k[] = {1, 2, 3};
		if(k.length>=4) {
			System.out.println(k[3]); //若無前一行判斷，這裡可能發生ArrayIndexOutOfBoundsException
		}else {
			System.out.printf("k[]中只有%s元素\n",k.length);
		}
		
		s = "ABC";
		if(s!=null && s.matches("\\d+")) {
			int m = Integer.parseInt(s);
			System.out.println(m); //若無前一行判斷，這裡可能發生NumberFormatException
		}
		
		s = "1990/5/5";
		//if(s!=null && s.matches("")) { //iso8601日期檢核不好寫，直接改用try(讓他當掉後出現錯誤訊息)
		try{
			System.out.println(LocalDate.parse(s)); //DateTimeParseException
		}catch(DateTimeParseException e) {
			System.err.printf("s的內容無法轉換成日期: %s\n",s);
		}
	}
}
