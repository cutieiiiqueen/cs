package uuu.cs.entity;

public class Spec {
	private int productId; //PKEY
	private String specName; //PKEY
	private int stock; 
	private double listPrice;
	private double price;
	private String iconUrl; //非必要
	private String photoUrl; //非必要
	
	
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	
	public String getSpecName() {
		return specName;
	}
	public void setSpecName(String specName) {
		this.specName = specName;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public double getListPrice() {
		return listPrice;
	}
	public void setListPrice(double listPrice) {
		this.listPrice = listPrice;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double unitPrice) {
		this.price = unitPrice;
	}
	public String getIconUrl() {
		return iconUrl;
	}
	public void setIconUrl(String iconUrl) {
		this.iconUrl = iconUrl;
	}
	public String getPhotoUrl() {
		return photoUrl;
	}
	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + productId;
		result = prime * result + ((specName == null) ? 0 : specName.hashCode());
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
		Spec other = (Spec) obj;
		if (productId != other.productId)
			return false;
		if (specName == null) {
			if (other.specName != null)
				return false;
		} else if (!specName.equals(other.specName))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "\n" + this.getClass().getSimpleName()
				+"[產品編號=" + productId + ", 規格=" + specName + ", 售價=" + listPrice + ", 優惠價=" + price + ", 庫存="
				+ stock + ", iconUrl=" + iconUrl + ", photoUrl=" + photoUrl + "]";
	}
	
	

}
