package uuu.cs.entity;

public enum ShippingType {
	SHOP("店面自取", 0, new PaymentType[] {PaymentType.SHOP}), 
	HOME("宅配", 150, new PaymentType[] {PaymentType.ATM, PaymentType.HOME, PaymentType.CARD}), 
	STORE("超商取貨", 60, new PaymentType[] {PaymentType.ATM, PaymentType.STORE, PaymentType.CARD}); //列舉值

	private final String description; //non-static blank final attribute
	private final double fee;
	private final PaymentType[] paymentTypeArray;
	
	private ShippingType(String description, double fee, PaymentType[] paymentTypeArray) {
		this.description = description;
		this.fee = fee;
		this.paymentTypeArray = paymentTypeArray;
	}	
	
	public String getDescription() {
		return description;
	}
	public double getFee() {
		return fee;
	}
	public PaymentType[] getPaymentTypeArray() {
		return paymentTypeArray==null?null:paymentTypeArray.clone(); //副本		
	}
	public String getPaymentTypeArrayString() {
		String data ="";
		if(paymentTypeArray!=null && paymentTypeArray.length>0) {
			for(PaymentType pType:paymentTypeArray) {
					data += (data.length()>0?",":"")+pType.name();
			}
		}
		return 	data;
	}
	@Override
	public String toString() {
		return description + (fee > 0 ? "："+fee+"元": "");				
	}
	
}
