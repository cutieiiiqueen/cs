package uuu.cs.controller;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import uuu.cs.entity.Customer;
import uuu.cs.entity.VIP;
import uuu.cs.exception.CSException;
import uuu.cs.service.ManageService;

@WebServlet("/manageCustomer.do")
@MultipartConfig
public class ManageCustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String action = request.getParameter("action");
        String email = request.getParameter("email");
        ManageService manageService = new ManageService();
        
            if ("updateCustomer".equals(action)) {     
            	try{
	                String password = request.getParameter("password");
	                String phone = request.getParameter("phone");
	                String name = request.getParameter("name");
	                String gender = request.getParameter("gender");
	                String birthday = request.getParameter("birthday");
	                String address = request.getParameter("address");
	                String discount = request.getParameter("discount");
	
	                VIP updatedCustomer = new VIP();
	                updatedCustomer.setEmail(email);                
	                updatedCustomer.setPassword(password);
	                updatedCustomer.setPhone(phone);
	                updatedCustomer.setName(name);
	                updatedCustomer.setGender(gender.charAt(0));
	                updatedCustomer.setBirthday(LocalDate.parse(birthday));
	                updatedCustomer.setAddress(address);
	                updatedCustomer.setDiscount(Integer.parseInt(discount));
	                
	                System.out.print(updatedCustomer);
	                manageService.updateCustomer(updatedCustomer);
	                
	                response.getWriter().write("success");
	                
				}catch(CSException e) {
					this.log("後台[修改會員]失敗", e);
				}catch(Exception e) {
					this.log("後台[修改會員]發生非預期錯誤", e);
				}
                
            } else if ("delete".equals(action)) {
            	
            	try {
	                manageService.deleteCustomer(email);
	                response.getWriter().write("success");
	                
				}catch(CSException e) {
					this.log("後台[刪除會員]失敗", e);
				}catch(Exception e) {
					this.log("後台[刪除會員]發生非預期錯誤", e);
				} 
            }
    }
}