package uuu.cs.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.cs.entity.Customer;
import uuu.cs.service.TrackService;
import uuu.cs.exception.CSException;

@WebServlet("/track.do")
public class TrackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer member = (Customer) session.getAttribute("member");
		
		// 判斷登入狀態，若未登入則回傳not_logged_in，讓前端跳轉回登入頁面
		if (member == null) {
			response.getWriter().write("not_logged_in");
			return;
		}
		
		TrackService trackService = new TrackService();
		
		String action = request.getParameter("action");
		String productIdStr = request.getParameter("productId");
		
		if (action != null && productIdStr != null) {
			
				int productId = Integer.parseInt(productIdStr);
				if ("addTrack".equals(action)) {
					
					try {
						trackService.addTrackedProduct(member.getEmail(), productId);
						response.getWriter().write("success");

				    } catch (CSException e) {
				        this.log("[查詢追蹤清單]失敗", e);
				        response.getWriter().write("失敗: " + e.getMessage());
				    } catch (Exception e) {
				        this.log("[查詢追蹤清單]失敗發生非預期錯誤", e);
				        response.getWriter().write("錯誤: " + e.getMessage());
				    }
				} else if ("removeTrack".equals(action)) {
					
					try {
						trackService.removeTrackedProduct(member.getEmail(), productId);
						response.getWriter().write("success");
						
				    } catch (CSException e) {
				        this.log("[移除追蹤產品]失敗", e);
				        response.getWriter().write("失敗: " + e.getMessage());
				    } catch (Exception e) {
				        this.log("[移除追蹤產品]失敗發生非預期錯誤", e);
				        response.getWriter().write("錯誤: " + e.getMessage());
				    }				

				} else {
					response.getWriter().write("error");
				}
		}
	}
}