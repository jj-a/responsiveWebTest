<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../adminAuth.jsp"%>
<%@ include file="../../member/ssi.jsp"%>

<%
	String id = request.getParameter("id").trim();
	String mlevel = request.getParameter("mlevel").trim();

	int res = dao.levelChange(id, mlevel);

	if (res == 0) {
		out.println("<script>");
		out.println("alert('회원등급 변경에 실패했습니다.');");
		out.println("history.back();");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('회원등급이 변경되었습니다.');");
		out.println("location.href='memLevel.jsp';");
		out.println("</script>");
	}
%>
