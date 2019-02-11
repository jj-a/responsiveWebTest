package net.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;


public class MyController extends HttpServlet {
	
	private Map<Object,Object> commandMap=new HashMap<>();	//
	
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		// web.xml의 init-param 값을 읽어옴
		
		String props=config.getInitParameter("propertyConfig");	// param-name
		Properties pr=new Properties();	
		FileInputStream f=null;
		
		try {
			f=new FileInputStream(props);	// command.properties 파일 가져오기
			pr.load(f);	// Properties객체에 properties 파일 저장
			
		}catch(Exception e) {
			System.out.println("Error(1)! "+e);
		}finally {
			if (f != null)
				try {
					f.close();
				} catch (Exception e) {;}
		} // try~catch~finally end
		
		
		Iterator<Object> iter=pr.keySet().iterator();
		
		while(iter.hasNext()) {	// Properties 순차 접근
			
			String key=(String)iter.next();
			String value=pr.getProperty(key);
			System.out.println(key+"/"+value);
			
			try {
				Class<?> commandClass=Class.forName(value);	// 문자열을 클래스로 생성
				Object commandInstance=commandClass.newInstance();
				commandMap.put(key,commandInstance);	// Map 객체에 저장
				
			}catch(Exception e) {
				System.out.println("Error(2)! "+e);
			} // try~catch end
		} // while end
		
		
	} // init() end

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req,resp);
	} // doGet() end

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req,resp);
	} // doPost() end

	
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String view=null;
		CommandAction com=null;	// super interface
		
		try {

			String command=req.getRequestURI();
			com=(CommandAction)commandMap.get(command);	// 다형성
			view=com.requestPro(req, resp);	// Throwable catch해줘야함
			
		}catch (Throwable e) {	// requestPro() throws catch
			throw new ServletException(e);
		}

		// 현재 페이지에서 발생한 요청(req)/응답(resp) 객체를 가진 상태로 이동 (url=현재페이지 url)
		RequestDispatcher disp=req.getRequestDispatcher(view);
		disp.forward(req,resp);	// 페이지로 뿌리기
		
	} // process() end
	
	
	
}
