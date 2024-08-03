package uuu.cs.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.cs.entity.Customer;
import uuu.cs.exception.CSDataInvalidException;
import uuu.cs.exception.CSException;
import uuu.cs.service.CustomerService;

@WebServlet("/ResetPassword.do")
public class ResetPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	   

	/**
	 * 從請求參數中獲取電子郵件和驗證碼，檢查驗證碼是否正確。
	 * 如果驗證碼正確，則調用 CustomerService 的 forgetPassword 方法來處理忘記密碼的邏輯。
	 * 最後將處理結果存儲在請求屬性中，並將請求轉發到 forget_password.jsp 頁面。
	 *
	 * @param request  HTTP 請求對象
	 * @param response HTTP 響應對象
	 * @throws ServletException 如果發生 Servlet 異常
	 * @throws IOException      如果發生 I/O 異常
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		HttpSession session = request.getSession();
		
		//1.取得request中的form data
		String email=request.getParameter("email");
		String captcha = request.getParameter("captcha");
		
		//1.1檢查
        if(email==null || (email=email.trim()).length()==0) {
            errors.add("必須輸入email");
        } 
        if(captcha==null || (captcha=captcha.trim()).length()==0) {
            errors.add("必須輸入驗證碼");
		}else {
			//檢查驗證碼
			String sessionCaptcha = (String)session.getAttribute("captcha");
			if(!captcha.equalsIgnoreCase(sessionCaptcha)) {
				errors.add("驗證碼不正確");
			}
		}
			
		//2.若無誤，呼叫商業邏輯
		if(errors.isEmpty()) {
			CustomerService cService = new CustomerService();
			
			try {
				//執行商業邏輯
				Customer member = cService.forgetPassword(email);
				
			    // 將 member 的 name 添加到請求屬性中
			    request.setAttribute("memberName", member.getName());
			    
				//3.1 forward(內部轉交)回原畫面，並顯示成功訊息: forget_password_ok.jsp
				RequestDispatcher dispatcher = request.getRequestDispatcher("forget_password_ok.jsp");
				dispatcher.forward(request, response);
				return;
				
			}catch(CSDataInvalidException e) {
				errors.add(e.getMessage()); //for user
			}catch (CSException e) {
				this.log(e.getMessage(), e); //for admin, tester, developer
				errors.add(e.getMessage()); //for user
			}catch (Exception e) {
				this.log("系統發生非預期錯誤", e); //for admin, tester, developer
				errors.add("系統發生錯誤:" + e.getMessage() + ", 請聯絡管理人員"); //for user
			}
		}
		//3.2顯示錯誤畫面 
		request.setAttribute("errors", errors);		
		//3.2 forward(內部轉交)回原畫面，並顯示失敗訊息: forget_password.jsp
		RequestDispatcher dispatcher = request.getRequestDispatcher("forget_password.jsp");
		dispatcher.forward(request, response);
		}
}
