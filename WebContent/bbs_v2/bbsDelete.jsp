<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h3><a href="bbsList.jsp"> 게시글 삭제 </a></h3>
<p><a href="bbsList.jsp">[글 목록]</a></p>

<form method="post" action="bbsDeleteProc.jsp" onsubmit="return delPwCheck(this)">
	<input type="hidden" name="bbsno" value="<%=request.getParameter("bbsno")%>">
	<input type="hidden" name="col" value="<%=request.getParameter("col")%>">
	<input type="hidden" name="word" value="<%=word%>">
	<table class="writefrm" border=1>
		<tr>
			<td colspan="2">비밀번호를 입력해주세요.</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="passwd" size="5" min="0" max="100" autofocus></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="확인"> <input type="button" value="취소" onclick="javascript:history.back()"></td>
		</tr>
	</table>
</form>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>
