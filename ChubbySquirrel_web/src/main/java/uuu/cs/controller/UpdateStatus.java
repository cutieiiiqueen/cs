package uuu.cs.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import uuu.cs.exception.CSException;
import uuu.cs.service.ManageService;

/**
 * Servlet implementation class updateStatus
 */
@WebServlet("/updateStatus.do")
@MultipartConfig
public class UpdateStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String statusStr = request.getParameter("orderStatus");
		String paymentNote = request.getParameter("paymentNote");
		String shippingNote = request.getParameter("shippingNote");
		String orderIdStr = request.getParameter("orderId");
		
		System.out.println("orderIdStr: " + orderIdStr);
		System.out.println("statusStr: " + statusStr);
		System.out.println("paymentNote: " + paymentNote);
		System.out.println("shippingNote: " + shippingNote);
		System.out.println("All Parameters: " + request.getParameterMap());
		System.out.println("Request Method: " + request.getMethod());
		System.out.println("Content Type: " + request.getContentType());
		System.out.println("Character Encoding: " + request.getCharacterEncoding());

		paymentNote = (paymentNote == null || paymentNote.trim().isEmpty()) ? "" : paymentNote.trim();
		shippingNote = (shippingNote == null || shippingNote.trim().isEmpty()) ? "" : shippingNote.trim();

		if ((orderIdStr != null && !orderIdStr.isEmpty()) && (statusStr != null && !statusStr.isEmpty())) {
		    try {
		        int status = Integer.parseInt(statusStr);
		        int orderId = Integer.parseInt(orderIdStr);
		        
		        ManageService manageService = new ManageService();
		        manageService.updateOrderStatus(orderId, status, paymentNote, shippingNote);
		        response.getWriter().write("success");
		        
		    } catch (CSException e) {
		        this.log("更新訂單狀態失敗", e);
		        response.getWriter().write("失敗: " + e.getMessage());
		    } catch (Exception e) {
		        this.log("更新訂單狀態發生非預期錯誤", e);
		        response.getWriter().write("錯誤: " + e.getMessage());
		    }
		} else {
		    response.getWriter().write("orderId或status不得為空");
		}
	}

}
