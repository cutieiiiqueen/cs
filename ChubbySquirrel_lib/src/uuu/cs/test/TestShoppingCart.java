package uuu.cs.test;

import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.cs.entity.Customer;
import uuu.cs.entity.Product;
import uuu.cs.entity.ShoppingCart;
import uuu.cs.exception.CSException;
import uuu.cs.service.CustomerService;
import uuu.cs.service.ProductService;

public class TestShoppingCart {

	public static void main(String[] args) {
		CustomerService cService = new CustomerService();
		ProductService pService = new ProductService();
		Customer member;
		try {
			//模仿會員登入
			member = cService.login("1noahhan210@gmail.com","@Haminyu1101Gmail");
			System.out.println(member);
			
			ShoppingCart cart = new ShoppingCart();
			cart.setMember(member);
			
			//模擬加入購物車
			//第1次加入購物車
			{
				String productId = "1";
				String specName = "300g";
				int qty = 1;
				
				Product p = pService.getProductById(productId);
				cart.add(p, specName, qty);				
			}
			//第2次加入購物車
			{
				String productId = "2";
				String specName = "240g";
				int qty = 1;
				
				Product p = pService.getProductById(productId);
				cart.add(p, specName, qty);				
			}
			//第3次加入購物車
			{
				String productId = "3";
				String specName = "300g";
				int qty = 2;
				
				Product p = pService.getProductById(productId);
				cart.add(p, specName, qty);				
			}
			//第4次加入購物車
			{
				String productId = "13";
				String specName = "150g";
				int qty = 1;
				
				Product p = pService.getProductById(productId);
				cart.add(p, specName, qty);				
			}
			//第5次加入購物車
			{
				String productId = "13";
				String specName = "280g";
				int qty = 1;
				
				Product p = pService.getProductById(productId);
				cart.add(p, specName, qty);				
			}
			System.out.println(cart);
		} catch (CSException e) {
			Logger.getLogger("").log(Level.SEVERE, "加入購物車測試失敗", e);
		} catch (Exception e) {
			Logger.getLogger("").log(Level.SEVERE, "加入購物車發生非預期錯誤", e);
		}
	}
}

