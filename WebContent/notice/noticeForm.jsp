<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../admin/adminAuth.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3>* 글쓰기 *</h3>
<p><a href="noticeList.jsp">[글 목록]</a></p>

<%
	if (s_adm_id.equals("guest") || s_adm_passwd.equals("guest") || s_adm_mlevel.equals("E1")) {
		// 비회원, 로그인 안한 경우
%>
		<script>
		alert("관리자만 접근 가능한 페이지입니다.");
		location.href="${pageContext.request.contextPath}/member/loginForm.jsp";
		</script>
<%		
	}else{
%>
<form name="noticefrm" method="post" action="noticeIns.jsp" onsubmit="return noticeCheck(this)">
	<input type="hidden" name="wname" value="wname" required>
	<table class="writefrm" border=1>
		<tr>
			<th>작성자</th>
			<td><%=s_adm_id%></td>
		</tr><tr>
			<th>제목</th>
			<td><input type="text" name="subject" size="20" maxlength="100" required></td>
		</tr><tr>
			<th>내용</th>
			<td><textarea rows="5" cols="30" name="content"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<input type="submit" value="등록"> <input type="reset" value="지우기"> <input type="button" value="취소" onclick="javascript:history.back()">
			</td>
		</tr>
	</table>
</form>

<script>
$(document).ready(function() { 
	;
});
</script>

<% 
	} // else end
%>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>
