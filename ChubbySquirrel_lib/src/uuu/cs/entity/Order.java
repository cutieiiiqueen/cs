package uuu.cs.entity;

import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashSet;
import java.util.Set;


public class Order {
	
	private int id;  //必要, Pkey, auto-increment
	private Customer member;  //必要, 訂購人
	private LocalDate createdDate;  //必要, 訂購日期
	private LocalTime createdTime;  //必要, 訂購時間
	private int status;  //必要, 訂購狀態 //0:NEW, 1:TRANSEFRED, 2:PAID, 3:SHIPPED, 4:ARRIVED, 5:CHECKED, 6:COMPLETED, ...
	
	private ShippingType shippingType; //必要
	private double shippingFee; //必要, 交易時運費
	private String shippingNote; //非必要
	
	private PaymentType paymentType; //必要
	private double paymentFee;  //必要, 交易時 貨到付款 手續費
	private String paymentNote; //非必要
	
	private String recipientName;	//必要
	private String recipientEmail;	//必要
	private String recipientPhone;  //必要
	private String shippingAddress; //必要
	
	private double subtotal;
	private double discountAmount;
	private double totalAmount;
	
	private Set<OrderItem> orderItemSet = new HashSet<>();
	
	/**
	 * 加總訂單中的購買項目數量
	 * @return orderItemSet.size()
	 */
	public int size() {
		return orderItemSet.size();
	}
	
	/**
	 * 加總訂單的購買件數
	 * @return 總購買件數
	 */
	public int getTotalQuantity() {
		int sum = 0;
		for(OrderItem orderItem:orderItemSet) {
			sum = sum + orderItem.getQuantity();
		}
		return sum;
	}
	
	public double getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(double subtotal) {
		this.subtotal = subtotal;
	}

	public double getDiscountAmount() {
		return discountAmount;
	}

	public void setDiscountAmount(double discountAmount) {
		this.discountAmount = discountAmount;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	

//	/**
//	 * 加總訂單的購買總金額
//	 * @return 總購買金額
//	 */
//	public double getSubTotal() {
//		if(orderItemSet==null || orderItemSet.isEmpty()) { //沒有訂單明細for歷史訂單
//			return subtotal;
//		}
//		double sum = 0;
//		for(OrderItem orderItem:orderItemSet) { //有訂單明細
//			sum = sum + orderItem.getAmount();
//		}
//		return sum;
//	}	
//	public void setSubTotal(double subtotal) {
//		this.subtotal = subtotal;
//	}
//	
//	/**
//	 * 總訂單的購買金額扣除VIP會員折扣後的金額
//	 * @return VIP折扣後金額
//	 */
//	public double getDiscountAmount() {
//		int discount = 0;
//		if(member instanceof VIP) {
//			discount = ((VIP) member).getDiscount();
//			return getTotalAmount()*(100-discount/100);
//		}else {
//			return getTotalAmount();
//		}
//	}
//	public void setDiscountAmount(double discount_amount) {
//		this.discountAmount = discount_amount;
//	}
//	
//	/**
//	 * 訂單最後結算金額:訂單品項總金額-VIP折扣+金流手續費+運費
//	 * @return 訂單最後結算金額
//	 */
//	public double getTotalAmount() {
//		int discount = 0;
//		if(member instanceof VIP) {
//			discount = ((VIP) member).getDiscount();
//			return getSubTotal()*(100-discount/100) + shippingFee + paymentFee;
//		}else {
//			return getSubTotal() + shippingFee + paymentFee;
//		}
//	}
//
//	public void setTotalAmount(double totalAmount) {
//		this.totalAmount = totalAmount;
//	}
//
//	/**
//	 * 加總訂單的購買金額+運費+手續費
//	 * @return 總購買金額+運費+手續費
//	 */
//
//	//public static final double MIN_TOTAL_AMOUNT = 1500; 	//設定免運費門檻
//	
//	public double getTotalAmountWithFee() {
//		double total = getTotalAmount();
//		/*if(total >= MIN_TOTAL_AMOUNT) {
//			return total;
//		}*/
//		return shippingFee + paymentFee + getTotalAmount();
//	}
	
	
	//orderItemSet的getter(用eclipse->[source]->[generate getter/setter...])
	public Set<OrderItem> getOrderItemSet() {
		return new HashSet<>(orderItemSet); //回傳集合(Collection)屬性的複本
	}	
	


	//orderItemSet的setter 要改為add
	//for [OrdersDAO] *查詢* 來自orders join order_items tables
	//用此方法將OrderItem物件加入訂單物件中
	public void add(OrderItem item) {
		orderItemSet.add(item);
	}	
	
	//for [CheckOutServlet] 結帳(建立訂單) 將cart中的CartItem加入order物件的orderItemSet
	public void add(ShoppingCart cart) {
		if(cart==null || cart.size()==0)
			throw new IllegalArgumentException("建立訂單明細時，cart不得為空");
		
		for(CartItem cartItem:cart.getCartItemSet()) {
			OrderItem orderItem = new OrderItem();
			orderItem.setProduct(cartItem.getProduct());
			orderItem.setTheSpec(cartItem.getTheSpec());
			orderItem.setPrice(cartItem.getUnitPrice());
			orderItem.setQuantity(cart.getQuantity(cartItem));
			
			orderItemSet.add(orderItem);
		}
	
	}
	
	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Customer getMember() {
		return member;
	}

	public void setMember(Customer member) {
		this.member = member;
	}

	public LocalDate getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDate createdDate) {
		this.createdDate = createdDate;
	}

