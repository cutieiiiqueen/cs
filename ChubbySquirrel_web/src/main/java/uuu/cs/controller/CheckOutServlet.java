package uuu.cs.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.cs.entity.CartItem;
import uuu.cs.entity.Order;
import uuu.cs.entity.PaymentType;
import uuu.cs.entity.ShippingType;
import uuu.cs.entity.ShoppingCart;
import uuu.cs.exception.CSException;
import uuu.cs.exception.StockShortageException;
import uuu.cs.service.OrderService;

/**
 * Servlet implementation class CheckOutServlet
 */
@WebServlet("/member/check_out.do")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckOutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<String> errors = new ArrayList<>();
		HttpSession session = request.getSession();
		ShoppingCart checkoutCart = (ShoppingCart)session.getAttribute("checkoutCart"); //從session讀取購物車資料
		ShoppingCart cart = (ShoppingCart)session.getAttribute("cart"); //從session讀取購物車資料
		if(checkoutCart==null || checkoutCart.isEmpty()) {
			response.sendRedirect("cart.jsp");
			return;
		}
		
	    // 在方法開始時添加日誌
	    System.out.println("Received check out request");

	    // 記錄所有接收到的參數
	    System.out.println("Received parameters:");
	    for (Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
	        System.out.println(entry.getKey() + ": " + Arrays.toString(entry.getValue()));
	    }
	    System.out.println(session.getAttribute("subTotal"));
	    System.out.println(session.getAttribute("discountAmount"));
		
		//1.取得request的form data & 檢查
		String sTypeString = request.getParameter("shippingType");
		String pTypeString = request.getParameter("paymentType");
		
		String recipientName = request.getParameter("recipientName");
		String recipientPhone = request.getParameter("recipientPhone");
		String recipientEmail = request.getParameter("recipientEmail");
		String shippingAddress = request.getParameter("shippingAddress");
		
		Double subTotal = (Double) session.getAttribute("subTotal");
		Double discountAmount = (Double) session.getAttribute("discountAmount");
		String totalAmount = request.getParameter("totalAmount");
		
		ShippingType shippingType = null;
		try{ 
			//將sTypeString轉換成ShippingType(enum)類型的對應值
			shippingType = ShippingType.valueOf(sTypeString);
		}catch(Exception e) {
			errors.add("請選擇貨運方式");
		}
		
		PaymentType paymentType = null;
		try{ 
			//將pTypeString轉換成PaymentType(enum)類型的對應值
			paymentType = PaymentType.valueOf(pTypeString);
		}catch(Exception e) {
			errors.add("請選擇付款方式");
		}
		
		if(recipientName==null || (recipientName=recipientName.trim()).length()==0) {
			errors.add("必須輸入收件人姓名");
		}
		if(recipientPhone==null || (recipientPhone=recipientPhone.trim()).length()==0) {
			errors.add("必須輸入收件人電話");
		}
		if(recipientEmail==null || (recipientEmail=recipientEmail.trim()).length()==0) {
			errors.add("必須輸入收件人Email");
		}
		if(shippingAddress==null || (shippingAddress=shippingAddress.trim()).length()==0) {
			errors.add("必須輸入收件地址");
		}
		if (subTotal == 0 || discountAmount == 0 || totalAmount == null) {
		    errors.add("訂單金額信息不完整，請重新進行結帳流程。");
		}
		
		//2.若無誤
		if(errors.isEmpty()) {
			//呼叫商業邏輯
			Order order = new Order();
			order.setMember(checkoutCart.getMember());
			order.setCreatedDate(LocalDate.now());
			order.setCreatedTime(LocalTime.now());
			
			order.setShippingType(shippingType);
			order.setShippingFee(shippingType.getFee());
			
			order.setPaymentType(paymentType);
			order.setPaymentFee(paymentType.getFee());
			
			order.setRecipientName(recipientName);
			order.setRecipientPhone(recipientPhone);
			order.setRecipientEmail(recipientEmail);
			order.setShippingAddress(shippingAddress);			
			
			order.setSubtotal(subTotal);
			order.setDiscountAmount(discountAmount);
			order.setTotalAmount(Double.parseDouble(totalAmount));
					
			order.add(checkoutCart); //這裡傳入cart是因為order有一個add方法，用於將cart中的CartItem加入order物件的orderItemSet
			OrderService oService = new OrderService();
			
			try {
				oService.checkOut(order);
				
				// 從原購物車中移除已結帳的項目
                for (CartItem item : checkoutCart.getCartItemSet()) {
                    cart.remove(item);
                }

                // 如果購物車為空，則完全移除
                if (cart.isEmpty()) {
                    session.removeAttribute("cart");
                } else {
                    session.setAttribute("cart", cart); // 更新 session 中的購物車
                }
                
                // 移除結帳購物車
                session.removeAttribute("checkoutCart");
                
				//3.1轉交成功畫面 forward
				request.setAttribute("order", order); 
				
				// 信用卡(若paymentType.equals("CARD"))則轉交/WEB-INF/credit_card.jsp來送出對於第三方支付的請求
				if (order.getPaymentType() == PaymentType.CARD) {
					request.setAttribute("order", order);
					request.getRequestDispatcher("/WEB-INF/credit_card.jsp").forward(request, response);
					return;
				}	
				
				request.getRequestDispatcher("check_out_ok.jsp").forward(request, response);
				return;
			}catch (StockShortageException e) {
				this.log(e.toString(),e);
				response.sendRedirect("cart.jsp");
			}catch (CSException e) {
				this.log(e.getMessage(), e);
				errors.add(e.getMessage() + ", 請聯絡管理人員");
			}catch (Exception e) {
				this.log("建立訂單發生非預期錯誤", e);
				errors.add("建立訂單發生非預期錯誤: " + e.getMessage() + ", 請聯絡管理人員");
			}
			
		}
		//3.2失敗畫面 forward
		request.setAttribute("errors", errors);
		request.getRequestDispatcher("check_out.jsp").forward(request, response);		
		
	}

}
