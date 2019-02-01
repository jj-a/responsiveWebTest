<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminAuth.jsp"%>
<%@ include file="../includeCss.jsp"%>
<%@ include file="../includeJs.jsp"%>

<!-- Contents -->

<div class="wrap">
	<h3>공지사항 작성</h3>

	<form name="noticefrm" method="post" action="../../notice/noticeIns.jsp" onsubmit="return noticeCheck(this)">
		<input type="hidden" name="wname" value="wname" required>
		<table class="writefrm">
			<tr>
				<th>작성자</th>
				<td><%=s_adm_id%></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="subject" size="20" maxlength="100" required></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="5" cols="30" name="content"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="submit" value="등록"> 
				<input type="reset" value="지우기"> 
				<input type="button" value="취소" onclick="javascript:history.back()">
				</td>
			</tr>
		</table>
	</form>
	
</div>

<!-- Contents end -->
