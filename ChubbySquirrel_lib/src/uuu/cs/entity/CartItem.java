package uuu.cs.entity;

//表示購物車中的一項產品
public class CartItem {
	private Product product; //Pkey
	private Spec theSpec;	//Pkey(有規格的商品才為必要)
	
//	private int quantity; //放在ShoppingCart類別的Map中
//	
//	private boolean checkOutFlag = true; //是否要在這一次結帳
//	
//	public boolean isCheckOutFlag() {
//		return checkOutFlag;
//	}
//	public void setCheckOutFlag(boolean checkOutFlag) {
//		this.checkOutFlag = checkOutFlag;
//	}
	
	 // 返回產品
    public Product getProduct() {
        return product;
    }

    // 設置產品
    public void setProduct(Product product) {
        this.product = product;
    }

    // 返回產品規格
    public Spec getTheSpec() {
        return theSpec;
    }

    // 設置產品規格
    public void setTheSpec(Spec theSpec) {
        this.theSpec = theSpec;
    }

    // 返回產品ID
    public int getProductId() {
        return product.getId();
    }

    // 返回產品圖片URL，如果有規格，則返回規格的圖片URL
    public String getPhotoUrl() {
        if (theSpec != null && theSpec.getPhotoUrl() != null) {
            return theSpec.getPhotoUrl();
        } else {
            return product.getPhotoUrl();
        }
    }

    // 返回產品名稱
    public String getProductName() {
        return product.getName();
    }

    // 返回規格名稱，如果沒有規格，返回空字符串
    public String getSpecName() {
        if (theSpec != null) {
            return theSpec.getSpecName();
        } else {
            return "";
        }
    }

    // 返回列表價格，如果有規格且規格價格大於0，返回規格價格；否則，如果產品是特價產品，返回特價產品的列表價格；否則，返回產品單價
    public double getListPrice() {
        if (theSpec != null && theSpec.getListPrice() > 0) {
            return theSpec.getListPrice();
        } else {
            if (product instanceof SpecialOffer) {
                return ((SpecialOffer) product).getListPrice();
            } else {
                return product.getUnitPrice();
            }
        }
    }

    // 返回折扣字串，如果產品是特價產品，返回特價產品的折扣字串；否則，返回空字符串
    public String getDiscountString() {
        if (product instanceof SpecialOffer) {
            return ((SpecialOffer) product).getDiscountString();
        } else {
            return "";
        }
    }

    // 返回單價，如果有規格且規格價格大於0，返回規格價格；否則，返回產品單價
    public double getUnitPrice() {
        if (theSpec != null && theSpec.getPrice() > 0) {
            return theSpec.getPrice();
        } else {
            return product.getUnitPrice();
        }
    }

    // 返回庫存量，如果有規格，返回規格的庫存量；否則，返回產品的庫存量
    public int getStock() {
        if (theSpec != null) {
            return theSpec.getStock();
        } else {
            return product.getStock();
        }
    }
    
    /**
     * 為紀錄即時庫存加入的方法
     * @param stock
     */
    public void setStock(int stock) {
       if(theSpec!=null ) {
    	   theSpec.setStock(stock); return;
       }    
       product.setStock(stock);
    }

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
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
		CartItem other = (CartItem) obj;
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
		return "\nCartItem [產品編號=" + getProductId() + ", 產品圖片=" + getPhotoUrl() 
				+ ", 產品名稱=" + getProductName() + ", 規格=" + getSpecName()
				+ ", 售價=" + getListPrice()	+ ", 折扣=" + getDiscountString()
				+ ", 優惠價=" + getUnitPrice() + ", 庫存=" + getStock() + "]";
	}

	

	
}
