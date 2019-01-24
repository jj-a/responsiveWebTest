<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<%
	String id = request.getParameter("id").trim();
	String passwd = request.getParameter("passwd").trim();

	dto.setId(id);
	dto.setPasswd(passwd);

	String mlevel = dao.login(dto);

	if (mlevel == null) {
		out.println("<script>");
		out.println("alert('아이디가 없거나 아이디/비밀번호가 일치하지 않습니다.');");
		out.println("history.back();");
		out.println("</script>");
	} else {

		// Session 정보 // 로그인 정보 유지
		session.setAttribute("s_id", id);
		session.setAttribute("s_passwd", passwd);
		session.setAttribute("s_mlevel", mlevel);

		// Cookie // 아이디 저장
		String c_id = Utility.checkNull(request.getParameter("c_id")); // null=빈 문자열 반환
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
		response.addCookie(cookie);
		

		out.println("<script>");
		out.println("alert('로그인되었습니다.');"); // 스크립트가 안먹혀요...
		String root = request.getContextPath();
		response.sendRedirect(root + "/index.jsp");
		out.println("</script>");
%>

<!-- else -->

<%
	}
%>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>