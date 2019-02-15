package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.CommandAction;

public class FindId implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		HttpSession session=req.getSession();
		String s_id=(String)session.getAttribute("s_id");
		String s_mlevel=(String)session.getAttribute("s_mlevel");
		//System.out.println("s_id: "+s_id);
		//System.out.println("s_mlevel: "+s_mlevel);
		
		if (s_id==null || s_mlevel.equals("E1")) {
		
			System.out.println("비회원입니다");
			
			String mname=req.getParameter("mname").trim();
			String tel=req.getParameter("tel").trim();
			String email=req.getParameter("email").trim();
			
			MemberDTO dto=new MemberDTO();
			
			dto.setMname(mname);
			dto.setTel(tel);
			dto.setEmail(email);
			
			MemberDAO dao=new MemberDAO();
			dto=dao.findID(dto);
			
			req.setAttribute("id",dto.getId());
			
		}
		
		return "findId.jsp";
		
	} // requestPro() end

}
