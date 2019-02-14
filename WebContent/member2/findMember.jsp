<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3>아이디 찾기</h3>


<%

	if (!(s_id.equals("guest") || s_passwd.equals("guest") || s_mlevel.equals("E1"))) {
		// 비회원이 아닌 경우
%>
		<script>
		alert("로그인한 상태에선 아이디 찾기를 할 수 없습니다.");
		location.href="${pageContext.request.contextPath}/member/loginForm.jsp";
		</script>
<%		
	}else{

		String mname=request.getParameter("mname").trim();
		String tel=request.getParameter("tel").trim();
		String email=request.getParameter("email").trim();
		
		dto.setMname(mname);
		dto.setTel(tel);
		dto.setEmail(email);
		
		dto=dao.findID(dto);
		

%>

<table border="1" class="writefrm">
	<tr>
		<td colspan="2">아이디 찾기 결과</td>
	</tr>
	<tr>
		<th>아이디</th>
		<td><%=dto.getId()%></td>
	</tr>
	<tr>
	<td colspan="2">
	<input type="button" value="로그인" onclick="location.href='loginForm.jsp'">&nbsp;&nbsp;
	<input type="button" value="비밀번호 찾기" onclick="location.href='findIdpw.jsp'">
	</td>
	</tr>
</table>

<%
	}
%>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>