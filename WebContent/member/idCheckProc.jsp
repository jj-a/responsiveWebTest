<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="ssi.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>idCheckProc.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/stylesheet.css?ver=1.008">
</head>
<body>

	<div>
		<h3>아이디 중복확인 결과</h3>
		<%
			String id = request.getParameter("id").trim();
			int cnt = dao.duplecateID(id);
			out.println("입력 ID: <strong>" + id + "</strong>");

			if (cnt == 0) {
		%>
			<p>사용 가능한 아이디입니다.</p>
			<input type="button" value="사용" onclick="apply('<%=id%>')">
		<%
			} else {
		%>
			<p style='color: red;'>해당 아이디는 이미 사용중입니다.</p>
			<input type="button" value="뒤로가기" onclick="history.back()">
		<%
			}
		%>
		<input type="button" value="닫기" onclick="window.close()">

	</div>


<script>
function apply(id){
		// opener(parent창)의 'regForm' - id에 값 전달
		opener.document.regForm.id.value=id;
		window.close();
}
</script>

</body>
</html>
