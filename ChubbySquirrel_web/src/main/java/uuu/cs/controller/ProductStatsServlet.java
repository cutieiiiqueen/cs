package uuu.cs.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import uuu.cs.entity.ProductStats;
import uuu.cs.exception.CSException;
import uuu.cs.service.ManageService;

@WebServlet("/productStats.do")
public class ProductStatsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	Gson gson = new Gson(); //建立gson物件
    	response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String monthStr = request.getParameter("month");
        int month = Integer.parseInt(monthStr);

        try {
        	ManageService manageService = new ManageService();
            ProductStats stats = manageService.getProductStatsMonth(month);
            
            String json = gson.toJson(stats);
            
            try (PrintWriter out = response.getWriter()) {
                out.print(json); //print可以直接輸出對象, write輸出字串等
                out.flush(); //確保所有數據被寫入, 清空暫存區
                //out.close(); 這邊因為用try-with-resources自動關閉, 所以可以不用寫out.close
            }
            
		}catch(CSException e) {
			this.log("取得產品統計月份失敗", e);
		}catch(Exception e) {
			this.log("取得產品統計月份發生非預期錯誤", e);
		}
    }
}
