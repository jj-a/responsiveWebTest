package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.CommandAction;

public class Withdraw implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {

		HttpSession session=req.getSession();
		String s_id=(String)session.getAttribute("s_id");
		String passwd=req.getParameter("passwd").trim();
		String email=req.getParameter("email").trim();
		
		System.out.println("s_id: "+s_id);
		System.out.println("passwd: "+passwd);
		System.out.println("email: "+email);
		
		MemberDTO member=new MemberDTO();
		member.setId(s_id);
		member.setPasswd(passwd);
		member.setEmail(email);
		
		// 회원 탈퇴 수행 (F1등급 변경)
		MemberDAO dao=new MemberDAO();
		int res = dao.withdraw(member);
		
		req.setAttribute("res",res);
		
		return "withdraw.jsp";
		
	} // requestPro() end

}
