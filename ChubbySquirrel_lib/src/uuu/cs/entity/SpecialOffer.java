package uuu.cs.entity;

import uuu.cs.exception.CSDataInvalidException;

public class SpecialOffer extends Product {
	private int discount; //必要，1~90% off(99折~1折)
	

	public SpecialOffer() {
		super(); //系統會自動偷偷幫你建立，可寫可不寫
	}

	public SpecialOffer(int id, String name, double unitPrice) {
		super(id, name, unitPrice);
	}
	

	public SpecialOffer(int id, String name, double unitPrice, int discount) {
		super(id, name, unitPrice);
		setDiscount(discount);
	}

	public int getDiscount() {
		return discount;
	}
	
	public void setDiscount(int discount) {
		if(discount>=0 && discount <=90) {
			this.discount = discount;
		}else {
//			以下錯誤訊息處理方式要在Mod13後改成 throw new XxxException("......")
//			System.err.printf("資料不正確:%s，特價品discount應為1~90% off\n",discount);
			String errMsg = String.format("資料不正確:%s，特價品discount應為0~90% off\n",discount);
			throw new CSDataInvalidException(errMsg);
		}
	}
	
	public String getDiscountString() {
		int discount = 100-this.discount;
		if(discount%10==0) {
			discount = discount/10;
		}
		return discount +"折";
	}

	/**
	 * 查詢折扣後售價
	 * @return double型態的折扣後售價
	 */
	@Override
	public double getUnitPrice() {
		double price = super.getUnitPrice();//從父類別物件取得查詢定價方法
		price = price * (100-this.discount)/100;
		return price;

	}
	/**
	 * 查詢定價
	 * @return
	 */
	public double getListPrice() {
		return super.getUnitPrice();//從父類別物件取得查詢定價方法
	}

	@Override
	public String toString() {
		return super.toString()
				+ " 折扣=" + discount + "% off, 即為" 
				+ this.getDiscountString()
				+ " 售價=" + getUnitPrice() + "元";
	}

	
}
