package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class DuplicateCheck implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {

		// 현재 페이지명 불러오기
		String pageName = req.getRequestURI(); 
		pageName = pageName.substring(pageName.lastIndexOf("/")+1, pageName.length());
		System.out.println(pageName);
		
		String value = req.getParameter("checkvalue").trim();
		
		MemberDAO dao=new MemberDAO();
		
		
		if(pageName.equals("idcheck.do")) {
			// 아이디 중복검사
			int cnt = dao.duplicateCheck("id",value);
			
			req.setAttribute("checkvalue", value);
			req.setAttribute("cnt", new Integer(cnt));
			req.setAttribute("action", "아이디");
			
		}else if(pageName.equals("mailcheck.do")) {
			// 이메일 중복검사

			int cnt = dao.duplicateCheck("email",value);

			req.setAttribute("checkvalue", value);
			req.setAttribute("cnt", new Integer(cnt));
			req.setAttribute("action", "이메일");
			
		}else {
			;
		}
		
		return "dupCheckProc.jsp";
		
	} // requestPro() end

}
