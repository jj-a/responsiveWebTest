<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h3><a href="#"> 로그인 </a></h3>
<p>&nbsp;</p>
<form name="loginFrm" method="post" action="loginProc.jsp" onsubmit="return loginCheck(this)">
	<table class="writefrm" border=1>
		<tr>
			<td>ID</td>
			<td colspan=2><input type="text" name="id" id="id" size="10" maxlength="16" placeholder="아이디"></td>
		</tr>
		<tr>
			<td>PASSWORD</td>
			<td colspan=2><input type="password" name="passwd" id="passwd" size="10" maxlength="16" placeholder="비밀번호"></td>
		</tr>
		<tr>
			<td colspan=3><input type="image" src="../images/bt_login.gif" style="cursor:pointer"></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="saveid" id="saveid"> Save ID</td>
			<td><a href="agreement.jsp">JOIN</a></td>
			<td><a href="#">Find ID/PW</a></td>
		</tr>
	</table>
</form>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>

