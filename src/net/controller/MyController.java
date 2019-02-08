package net.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class MyController extends HttpServlet {

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req,resp);
	} // doGet() end

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req,resp);
	} // doPost() end

	
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			resp.setContentType("text/html;charset=UTF-8");
			req.setCharacterEncoding("UTF-8");
			PrintWriter out=resp.getWriter();
			
			String id=req.getParameter("id").trim();
			String passwd=req.getParameter("passwd").trim();
			
			
			// 다른 페이지에서 동작되도록 scope 설정
			
			// session 객체 선언
			HttpSession session=req.getSession();
			
			// application 객체 선언
			ServletContext application=req.getServletContext();
			
			if(id.equals("admin")&&passwd.equals("$admin$")) {
				
				req.setAttribute("msg","로그인 성공");
				req.setAttribute("img","<img src='control/011.gif'>");
				
				req.setAttribute("r_id",id);
				req.setAttribute("r_passwd",passwd);
				
				session.setAttribute("s_id",id);
				session.setAttribute("s_passwd",passwd);
				
				application.setAttribute("a_id",id);
				application.setAttribute("a_passwd",passwd);
				
			}else {
				
				req.setAttribute("msg","로그인 실패");
				req.setAttribute("img","<img src='011.gif'>");
				
				req.setAttribute("r_id","guest");
				req.setAttribute("r_passwd","guest");
				
				session.setAttribute("s_id","guest");
				session.setAttribute("s_passwd","guest");
				
				application.setAttribute("a_id","guest");
				application.setAttribute("a_passwd","guest");
				
			}
			
			String view="control/loginResult.jsp";
			RequestDispatcher disp=req.getRequestDispatcher(view);
			disp.forward(req,resp);
			
			
			
		}catch (Exception e) {
			System.out.println("Request Failed! "+e);
		}
		
	} // process() end
	
	
	
}
