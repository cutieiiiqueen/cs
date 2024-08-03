package uuu.cs.entity;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Objects;

import uuu.cs.exception.CSDataInvalidException;

public class Customer {

	//以下屬性(attribute, property->封裝過後的屬性)宣告
	//private String id; //ROC ID, 必要欄位, PKey欄位	
	private String email; //符合email格式, 必要欄位, unique欄位
	private String phone; //必要欄位, 10~20個字元, unique欄位
	private String password; //必要欄位, 6~20個字元
	private String name; //必要欄位, 2~20個字元
	/**必要欄位, M:Male, F:Female, O:Others*/
	private char gender; 
	//public Date birthday; //必要欄位, 年滿12歲, 若JDK7.0以前
	private LocalDate birthday; //必要欄位, 年滿12歲, 若JDK8.0(含)以後
	
	private String address=""; //非必要欄位, 出貨地址的預設值
	//private boolean subscribed; //非必要欄位
	
	//private List<Product> myfavorite;
	
	public Customer() {
	}

	public Customer(String email, String name, String password) {
		this.setEmail(email);
		this.setName(name);
		this.setPassword(password);
	}
	
	public Customer(String id, String name, String password, char gender) {
//		super();
//		this.id = id;
//		this.name = name;
//		this.password = password;
		this(id, name ,password);
		this.setGender(gender);
	}
	
//	public String getId() {
//		return id;
//	}
	
//	public void setId(String id) {
//		if(checkId(id)==true) {
//			this.id = id;
//		}else {
//			//TODO:以下錯誤訊息處理方式要在Mod13後改成 throw new XxxException("......")
//			System.err.printf("資料不正確: %s, 客戶身分證號不符合身分證號規則\n",id);
//		}
//	}
//	public static final String ID_PATTERN = "[A-Z][1289][0-9]{8}"; 
//	//private static final String firstCharString = "ABCDEFGHJKLMNPQRSTUVXYWZIO"; //另一種寫法，先將英文字母照對應後的數字排序
//	public static boolean checkId(String id) {
//		//ID_PATTERN是身分字號的樣板字串，是一個regular expression(正規表示式)
//		//[]代表一個字,[A-Z]代表可以放A-Z的任一字母,[1289]代表可以放1.2.8.9任一數字
//		//{n}代表可以重複n次
//		//matches(""),判斷該字串是否與給定的正規表示式相符。
//		if (id!=null && id.matches(ID_PATTERN)) {
//			int sum = 0;
//			//1.將第1碼的字元，轉換成對應的數字，並將十位數*1、個位數*9後相加
//			char firstChar = id.charAt(0);
//			//int firstNum = firstCharString.indexOf(firstChar)+10; //另種寫法
//			int firstNum = -1;
//			if(firstChar>='A' && firstChar<='H') { //A-H,10-17
//				firstNum = firstChar-'A' + 10;
//			}else if(firstChar>='J' && firstChar<='N'){ //J-N,18-22
//				firstNum = firstChar-'J' + 18;
//			}else if(firstChar>='P' && firstChar<='V') {//P-V,23-29
//				firstNum = firstChar-'P' + 23;
//			}else { //I, O, W, X, Y, Z -> 34, 35, 32, 30, 31, 33
//				switch(firstChar) {
//					case'I':
//						firstNum = 34;
//						break;
//					case'O':
//						firstNum = 35;
//						break;
//					case'W':
//						firstNum = 32;
//						break;
//					case'X':
//						firstNum = 30;
//						break;
//					case'Y':
//						firstNum = 31;
//						break;
//					default: //Z
//						firstNum = 33;
//				}
//////				if(firstChar=='I') firstNum = 34;
//////				else if(firstChar=='O') firstNum = 35;
//////				else if(firstChar=='W') firstNum = 32;
//////				else if(firstChar=='X') firstNum = 30;
//////				else if(firstChar=='Y') firstNum = 31;
//////				else firstNum = 33;
//			}
//			
//			sum = firstNum/10*1 + firstNum%10*9;
//		
//			//2.將2~10碼的字元依公式加總
////			for(int i=1,j=8;i<=9;i++,j--) {
////				sum = sum + (id.charAt(i)-'0')*(j==0?1:j);
////			}
//			
//			for(int i=1; i<=9;i++) {
//					sum += (id.charAt(i)-'0')*(9-i==0?1:9-i); 
//			}
////			sum = sum + (id.charAt(1)-'0')*8;
////			sum = sum + (id.charAt(2)-'0')*7;
////			sum = sum + (id.charAt(3)-'0')*6;
////			sum = sum + (id.charAt(4)-'0')*5;
////			sum = sum + (id.charAt(5)-'0')*4;
////			sum = sum + (id.charAt(6)-'0')*3;
////			sum = sum + (id.charAt(7)-'0')*2;
////			sum = sum + (id.charAt(8)-'0')*1;
////			sum = sum + (id.charAt(9)-'0')*1;
//		
//			//3.sum為10的倍數時，極為正確的ROC ID
//			return sum%10==0;
//		}
//		return false; //ID格式不正確
//	}
	
