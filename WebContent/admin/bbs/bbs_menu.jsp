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
  <td><strong>게시판 관리</strong></td>
  <td><input type="button" value="게시판 글관리" onclick="move('bbsManagement.jsp')"></td>
  <td><input type="button" value="갤러리 글관리" onclick="move('pdsManagement.jsp')"></td>
</tr>
</table>
</form>

<script>
function move(file){
	document.memfrm.action=file;
	document.memfrm.submit();
}
</script>
</body>
</html>
