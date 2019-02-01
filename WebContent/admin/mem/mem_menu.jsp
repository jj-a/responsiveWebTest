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
	<table>
		<tr>
			<td><strong>회원 관리</strong></td>
			<td><input type="button" value="회원목록" onclick="move('memList.jsp')"></td>
			<td><input type="button" value="회원등급조정" onclick="move('memLevel.jsp')"></td>
			<td><input type="button" value="회원삭제" onclick="move('memDelete.jsp')"></td>
		</tr>
	</table>
</form>

<script>
	function move(file) {
		document.memfrm.action = file;
		document.memfrm.submit();
	}
</script>
</body>
</html>