	public String getEmail() {
		return email;
	}
	public static final String EMAIL_PATTERN ="^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
	
	public void setEmail(String email) { //^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$
		//String EMAIL_PATTERN ="^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";//請至regexp lib查詢
		if (email!=null && email.matches(EMAIL_PATTERN)) {
			this.email = email;
		}else {
//			以下錯誤訊息處理方式要在Mod13後改成 throw new XxxException("......")
//			System.err.printf("資料不正確: %s\n", email);
			String errMsg = String.format("資料不正確:%s，不符合email驗證規則", email);
			throw new CSDataInvalidException(errMsg);
		}
	}
	
	public String getPhone() {
		return phone;
	}
	public static final int PHONE_MIN_LENGTH = 10, PHONE_MAX_LENGTH =20;
	
	public void setPhone(String phone) {
		//int minlength = 10, maxlength =20;
		if(phone!=null && phone.length()>=10 && phone.length()<=20) {
			this.phone = phone;
		}else {
//			以下錯誤訊息處理方式要在Mod13後改成 throw new XxxException("......") //讓前端收到錯誤
//			System.err.printf("資料不正確: %s, 手機/聯絡電話資料必須%d-%d個數字\n"
//					, phone, PHONE_MIN_LENGTH, PHONE_MAX_LENGTH); //for developer, admin, tester //後端才看得見
			String errMsg = String.format("資料不正確: %s, 手機/聯絡電話資料必須%d-%d個數字", phone, PHONE_MIN_LENGTH, PHONE_MAX_LENGTH);
			throw new CSDataInvalidException(errMsg);
		}
	}
	
	public String getPassword() {
		return this.password;
	}
	public static final int PWD_MIN_LENGTH = 6, PWD_MAX_LENGTH = 20;
	
	public void setPassword(String password) {
		//int minLength = 6, maxLength = 20;
		if(password!=null && password.length()>=PWD_MIN_LENGTH && password.length()<=PWD_MAX_LENGTH) {
			this.password = password;
			return;
		}else {
	//		以下錯誤訊息處理方式要在Mod13後改成 throw new XxxException("......") //讓前端收到錯誤
	//		System.err.printf("資料不正確: %s, 密碼資料必須%d-%d個字\n"
	//				,password , PWD_MIN_LENGTH, PWD_MAX_LENGTH);//for developer, admin, tester //後端才看得見
			String errMsg = String.format("資料不正確: %s, 密碼資料必須%d-%d個字",password , PWD_MIN_LENGTH, PWD_MAX_LENGTH);
			throw new CSDataInvalidException(errMsg);
		}		
	}
	
	public String getName() {
		return name;
	}
	
	public static final int NAME_MIN_LENGTH = 2, NAME_MAX_LENGTH = 20;
	public void setName(String name) {

		//int minLength = 2, maxLength = 20;
		//trim()把前後空白去掉 //只是在那個瞬間把前後空白去掉，但name本身沒有變化，所以應該把去掉後得結果再指派給自己。
		if(name!=null && (name=name.trim()).length()>=NAME_MIN_LENGTH && name.length()<=NAME_MAX_LENGTH) {
			this.name = name;
		}else {
//			以下錯誤訊息處理方式要在Mod13後改成 throw new XxxException("......") //讓前端收到錯誤
//			System.err.printf("資料不正確: %s, 姓名資料必須%d-%d個字\n"
//					, name, NAME_MIN_LENGTH, NAME_MAX_LENGTH); //for developer, admin, tester //後端才看得見
			String errMsg = String.format("資料不正確: %s, 姓名資料必須%d-%d個字", name, NAME_MIN_LENGTH, NAME_MAX_LENGTH);
			throw new CSDataInvalidException(errMsg);
		}
		
	}

	public char getGender() {
		return gender;
	}
	public static final char MALE = 'M';
	public static final char FEMALE = 'F';
	public static final char OTHERS = 'O';
	
	public void setGender(char gender) {
		if(gender==MALE||gender==FEMALE||gender==OTHERS) {
			this.gender = gender;
		}else {
//			以下錯誤訊息處理方式要在Mod13後改成 throw new XxxException("......")
//			System.err.printf("資料不正確: %s, 客戶性別必須為男:%s,女:%s,其他:%s\n",gender,MALE,FEMALE,OTHERS);
			String errMsg = String.format("資料不正確: %s, 客戶性別必須為男:%s,女:%s,其他:%s",gender,MALE,FEMALE,OTHERS);
			throw new CSDataInvalidException(errMsg);
		}		
	}
	
	public LocalDate getBirthday() {
		return this.birthday;
	}

