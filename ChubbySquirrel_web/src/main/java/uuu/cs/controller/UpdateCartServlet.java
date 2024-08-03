package uuu.cs.controller;

import java.io.IOException;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.cs.entity.CartItem;
import uuu.cs.entity.Customer;
import uuu.cs.entity.ShoppingCart;

/**
 * Servlet implementation class UpdateCartServlet
 */
@WebServlet("/member/update_cart.do")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			HttpSession session = request.getSession();
			ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
			
			if(cart!=null && !cart.isEmpty()) {
				Set<CartItem> cartItemSet = cart.getCartItemSet();
				for(CartItem cartItem: cartItemSet) {
					//1.讀取request的form data
					String quantity = request.getParameter("quantity"+cartItem.hashCode());
					String delete = request.getParameter("delete"+cartItem.hashCode());
					
					if(delete==null) { //不要remove, 只要修改數量
						int qty;
						if(quantity!=null && quantity.matches("\\d+")) {
							qty = Integer.parseInt(quantity);
							   if(qty>0) {
						           cart.update(cartItem, qty);
						      }else {
						           cart.remove(cartItem);
						      }
						}
					}else { //要remove
						cart.remove(cartItem);
					}
					
				}
			}
			
			//3. 外部轉交cart.jsp
			String submit = request.getParameter("submit");
			if("checkOut".equals(submit)) {
	            // 處理結帳邏輯
	            String[] selectedItemsArray = request.getParameterValues("selectedItems");
	            if (selectedItemsArray == null || selectedItemsArray.length == 0) {
	                request.setAttribute("errors", "請至少選擇一項商品進行結帳");
	                request.getRequestDispatcher("cart.jsp").forward(request, response);
	                return;
	            }
	            
	            // 創建一個新的購物車，只包含選中的項目
	            ShoppingCart selectedCart = new ShoppingCart();
	            selectedCart.setMember((Customer)session.getAttribute("member"));
	            
	            // 遍歷原購物車內的內容
	            for (CartItem item : cart.getCartItemSet()) {
	                // 遍歷選取的ItemHashcode
	                for (String selectedItemHash : selectedItemsArray) {
	                    // 如果有對應的
	                    if (String.valueOf(item.hashCode()).equals(selectedItemHash)) {
	                        // 從原始購物車獲取數量，然後添加到新的購物車
	                        int quantity = cart.getQuantity(item);
	                        selectedCart.add(item.getProduct(), item.getSpecName(), quantity);
	                        break;
	                    }
	                }
	            }
	            
	            // 將選中的購物車存儲在 session 中
	            session.setAttribute("checkoutCart", selectedCart);
	            
	            // 重定向到結帳頁面
	            response.sendRedirect("check_out.jsp");
			} else {response.sendRedirect("cart.jsp");
			}
		
			if("reset".equals(submit)) {
				session.removeAttribute("cart");
			}
		}

}
