package uuu.cs.test;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
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
import uuu.cs.service.OrderService;
import uuu.cs.service.ProductService;

public class TestAtmTransfered {

	public static void main(String[] args) {
		CustomerService cService = new CustomerService();
		ProductService pService = new ProductService();
		Customer member;
		
		try {
			//模仿會員登入
			member = cService.login("test005@gmail.com","qaz654");
			String orderId = "1";
			
			OrderService oService = new OrderService();
			Order order = null;
			order = oService.getOrderById(member, orderId);
			System.out.println(PaymentType.ATM);
			System.out.println(order.getPaymentType());
			System.out.println(order.getStatus());
			if(order==null || !(PaymentType.ATM==order.getPaymentType() && order.getStatus()==0)){
				System.out.println("查無須通知轉帳的訂單資料");
			}else {
				System.out.println(order);
			}
			
		} catch (CSException e) {
			Logger.getLogger("").log(Level.SEVERE, "查詢歷史訂單測試失敗", e);
		} catch (Exception e) {
			Logger.getLogger("").log(Level.SEVERE, "查詢歷史訂單發生非預期錯誤", e);
		}
	}
}

