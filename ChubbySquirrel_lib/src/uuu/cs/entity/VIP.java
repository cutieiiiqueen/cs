package uuu.cs.entity;

import uuu.cs.exception.CSDataInvalidException;

public class VIP extends Customer {
	
	private int discount = 5; // 1~90%off (99折~1折), 必要欄位

	public VIP() {
		super();
	}

	public VIP(String id, String name, String password, char gender) {
		super(id, name, password, gender);
	}

	public VIP(String email, String name, String password) {
		super(email, name, password);
	}



	public int getDiscount() {
		return discount;
	}
	
	public String getDiscountString() {
		int discount = 100-this.discount;
		if(discount%10==0) {
			discount = discount/10;
		}
		return discount + "折";
	}
	
	public void setDiscount(int discount) {
		if(discount>=0 && discount <=90) {
			this.discount = discount;
		}else {
//			以下錯誤訊息處理方式要在Mod13後改成 throw new XxxException("......")
//			System.err.printf("資料不正確:%s，VIP　discount應為1~90% off\n",discount);
			String errMsg = String.format("資料不正確:%s，VIP　discount應為0~90% off\n",discount);
			throw new CSDataInvalidException(errMsg);
		}
	}

	@Override
	public String toString() {
		return  super.toString()
				+" 折扣=" + discount +"% off ,即為"
				+ getDiscountString();
	}
	

}
