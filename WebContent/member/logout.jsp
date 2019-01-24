<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<p>&nbsp;</p>

<%
	session.removeAttribute("s_id");
	session.removeAttribute("s_passwd");
	session.removeAttribute("s_mlevel");

	response.sendRedirect("loginForm.jsp");
%>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>

