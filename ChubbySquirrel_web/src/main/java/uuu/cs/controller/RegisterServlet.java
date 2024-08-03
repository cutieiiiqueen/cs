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
import uuu.cs.exception.CSDataInvalidException;
import uuu.cs.exception.CSException;
import uuu.cs.service.CustomerService;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register.do") //http://localhost:8080/cs/register.do
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		//1.取得request中的form data
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String password = request.getParameter("password");
		String password_check = request.getParameter("password_check");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String birthday = request.getParameter("birthday");
		String address = request.getParameter("address");
		String captcha = request.getParameter("captcha");
		
		//1.1檢查必要欄位: email, phone, password, name, gender, birthday        
        if(email==null || (email=email.trim()).length()==0) {
            errors.add("必須輸入email");
        } 
        if(phone==null || (phone=phone.trim()).length()==0) {
            errors.add("必須輸入手機");
        } 
        if(password==null || password.length()==0 || !password.equals(password_check)) {
            errors.add("必須輸入一致的密碼");
        }   
        if(name==null || (name=name.trim()).length()==0) {
            errors.add("必須輸入姓名");
        }        
        if(birthday==null || (birthday=birthday.trim()).length()==0) {
            errors.add("必須輸入生日");
        }
        if(gender==null || (gender=gender.trim()).length()==0) {
            errors.add("必須輸入性別");
        }
        if(address!=null) { //for<textarea>防呆
            address=address.trim();
        }
        if(captcha==null || (captcha=captcha.trim()).length()==0) {
            errors.add("必須輸入驗證碼");
		}else {
			//檢查驗證碼
			String sessionCaptcha = (String)session.getAttribute("captcha");
			if(!captcha.equalsIgnoreCase(sessionCaptcha)) {
				errors.add("驗證碼不正確");
			}
		session.removeAttribute("captcha"); //防止資安問題
		}
		
        
        //2.若無誤，呼叫商業邏輯
		if(errors.isEmpty()) {
			Customer c = new Customer();
			try {
				//執行商業邏輯
				c.setEmail(email);
				c.setPhone(phone);
				c.setPassword(password);
				c.setName(name);
				c.setGender(gender.charAt(0));
				c.setBirthday(birthday);
				c.setAddress(address);
				
				CustomerService cService = new CustomerService();
				cService.register(c);
			    
				request.setAttribute("customer", c); //把c物件借放在request範圍, 跟著request轉交
				//3.1 forward(內部轉交)註冊成功網頁: register_ok.jsp
				RequestDispatcher dispatcher = request.getRequestDispatcher("register_ok.jsp");
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
		
		request.setAttribute("errors", errors);
		//3.2 forward(內部轉交)註冊失敗網頁: register.jsp
		RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
		dispatcher.forward(request, response);
	}

}
