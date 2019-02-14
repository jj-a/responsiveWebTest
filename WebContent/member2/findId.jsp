<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3>아이디/비밀번호 찾기</h3>

<%

	if (!(s_id.equals("guest") || s_passwd.equals("guest") || s_mlevel.equals("E1"))) {
		// 비회원이 아닌 경우
%>
		<script>
		alert("로그인한 상태에선 아이디/비밀번호 찾기를 할 수 없습니다.");
		location.href="${pageContext.request.contextPath}/member/loginForm.jsp";
		</script>
<%		
	}else{
%>

<!-- 아이디 찾기 폼 -->
<div id="left-box">
<h4>FIND ID</h4>
<form name="findpwForm" method="post" action="findIdProc.jsp" onsubmit="return memberCheck(this)">
	<table border="1" class="writefrm">
		<tr>
			<td colspan="3">회원가입 시 입력했던 정보를 입력해주세요.</td>
		</tr>
		<tr>
			<th>이름</th>
			<td colspan="2"><input type="text" name="mname" id="mname" size="10" required></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="text" name="tel" id="tel" size="10"></td>
			<td><h6 style="margin:0 auto;">하이픈(-) 포함 입력</h6></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td colspan="2"><input type="text" name="email" id="email" size="30">
			</td>
		</tr>
		<tr>
			<td colspan="3"><input type="submit" value="아이디 찾기"></td>
		</tr>
	</table>
</form>
</div>

<!-- 비밀번호 찾기 폼 -->
<div id="right-box">
<h4>FIND PW</h4>
<form name="findpwForm" method="post" action="findPwProc.jsp" onsubmit="return memberCheck(this)">
	<table border="1" class="writefrm">
		<tr>
			<td colspan="3">이메일로 임시 비밀번호가 전송됩니다.</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td colspan="2"><input type="text" name="id" id="id" size="10" required></td>
		</tr>
		<tr>
			<th>이름</th>
			<td colspan="2"><input type="text" name="mname" id="mname" size="10" required></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="text" name="tel" id="tel" size="10"></td>
			<td><h6 style="margin:0 auto;">하이픈(-) 포함 입력</h6></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td colspan="2"><input type="text" name="email" id="email" size="30" required>
			</td>
		</tr>
		<tr>
			<td colspan="3"><input type="submit" value="비밀번호 찾기"></td>
		</tr>
	</table>
</form>
<input type="button" value="취소" onclick="history.back()">
</div>
<%
	}
%>
<!-- Contents end -->

<%@ include file="../footer.jsp"%>