	public LocalTime getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(LocalTime createdTime) {
		this.createdTime = createdTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public ShippingType getShippingType() {
		return shippingType;
	}

	public void setShippingType(ShippingType shippingType) {
		this.shippingType = shippingType;
	}

	public double getShippingFee() {
		return shippingFee;
	}

	public void setShippingFee(double shippingFee) {
		this.shippingFee = shippingFee;
	}

	public String getShippingNote() {
		return shippingNote;
	}

	public void setShippingNote(String shippingNote) {
		this.shippingNote = shippingNote;
	}

	public PaymentType getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(PaymentType paymentType) {
		this.paymentType = paymentType;
	}

	public double getPaymentFee() {
		return paymentFee;
	}

	public void setPaymentFee(double paymentFee) {
		this.paymentFee = paymentFee;
	}

	public String getPaymentNote() {
		return paymentNote;
	}

	public void setPaymentNote(String paymentNote) {
		this.paymentNote = paymentNote;
	}

	public String getRecipientName() {
		return recipientName;
	}

	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}

	public String getRecipientEmail() {
		return recipientEmail;
	}

	public void setRecipientEmail(String recipientEmail) {
		this.recipientEmail = recipientEmail;
	}

	public String getRecipientPhone() {
		return recipientPhone;
	}

	public void setRecipientPhone(String recipientPhone) {
		this.recipientPhone = recipientPhone;
	}

	public String getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}
	
	public String getStatusDescription() {
		return getStatusDescription(this.status);
	}
		
	/**
	 * 取得status文字描述的方法
	 * @param status
	 * @return 對應的文字描述
	 */
	public String getStatusDescription(int status) {
		if (status >= 0 && status < Status.values().length) { //確認status是在合法的範圍內0~6
			return Status.values()[status].description;  //根據傳入的status編號, 返回對應的文字描述,ex: 0:NEW
		} else {
			return String.valueOf(status); //不再範圍內則直接返回字串
		}
	}

	@Override
	public String toString() {
		return "Order [id=" + id + 
				", 訂購人=" + member + ", 訂單日期=" + createdDate + 
				", 訂單時間="+ createdTime +	", 訂單狀態=" + status + 
				"\n, 貨運方式=" + shippingType + ", 運費=" + shippingFee + ", 貨運備註=" + shippingNote + 
				"\n, 付款方式=" + paymentType + ", 手續費=" + paymentFee + ", 付款備註=" + paymentNote + 
				"\n, 收件人=" + recipientName + ", 收件人Email="	+ recipientEmail + 
				", 收件人電話=" + recipientPhone + ", 收件地址=" + shippingAddress + 
				"\n, 訂單明細=" + orderItemSet + 
				", 共" + size() + "項" + ", " + getTotalQuantity() + "件" +
				", 小計=" + getSubtotal() + ", VIP折扣後金額=" + getDiscountAmount() + ", 加手續費後總金額=" + getTotalAmount()
				+ "]\n";
	}
	private enum Status {
		NEW("新訂單"),
		TRANSFORED("已轉帳"),
		PAID("已付款"),
		SHIPPED("已出貨"),
		ARRIVED("已到貨"),
		SIGNED("已簽收"),
		COMPLETED("已完成");

		private final String description;
		
		private Status(String description) {
			this.description = description;
		}

		private String getDescription() {
			return description;
		}
	}
	
}
