package net.utility;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class EncodeFilter implements Filter {

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2) throws IOException, ServletException {
		// request 전, response 후의 코드 처리
		
		arg0.setCharacterEncoding("UTF-8");
		arg2.doFilter(arg0, arg1);

	} // doFilter() end
	
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// Servlet 최초 호출 시
		//Filter.super.init(filterConfig);
		System.out.println("Started Servlet");
	}
	

	@Override
	public void destroy() {
		// Servlet 종료 시
		//Filter.super.destroy();
		System.out.println("Ended Servlet");
	}
	

}
