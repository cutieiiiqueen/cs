package uuu.cs.entity;

public class OrderItem {
	private int orderId;	 //Pkey
	private Product product; //Pkey
	private Spec theSpec;	 //Pkey
	private double price;	 //交易價格, 必要欄位
	private int quantity;	 //必要欄位
	
	
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Spec getTheSpec() {
		return theSpec;
	}
	public void setTheSpec(Spec theSpec) {
		this.theSpec = theSpec;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}	
    public int getProductId() {
        return product.getId();
    }
    public String getPhotoUrl() {
        if (theSpec != null && theSpec.getPhotoUrl() != null) {
            return theSpec.getPhotoUrl();
        } else {
            return product.getPhotoUrl();
        }
    }
    public String getProductName() {
        return product.getName();
    }	
	public String getSpecName() {
		return theSpec.getSpecName();
	}
	public double getAmount() {
		return this.price * this.quantity;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + orderId;
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((theSpec == null) ? 0 : theSpec.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrderItem other = (OrderItem) obj;
		if (orderId != other.orderId)
			return false;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;
		if (theSpec == null) {
			if (other.theSpec != null)
				return false;
		} else if (!theSpec.equals(other.theSpec))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "OrderItem [orderId=" + orderId + 
				", getProductId()=" + getProductId() + 
				", getProductName()=" + getProductName() + 
				", getPhotoUrl()=" + getPhotoUrl() + 
				", getSpecName()=" + getSpecName() + 
				", 交易價=" + price + 
				", 數量=" + quantity +
				", 小計=" + getAmount() + "]\n";
	}	
	
}

