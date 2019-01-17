<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h1>* 답변 등록 *</h1>
<p>
	<a href="bbsList.jsp">[글 목록]</a>
</p>
<%
	// parent의 글번호 소환
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
%>

<!-- bbsno, wname, subject, content, passwd, ip -->

<form name="bbsfrm" method="post" action="bbsReplyProc.jsp">
	<input type="hidden" name="bbsno" value="<%=bbsno%>">
	<table class="writefrm" border="1">
		<tr>
			<th>작성자</th>
			<td><input type="text" name="wname" size="10" maxlength="20" required></td>
		</tr><tr>
			<th>제목</th>
			<td><input type="text" name="subject" size="20" maxlength="100" required></td>
		</tr><tr>
			<th>내용</th>
			<td><textarea rows="5" cols="30" name="content"></textarea></td>
		</tr><tr>
			<th>비밀번호</th>
			<td><input type="password" name="passwd" size="10"></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="답변등록"> <input type="reset" value="지우기"> <input type="button" value="취소" onclick="javascript:history.back()"></td>
		</tr>
	</table>
</form>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>

