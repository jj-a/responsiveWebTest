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
<!-- 
	<table>
		<tr>
			<td><strong>공지사항 관리</strong></td>
			<td><input type="button" value="새 공지 작성" onclick="move('notiForm.jsp')"></td>
			<td><input type="button" value="공지 순서 조정" onclick="move('notiOrder.jsp')"></td>
			<td><input type="button" value="공지사항 관리" onclick="move('notiManagement.jsp')"></td>
		</tr>
	</table>
-->
	<div class="sub-menu">
			<strong>공지사항 관리</strong>
			<input type="button" value="새 공지 작성" onclick="move('notiForm.jsp')">
			<input type="button" value="공지 순서 조정" onclick="move('notiOrder.jsp')">
			<input type="button" value="공지사항 관리" onclick="move('notiManagement.jsp')">
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
