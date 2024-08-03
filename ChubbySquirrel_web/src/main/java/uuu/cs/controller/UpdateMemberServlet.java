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
import uuu.cs.entity.VIP;
import uuu.cs.exception.CSDataInvalidException;
import uuu.cs.exception.CSException;
import uuu.cs.service.CustomerService;

/**
 * Servlet implementation class UpdateServlet
 */
@WebServlet("/member/update.do") //htttp://localhotst:8080/cs/member/update.do
public class UpdateMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMemberServlet() {
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
		Customer member = (Customer)session.getAttribute("member");
		
		//1.取得request中的form data
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String password = request.getParameter("password");
		String newPassword = request.getParameter("newPassword");
		String newPasswordCheck = request.getParameter("newPasswordCheck");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String birthday = request.getParameter("birthday");
		String address = request.getParameter("address");
		String captcha = request.getParameter("captcha");
		
		if(!member.getEmail().equals(email)) {
			errors.add("不得竄改帳號!");  //防止user開F12修改掉帳號
		}
		
		//1.1檢查必要欄位: email, phone, password, name, gender, birthday        
        if(email==null || (email=email.trim()).length()==0) {
            errors.add("必須輸入email");
        } 
        if(phone==null || (phone=phone.trim()).length()==0) {
            errors.add("必須輸入手機");
        } 
        if(password==null || password.length()==0) {
            errors.add("必須輸入密碼");
        }
		if(!member.getPassword().equals(password)) {
			errors.add("必須輸入正確密碼");  
		}
        if(newPassword == null || newPasswordCheck == null) {
        } else if(!newPassword.equals(newPasswordCheck)) {
            errors.add("新密碼必須輸入一致");
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
			Customer c; //不可用原會員修改, 若修改失敗資料就已經被改掉了
					
			try {
				c = member.getClass().newInstance(); //用原來的客戶類別新增 
			} catch (InstantiationException | IllegalAccessException e) {
				c = new Customer();
			} 
			try {
				//執行商業邏輯
				c.setEmail(member.getEmail());
				c.setPhone(phone);
				if(newPassword==null || newPassword.length()==0) {
				    c.setPassword(password);
				}else {
				    c.setPassword(newPassword);
				}			
				c.setName(name);
				c.setGender(gender.charAt(0));
				c.setBirthday(member.getBirthday());
				c.setAddress(address);
				if(c instanceof VIP) {
					((VIP)c).setDiscount(((VIP)member).getDiscount());
				}
				
				CustomerService cService = new CustomerService();
				cService.update(c);	
				
				session.setAttribute("member", c);
				//3.1 forward內部轉交會員修改成功網頁: update_ok.jsp
				RequestDispatcher dispatcher = request.getRequestDispatcher("update_ok.jsp");
				dispatcher.forward(request, response);
			
			}catch(CSDataInvalidException e) {
				errors.add(e.getMessage()); //for user
			}catch (CSException e) {
				this.log(e.getMessage(), e); //for admin, tester, developer
				errors.add(e.getMessage()); //for user
			}catch (Exception e) {
				this.log("系統發生非預期錯誤", e); //for admin, tester, developer
				errors.add("系統發生錯誤:" + e.getMessage() + ", 請聯絡管理人員"); //for user
			}
		}else {
		
		request.setAttribute("errors", errors);
		//3.2 forward(內部轉交)會員修改失敗網頁: update.jsp
		RequestDispatcher dispatcher = request.getRequestDispatcher("/member/update.jsp");
		dispatcher.forward(request, response);
		}
	}

}
