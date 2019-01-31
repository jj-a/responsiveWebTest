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
  <td><strong>공지사항 관리</strong></td>
  <td>
    <input type="button" value="순서 조정" onclick="move('memList.jsp')">
  </td>
  <td>
    <input type="button" value="공지사항 쓰기" onclick="move('notiWrite.jsp')">
  </td>
  <td>
    <input type="button" value="공지사항 수정" onclick="move('notiUpdate.jsp')">
  </td>
  <td>    
     <input type="button" value="공지사항 삭제" onclick="move('notiDelete.jsp')">
  </td>
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
