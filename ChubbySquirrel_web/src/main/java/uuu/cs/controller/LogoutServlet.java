package uuu.cs.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logout.do")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); //只取舊的session, 不要建立新的session
		//1.登出不須取得資料
		//2.呼叫網站登出邏輯
		if(session!=null) {
			session.invalidate();
		}
		//3.內部轉交(forward)回首頁(這裡不適合用內部轉交)
		//request.getRequestDispatcher("./").forward(request, response);//從哪裡轉交就會是哪裡的網址
		
		//3.外部轉址(redirect)回首頁(這裡適合用外部轉址)
		response.sendRedirect("login.jsp");
	}

}