	/**
	 * 將參數dateString轉換為LocalDate的物件，
	 * 再呼叫setBirthday(theDate)方法做指派
	 * @param dateString 客戶生日的日期字串，須符合ISO-8601
	 */
	//用小月曆
	public void setBirthday(String dateString) {
		try{
			if(dateString!=null) dateString = dateString.replace('/', '-'); //把/換成-再指派給自己
			LocalDate theDate = LocalDate.parse(dateString); //releaseDate字串必須符合iso8601
			this.setBirthday(theDate);
		}catch(DateTimeParseException | NullPointerException e) { //混再一起做錯誤處理, ja
			String errMsg = String.format("客戶生日:%s日期格式錯誤", dateString);
			throw new CSDataInvalidException(errMsg);
		}
	}
	
	/**
	 * 將三個int參數 year, month, day，轉換為LocalDate物件，
	 * 再呼叫setBirthday(theDate)方法做指派
	 * @param year 客戶生日的西元年
	 * @param month 客戶生日的月份
	 * @param day 客戶生日的日期
	 */
	//setBirthday的overload
	//用下拉式選單，傳回三個整數作為生日。
	public void setBirthday(int year, int month, int day) {
		LocalDate theDate = LocalDate.of(year, month, day);
		this.setBirthday(theDate);
	}
	
	/**
	 * 提供birthday屬性封裝(encapsulate)後，所需要的setter
	 * 檢查參數的出生日期是否符合客戶年齡規則(年滿12歲)
	 * @param birthday
	 */
	public static final int MIN_AGE = 12;
	public void setBirthday(LocalDate birthday) {
		if(birthday!=null && getAge(birthday)>=MIN_AGE) {
			this.birthday = birthday;
		}else{
//			以下錯誤訊息處理方式要在Mod13後改成 throw new XxxException("......") //讓前端收到錯誤
//			System.err.printf("生日資料不正確: %s, 客戶必須年滿%d歲\n"
//					,birthday,MIN_AGE );//for developer, admin, tester //後端才看得見
			String errMsg = String.format("生日資料不正確: %s, 客戶必須年滿%d歲", birthday, MIN_AGE );
			throw new CSDataInvalidException(errMsg);
		}
	}
	
	/**
	 * 計算customer年齡: 今年-customer.birthday的年份
	 * @return int 客戶年齡
	 */
	//要建立物件才可以使用
	public Integer getAge() {
		return getAge(this.birthday);
	}
	
	/**
	 * 計算年齡: 今年-參數birthday指定出生日期的年份
	 * @return int 年齡
	 */	
	//不需要建立物件(發現生日是錯誤的就不需要把物件建立起來，沒有設立static就浪費了記憶體)
	public static Integer getAge(LocalDate birthday) {
		int age;
		LocalDate today = LocalDate.now();
		if(birthday!=null && today.isAfter(birthday) ) {
			int thisYear = today.getYear();
			//System.out.printf("thisYear: %s\n",thisYear); //for test
			int birthYear = birthday.getYear();
			age = thisYear-birthYear;
			return age;
		}else {
//			//(可不做): 以下錯誤訊息處理方式要在Mod13後改成 throw new XxxException("......")
//			return null;
			String errMsg = String.format("生日日期不正確: %s, 日期不得為空且需大於今日"	, birthday);
			throw new CSDataInvalidException(errMsg);
		}
		
	}
	
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		if(address==null) address="";
		this.address = address.trim();
	}

//	public boolean isSubscribed() {
//		return subscribed;
//	}
//
//	public void setSubscribed(boolean subscribed) {
//		this.subscribed = subscribed;
//	}



	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		return result;
	}
	
	@Override
	public String toString() {
		return getClass().getName() +" [email=" + email + ", phone=" + phone + ", password=" + password + ", name=" + name
				+ ", gender=" + gender + ", birthday=" + birthday + ", address=" + address + "]\n";
	}

	/**
	 * obj 是多型的參數宣告
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof Customer))
			return false;
		Customer other = (Customer) obj;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		return true;
	}

//	@Override
//	public boolean equals(Object obj) {
//		if (this == obj)
//			return true;
//		if (obj == null)
//			return false;
//		if (getClass() != obj.getClass()) //如果obj.getClass()是null會當掉，所以上一行要做null檢查
//			return false;
//		Customer other = (Customer) obj;
//		if (id == null) { l
//			if (other.id != null) //如果this.id==null 而且 other.id==null會是true
//				return false;
//		} else if (!id.equals(other.id))
//			return false;
//		return true;
//	}


	
//	/**
//	 * @param obj 是多型的參數(polymorphic arguments)
//	 */
//	@Override
//	public boolean equals(Object obj) { //PKEY
//		if(this==obj) return true;
//		if(obj instanceof Customer) { //instanceof自帶null檢查，假如左邊的是null就回傳false
//			Customer another = (Customer)obj;
//		return this.id!=null && this.id.equals(another.id); //如果有null的可能放在equals左邊會當掉
				//這邊的寫法是不去比較this.id==null
//		}
//		return false;
//	}
	
	
}
