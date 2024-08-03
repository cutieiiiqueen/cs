package uuu.cs.entity;

public enum PaymentType {
	SHOP("店面付款", 0), 
	ATM("ATM轉帳", 0), 
	HOME("貨到付款", 50), 
	STORE("超商取貨付款", 0), 
	CARD("信用卡付款", 0);
	
	private final String description;
	private final double fee;	

	private PaymentType(String description, double fee) {
		this.description = description;
		this.fee = fee;
	}
	public String getDescription() {
		return description;
	}
	public double getFee() {
		return fee;
	}

	@Override
	public String toString() {
		return description + (fee > 0 ? "："+fee+"元": "");				
	}
	
	
}
