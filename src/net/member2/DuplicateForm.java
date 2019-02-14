package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class DuplicateForm implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		// 현재 페이지명 불러오기
		String pageName = req.getRequestURI(); 
		pageName = pageName.substring(pageName.lastIndexOf("/")+1, pageName.length());
		System.out.println(pageName);
		
		if(pageName.equals("idcheckform.do")) 
			req.setAttribute("action", "아이디");
		else if(pageName.equals("mailcheckform.do")) 
			req.setAttribute("action", "이메일");
		else req.setAttribute("action", "");
		
		return "dupCheckForm.jsp";
		
	} // requestPro() end

}
