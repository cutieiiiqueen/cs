package uuu.cs.test;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.cs.entity.Customer;
import uuu.cs.entity.Order;
import uuu.cs.entity.PaymentType;
import uuu.cs.entity.Product;
import uuu.cs.entity.ShippingType;
import uuu.cs.entity.ShoppingCart;
import uuu.cs.exception.CSException;
import uuu.cs.service.CustomerService;
import uuu.cs.service.ProductService;

public class TestOrder {

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
			
			//測試結帳，模仿CheckOutServlet
			//模仿取得Form Data
			String sTypeString = "HOME";
			String pTypeString = "HOME";
			String recipientName = "韓諾亞";
			String recipientPhone = "0920010210";
			String recipientMail = "1noahhan210@gmail.com";
			String shinppingAddress = "基隆市暖暖街134-1號1F";
			
			//呼叫商業邏輯
			Order order = new Order();
			order.setMember(cart.getMember());
			order.setCreatedDate(LocalDate.now());
			order.setCreatedTime(LocalTime.now());
			
			//轉型
			ShippingType shippingType = ShippingType.valueOf(sTypeString);
			order.setShippingType(shippingType);
			order.setShippingFee(shippingType.getFee());
			
			//轉型
			PaymentType paymentType = PaymentType.valueOf(pTypeString);
			order.setPaymentType(paymentType);
			order.setPaymentFee(paymentType.getFee());
			
			order.setRecipientName(recipientName);
			order.setRecipientPhone(recipientPhone);
			order.setRecipientEmail(recipientMail);
			order.setShippingAddress(shinppingAddress);
			
			order.add(cart);
			System.out.println(order);
			
			//TODO: 測試OrderService.checkOut(order), OrdersDAO.insert(order)
			
		} catch (CSException e) {
			Logger.getLogger("").log(Level.SEVERE, "加入購物車測試失敗", e);
		} catch (Exception e) {
			Logger.getLogger("").log(Level.SEVERE, "加入購物車發生非預期錯誤", e);
		}
	}
}

