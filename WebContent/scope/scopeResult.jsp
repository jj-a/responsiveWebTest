<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>scopeResult.jsp</title>
</head>
<body>
	<h3>웹페이지의 Scope(유효범위) 결과</h3>
	<%
		out.println("<br>pageContext영역: " + pageContext.getAttribute("kor"));
		out.println("<br>request영역: " + request.getAttribute("eng"));
		out.println("<br>session영역: " + session.getAttribute("mat"));
		out.println("<br>application영역: " + application.getAttribute("uname"));

		out.println();
		out.println("");
	%>

	<h6>
	Foward로 페이지 로딩하면 request로 받은 attribute 값이 살아있고, 
	링크나 response로 접근하면 request의 attribute가 죽어있음
	</h6>


</body>
</html>