<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<p>&nbsp;</p>

<% 
	String id = request.getParameter("id").trim();
	String passwd = request.getParameter("passwd").trim();

	dto.setId(id);
	dto.setPasswd(passwd);
	
	String mlevel = dao.login(dto);

	if (mlevel==null) {
		out.println("<script>");
		out.println("alert('아이디가 없거나 아이디/비밀번호가 일치하지 않습니다.');");
		out.println("history.back();");
		out.println("</script>");
	} else {
		
		// Session 정보 // 로그인 정보 유지
		session.setAttribute("s_id", id);
		session.setAttribute("s_passwd", passwd);
		session.setAttribute("s_mlevel", mlevel);
		
		out.println("<script>");
		out.println("alert('로그인되었습니다.');");	// 스크립트가 안먹혀요...
		String root=request.getContextPath();
		response.sendRedirect(root+"/index.jsp");
		out.println("</script>");
%>

<!-- else --> 

<%
	}
%>


<!-- Contents end -->

<%@ include file="../footer.jsp"%>

