package uuu.cs.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import uuu.cs.exception.CSException;
import uuu.cs.exception.LoginFailedException;
import uuu.cs.service.CustomerService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(urlPatterns = {"/login.do"}, loadOnStartup = -1)	//完整的寫法,後可接其他設定	//loadOnStartup:預先載入, 預設值:-1(不載入);
//@WebServlet("/login.do")	//上面一行的簡化寫法, 不可接其他設定	//http://localhost:8080/cs/login.do	
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        System.out.println(this.getClass().getName());
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<>(); //把錯誤訊息收集起來
		HttpSession session = request.getSession(); //透過request請求，找到上次請求的session ID; 如果是第一次就會自動建立新的ID
		//request.setCharacterEncoding("UTF-8");//設定的request中form date的編碼, 此處可省略因為email,password,驗證碼傳入都沒有中文
		
	
		//1.取得request中的form data
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String captcha = request.getParameter("captcha");
		
		
	    String quickLogin = request.getParameter("quickLogin");
	    if ("快速登入".equals(quickLogin)) {
	        email = "test005@gmail.com";
	        password = "qaz123";
	        captcha = (String)session.getAttribute("captcha");
	    } else {
		
		//1.1檢查
		if(email==null || (email=email.trim()).length()==0) {
			errors.add("必須輸入帳號");
		}
		if(password==null || password.length()==0) {
			errors.add("必須輸入密碼");
		}
		if(captcha==null || (captcha=captcha.trim()).length()==0) {
			errors.add("必須輸入驗證碼");
		}else {
			//檢查驗證碼
			String sessionCaptcha = (String)session.getAttribute("captcha");
				if(!captcha.equalsIgnoreCase(sessionCaptcha)) { //equalsIgoreCase忽略大小寫
					errors.add("驗證碼不正確");
				}
			session.removeAttribute("captcha"); //清除session裡的驗證碼, 防止資安問題
			}
	    }
		
		//2.若無誤，呼叫商業邏輯
		if(errors.isEmpty()) {
			//3.1將Xxx_lib設定為web專案的底層程式庫(v)
			CustomerService cService = new CustomerService();
			try {
				//執行商業邏輯
				Customer member = cService.login(email, password);
				
				//3.1顯示成功畫面
				session.setAttribute("member", member); //把member物件借放在request範圍, 跟著request轉交
				//session.setMaxInactiveInterval(10); //設定session有效時間, 單位:sec, 請勿開啟這個設定!! 
				
				//3.1 forward(內部轉交)登入成功網頁: login_ok.jsp
				RequestDispatcher dispatcher = request.getRequestDispatcher("login_ok.jsp");
				dispatcher.forward(request, response);
				return;
			
			}catch(LoginFailedException e) {
				errors.add(e.getMessage()); //for user
			}catch (CSException e) {
				this.log(e.getMessage(), e); //for admin, tester, developer
				errors.add(e.getMessage() + ", 請聯絡管理人員"); //for user
			}catch (Exception e) {
				this.log("系統發生非預期錯誤", e); //for admin, tester, developer
				errors.add("系統發生錯誤:" + e.getMessage() + ", 請聯絡管理人員"); //for user
			}
		}
		
		//3.2顯示錯誤畫面 
		request.setAttribute("errors", errors);		
		//3.2 forward(內部轉交)登入失敗網頁: login.jsp
		RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);
		
	}

}
