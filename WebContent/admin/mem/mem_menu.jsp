<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminAuth.jsp"%>
<base target="sub-content">
<form name="memfrm" method="post">
<table>
<tr>
  <td><strong>회원관리</strong></td>
  <td>
    <input type="button" value="회원목록" onclick="move('memList.jsp')">
  </td>
  <td>
    <input type="button" value="회원등급조정" onclick="move('memLevel.jsp')">
  </td>
  <td>    
     <input type="button" value="회원삭제" onclick="move('memDel.jsp')">
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
