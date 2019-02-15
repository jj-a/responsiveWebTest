package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class MemberPwCheck implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		// 이동하려는 페이지 (회원정보수정:modifyform/탈퇴:withdraw)
		String page=req.getParameter("page");
		String action="";
		
		if(page.equals("modifyform"))
			action="정보 수정";
		else if(page.equals("withdraw"))
			action="탈퇴";
		
		req.setAttribute("page",page);
		req.setAttribute("action",action);
		
		return "mbCheck.jsp";
		
	} // requestPro() end

}
