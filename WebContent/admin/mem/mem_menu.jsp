<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminAuth.jsp"%>
<base target="sub-content">
<style>
body, table, input {
	font-size: 16px;
}

td {
	padding: 0 5px 0 5px;
}
</style>
<form name="memfrm" method="post">
	<div class="sub-menu">
			<strong>회원 관리</strong>
			<input type="button" value="회원목록" onclick="move('memList.jsp')">
			<input type="button" value="회원등급조정" onclick="move('memLevel.jsp')">
			<input type="button" value="회원삭제" onclick="move('memDelete.jsp')">
	</div>
</form>

<script>
	function move(file) {
		document.memfrm.action = file;
		document.memfrm.submit();
	}
</script>
</body>
</html>
