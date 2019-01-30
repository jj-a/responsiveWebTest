<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../member/ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<div align="center">
<h3><a href="#"> 관리자 페이지</a></h3>

<%
if(session.getAttribute("s_adm_id")==null || session.getAttribute("s_adm_passwd")==null || session.getAttribute("s_adm_mlevel")==null){
	// 관리자 비로그인 상태일 때
%>

<form method="post" action="adminProc.jsp">
<table class="writefrm" border=1>
<tr>
  <th colspan="2">로그인</th>
</tr>
<tr>
  <td>아이디</td>
  <td><input type="text" name="admid" size=20></td>
</tr>
<tr>
  <td>비밀번호</td>
  <td><input type="password" name="admpw" size=20></td>
</tr>
<tr>
  <td colspan=2 align=center>
    <input type="submit" value="확인">
    <input type="reset"  value="취소">
  </td>
</tr>
</table>
</form>
</div>

<%
}else {
	// 관리자 로그인 상태일 때
%>
<script>
alert("이미 관리자로 로그인 되어 있습니다.");
history.back();
</script>
<%
}
%>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>