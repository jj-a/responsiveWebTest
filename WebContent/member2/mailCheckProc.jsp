<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>idCheckProc.jsp</title>
<%@ include file="../includeNewWin.jsp"%>
</head>
<body>

	<div>
		<h3>이메일 중복확인 결과</h3>
		<%
			String email = request.getParameter("email").trim();
			int cnt = dao.duplecateMail(email);
			out.println("입력 이메일: <strong>" + email + "</strong>");

			if (cnt == 0) {
		%>
			<p>사용 가능한 이메일입니다.</p>
			<input type="button" value="사용" onclick="apply('<%=email%>')">
		<%
			} else {
		%>
			<p style='color: red;'>해당 이메일은 이미 사용중입니다.</p>
			<input type="button" value="뒤로가기" onclick="history.back()">
		<%
			}
		%>
		<input type="button" value="닫기" onclick="window.close()">

	</div>

<script>
function apply(email){
		// opener(parent창)의 'regForm' - email에 값 전달
		opener.document.regForm.email.value=email;
		window.close();
}
</script>

</body>
</html>
