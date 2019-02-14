<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${action} 중복 확인</title>
<%@ include file="../includeNewWin.jsp"%>
</head>
<body>

	<div>
		<h3>${action} 중복확인 결과</h3>
		
		입력 ${action}: <strong>${checkvalue}</strong>
		<c:choose>
			<c:when test="${cnt==0}">
				<p>사용 가능한 ${action}입니다.</p>
				<input type="button" value="사용" onclick="apply('${checkvalue}')">
			</c:when>
			<c:otherwise>
				<p style='color: red;'>해당 ${action}는 이미 사용중입니다.</p>
				<input type="button" value="뒤로가기" onclick="history.back()">
			</c:otherwise>
		</c:choose>
		<input type="button" value="닫기" onclick="window.close()">

	</div>


<script>
function apply(checkvalue){
		// opener(parent창)의 'regForm' - checkvalue에 값 전달
		<c:choose>
			<c:when test="${action=='아이디'}">
				opener.document.regForm.id.value=checkvalue;
			</c:when>
			<c:when test="${action=='이메일'}">
				opener.document.regForm.email.value=checkvalue;
			</c:when>
		</c:choose>
		window.close();
}
</script>

</body>
</html>
