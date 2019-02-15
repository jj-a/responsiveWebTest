package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.CommandAction;

public class MemberUpdateForm implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		HttpSession session=req.getSession();
		String s_id=(String)session.getAttribute("s_id");
		String s_mlevel=(String)session.getAttribute("s_mlevel");
		String passwd=req.getParameter("passwd").trim();

		MemberDTO member=new MemberDTO();
		MemberDAO dao=new MemberDAO();
		
		if (!(s_id==null || s_mlevel.equals("E1") || s_mlevel.equals("F1"))) {
			// 비회원, 로그인 안한 경우 제외
			
			member.setId(s_id);
			member.setPasswd(passwd);

			// 기존 회원정보 로드
			member = dao.loadInfo(member);
			
			if(member!=null)  req.setAttribute("member", member);
			/*
			// 비밀번호가 일치하지 않아서 정보를 불러오지 못했을 시 "false" 세팅
			if(member==null) req.setAttribute("member", new Boolean(false));
			else req.setAttribute("member", member);
			*/
		}
		
		return "mbModiForm.jsp";
		
	} // requestPro() end

}
