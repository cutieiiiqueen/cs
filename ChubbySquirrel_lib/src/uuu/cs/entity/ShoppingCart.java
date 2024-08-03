package uuu.cs.entity;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import uuu.cs.exception.CSDataInvalidException;



public class ShoppingCart {
	private Customer member; //訂購人
	private Map<CartItem, Integer> cart = new HashMap<>(); 	//購物車內容 //Map對應關係
	
	public Customer getMember() {
		return member;
	}
	public void setMember(Customer member) {
		this.member = member;
	}
	
	//添加產品到購物車
	//取代cart屬性的setter(s):add, update, remove
	public void add(Product p, String specName, int quantity) {
		if(p==null) throw new IllegalArgumentException("加入購物車的產品不得為null"); 
			
		
		CartItem item = new CartItem();
		item.setProduct(p);
		
		// 檢查並設置規格
		Spec theSpec = null;
		if(p.getSpecList().size()>0 && specName!=null && specName.length()>0) {
			theSpec = p.findSpec(specName);
			String errorMsg = String.format("有規格的商品，規格錯誤[%s-%s]", p.getId(),specName);
			if(theSpec == null) throw new CSDataInvalidException(errorMsg);
		}else if(p.getSpecList().size()>0 && (specName==null || specName.length()==0)) {
			String errorMsg = String.format("有規格的商品，必須選擇規格[%s-%s]", p.getId(),specName);
			if(theSpec == null) throw new CSDataInvalidException(errorMsg);
		}
		item.setTheSpec(theSpec);
		
		
		//查出同一個item的上次購買數量
		//cart是一個Map<CartItem, Integer>, CartItem item = new CartItem(); item是購物車的一項產品
		Integer lastQty = cart.get(item); //從cart中獲取item(產品)之前已經購買的數量, 如果這個item之前已經存在於cart中, 會返回對應的數量
		if(lastQty!=null) {
			quantity = quantity + lastQty;  //如果上次購買數量不為null，就累加數量
		}
		cart.put(item, quantity); //將累計後的數量存入購物車, 如果item不存在，則會新增這個item
	}
	
	public void update(CartItem item, int quantity) {
		//查出上次購買的同一個item
		Integer lastQty = cart.get(item);
		if(lastQty!=null) {
			cart.put(item,quantity);
		}		
	}
	

	public Integer remove(Object key) {
		return cart.remove(key);
	}
	
	
	//取代cart屬性的getter(s):
	
	// 返回購物車的大小 (查詢總共買了幾項)
	public int size() {
		return cart.size();
	}
	// 檢查購物車是否為空
	public boolean isEmpty() {
		return cart.isEmpty();
	}
	/**
	 * 查詢 購買數量
	 * @param item 該購物明細
	 * @return int 購買數量
	 */
	
	public Integer getQuantity(CartItem item) { //左邊的item對應到右邊的資料
		return cart.get(item);
	}
	
	/**
	 * 查詢 小計金額
	 * @param item 該購物明細
	 * @return double 該購物明細的售價 * 購買數量
	 */
	public double getAmount(CartItem item) { 
		//item.getUnitPrice() 調用的是 CartItem 對象的 getUnitPrice 方法, 返回單價
		//this.getQuantity(item) 調用的是當前 ShoppingCart 對象的 getQuantity 方法, 返回購買數量
		return item.getUnitPrice() * this.getQuantity(item) ;
	}
	
	// 獲取購物車中的所有產品
	// cart 是一個 Map<CartItem, Integer>，其中 CartItem 是產品項目，Integer 是購買數量。
	// keySet() 方法返回這個映射中包含的所有鍵的集合，即所有 CartItem 對象。
	// Set是一種不包含重複元素的集合
	public Set<CartItem> getCartItemSet() {
		//return cart.keySet(); //(X), 不得回傳正本
		return new HashSet<>(cart.keySet()); //(O), 應回傳副本
	}
	// 計算總購買件數
	public int getTotalQuantity() {
		int sum = 0;
		Collection<Integer> qtyValues = cart.values(); //調用 cart.values() 獲取一個包含所有商品數量的 Collection<Integer>

		//舊寫法:使用迭代器（Iterator）來遍歷一個整數集合（qtyValues）
		//1.宣告一個 qtyIterator 變數來遍歷整數集合 qtyValues
		//2.進入 while 迴圈, 使用 hasNext() 方法檢查是否還有下一個元素, 如果還有，則進入迴圈
		//3..next() 方法用於獲取迭代器當前位置的元素，同時將迭代器的位置指向下一個元素
		//4.將獲取到的數字加到變數 sum 中
//		Iterator<Integer> qtyIterator = qtyValues.iterator(); 
//		while(qtyIterator.hasNext()) { 
//			Integer qty = qtyIterator.next(); 
//			sum = sum + qty;
//		}
		
		//新寫法:
		//for (元素類型 變數名稱 : 要遍歷的集合) {
		//    // 迴圈內的程式碼塊
		//}
		for(Integer qty:qtyValues) { //把商品中每一個數量遍歷出來再將其加總
			sum = sum + qty; //商業邏輯計算
		}
		return sum;
	}
	// 計算總購買金額
	public double getTotalAmount() {
		double sum = 0;
		Set<CartItem> cartItemSet = cart.keySet(); //宣告cartItemSet變數 將購物車裡的每個商品(cart.keySet()方法) 存放在set集合且裡面類型是<CartItem>
		for(CartItem item:cartItemSet) { //透過for迴圈遍歷每個商品 //item 的變數，用來表示集合 cartItemSet 中的每個元素，這個元素的類型是 CartItem。
			sum = sum + this.getAmount(item); //調用每個商品的getAmout(item)得到每個商品的小計, 再將其加總起來
		}
		return Math.round(sum);
	}
	
	
	@Override
	public String toString() {
		String cartString = "";
		Set<CartItem> cartItemSet = this.cart.keySet();
		for(CartItem item:cartItemSet) {
			String data = item.toString() + 
					"購買數量=" + this.getQuantity(item) +
					" 小計=" + this.getAmount(item);
			cartString = cartString + data + "\n";
		}
		
		return "ShoppingCart [訂購人=" + member 
				+ ", \n購物車內容=" + cartString + "]"
				+ "共" + size() +"項, " + getTotalQuantity() + "件"
				+ "總金額為: " + getTotalAmount() + "元";
	}
	
	

}
