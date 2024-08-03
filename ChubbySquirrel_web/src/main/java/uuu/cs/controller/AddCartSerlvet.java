package uuu.cs.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.cs.entity.Product;
import uuu.cs.entity.ShoppingCart;
import uuu.cs.entity.Spec;
import uuu.cs.exception.CSException;
import uuu.cs.service.ProductService;

/**
 * Servlet implementation class AddCartSerlvet
 */
@WebServlet("/add_cart.do")
public class AddCartSerlvet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCartSerlvet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		//1. 取得請求request中的form data
		String productId = request.getParameter("productId");
		String specName = request.getParameter("spec");
		String quantity = request.getParameter("quantity");
		
		//檢查
		if(productId!=null){
			//2.呼叫商業邏輯
			ProductService pService = new ProductService();
			try {
			Product p = pService.getProductById(productId);
				if(p!=null) {
					if(specName==null) specName="";
					if(quantity!=null && quantity.matches("\\d+")) {
						ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
						if(cart==null) {
							cart = new ShoppingCart();
							session.setAttribute("cart", cart);							
						}
						int qty = Integer.parseInt(quantity);
						cart.add(p, specName, qty);
					}
				}
			}catch(CSException e) {
				this.log("加入購物車失敗", e);
			}catch(Exception e) {
				this.log("加入購物車發生非預期錯誤", e);
			}
			
		//3.作法一: 同步請求,外部轉交給cart.jsp
		//response.sendRedirect("products_list.jsp");
			
		//3.作法二: 非同步請求,內部轉交small_cart.jsp
		request.getRequestDispatcher("small_cart.jsp").forward(request, response);
		}
	}
}
