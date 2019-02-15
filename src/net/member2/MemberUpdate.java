package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class MemberUpdate implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {

		String id=req.getParameter("id").trim();
		String passwd=req.getParameter("passwd").trim();
		String mname=req.getParameter("mname").trim();
		String email=req.getParameter("email").trim();
		String tel=req.getParameter("tel").trim();
		String zipcode=req.getParameter("zipcode").trim();
		String address1=req.getParameter("address1").trim();
		String address2=req.getParameter("address2").trim();
		String job=req.getParameter("job").trim();
		
		MemberDTO member=new MemberDTO();
		member.setId(id);
		member.setPasswd(passwd);
		member.setMname(mname);
		member.setEmail(email);
		member.setTel(tel);
		member.setZipcode(zipcode);
		member.setAddress1(address1);
		member.setAddress2(address2);
		member.setJob(job);

		MemberDAO dao=new MemberDAO();
		int res = dao.modify(member);
		
		req.setAttribute("res",res);
		
		return "mbModiProc.jsp";
		
	} // requestPro() end

}
