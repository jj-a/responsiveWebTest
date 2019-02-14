package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class MbInsert implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		// 1) 사용자가 입력한 정보를 변수에 저장

		String id = req.getParameter("id").trim();
		String passwd = req.getParameter("passwd").trim();
		String mname = req.getParameter("mname").trim();
		String tel = req.getParameter("tel").trim();
		String email = req.getParameter("email").trim();
		String zipcode = req.getParameter("zipcode").trim();
		String address1 = req.getParameter("address1").trim();
		String address2 = req.getParameter("address2").trim();
		String job = req.getParameter("job").trim();
		
		MemberDTO dto=new MemberDTO();
		
		// 2) dto Object에 저장
		dto.setId(id);
		dto.setPasswd(passwd);
		dto.setMname(mname);
		dto.setTel(tel);
		dto.setEmail(email);
		dto.setZipcode(zipcode);
		dto.setAddress1(address1);
		dto.setAddress2(address2);
		dto.setJob(job);
		
		MemberDAO dao=new MemberDAO();
		int res = dao.join(dto);
		
		req.setAttribute("res",res);
		
		return "joinProc.jsp";
		
	} // requestPro() end

}
