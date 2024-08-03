package uuu.cs.controller;

import java.io.IOException;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;

/**
 * Servlet Filter implementation class CharSetFilter
 */
@WebFilter(urlPatterns = { "*.jsp", "*.do" }, 
	dispatcherTypes = {DispatcherType.REQUEST,DispatcherType.ERROR}) //除了*.jsp, *do之外, REQUEST及ERROR 編碼也是正確的
public class CharSetFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public CharSetFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// 先設定request與response的編碼
		request.setCharacterEncoding("UTF-8");
		request.getParameterNames(); //鎖定request的文字串流的編碼
		
		response.setCharacterEncoding("UTF-8"); //Java 2.4以後
		//response.setContentType("text/html;charset=utf8"); //舊寫法 
		response.getWriter(); //鎖定response的文字串流的編碼

		// pass the request along the filter chain 
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
