<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp"%>
<!-- 본문 시작 mailForm.jsp -->
<h3>* 문의 메일 보내기 *</h3>
<form name='mailForm' class="writefrm" method='post' action="mailProc.jsp">
	<table>
		<tr>
			<th bgcolor='silver'>받는 사람</th>
			<td><input type="text" name="to" size="30"></td>
		</tr>
		<tr>
			<th bgcolor="silver">보내는 사람</th>
			<td><input type="text" name="from" size="30"></td>
		</tr>
		<tr>
			<th bgcolor='silver'>제 목</th>
			<td><input type="text" name="subject" size="30"></td>
		</tr>
		<tr>
			<th bgcolor='silver'>편지 내용</th>
			<td><textarea name="msgText" cols="34" rows="10"></textarea></td>
		</tr>
	</table>
	<div align="center">
		<input type="submit" value="보내기"> <input type="reset" value="취소">
	</div>
</form>
<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>