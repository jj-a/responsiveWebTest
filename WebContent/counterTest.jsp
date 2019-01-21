<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:useBean id="visit" class="net.utility.Visit" scope="application" />

	<div id="visitor-box">
		<h6>
			<%
				String ip = request.getRemoteAddr();
				out.println(ip + " 님, 안녕하세요! ");
				visit.ipCheck(ip);
			%>
		</h6>
	</div>

	<%
		if (session.isNew()) {
	%>
	<jsp:setProperty property="counter" name="visit" value="1" />
	<%
		}
	%>

	<h2>
		총 방문자 수 :
		<jsp:getProperty property="counter" name="visit" />
	</h2>

</body>
</html>