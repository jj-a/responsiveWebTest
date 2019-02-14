package net.member2;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.CommandAction;
import net.member.MemberDAO;
import net.member.MemberDTO;
import net.utility.Utility;

public class Login implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		String id=req.getParameter("id").trim();
		String passwd=req.getParameter("passwd").trim();

		MemberDAO dao=new MemberDAO();

		MemberDTO dto=new MemberDTO();
		dto.setId(id);
		dto.setPasswd(passwd);
		
		String mlevel=dao.login(dto);
		
		if(mlevel==null) {
			;
		}else {
			
			// Session 정보 // 로그인 정보 유지
			HttpSession session=req.getSession();
			session.setAttribute("s_id", id);
			session.setAttribute("s_passwd", passwd);
			session.setAttribute("s_mlevel", mlevel);

			// Cookie // 아이디 저장
			String c_id = Utility.checkNull(req.getParameter("c_id")); // null=빈 문자열 반환
			Cookie cookie=null;
			if (c_id.equals("SAVE")) {
				// new Cookie("쿠키변수",값);
				cookie=new Cookie("c_id",id);
				cookie.setMaxAge(60*60*24*30);	// cookie 존속기간 (초) - 1개월
			} else {
				cookie=new Cookie("c_id","");
				cookie.setMaxAge(0);	// cookie 존속기간 (초)
			}
			
			// Client PC에 cookie 저장
			resp.addCookie(cookie);
			
		}
		
		return "login.jsp";
		
	} // requestPro() end

}
