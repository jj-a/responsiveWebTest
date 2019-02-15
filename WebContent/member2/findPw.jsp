<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3>비밀번호 찾기</h3>

<c:if test="${!(sessionScope.s_id==null || sessionScope.s_mlevel=='E1' || sessionScope.s_mlevel=='F1')}">
	<script>
		alert("로그인한 상태에선 비밀번호 찾기를 할 수 없습니다.");
		location.href = "${pageContext.request.contextPath}/member2/loginform.do";
	</script>
</c:if>


<table border="1" class="writefrm">
	<tr>
		<td colspan="2">비밀번호 찾기 결과</td>
	</tr>
				
	<c:choose>
	<c:when test="${email==null}">
	<%-- 입력정보가 일치하지 않는 경우 --%>
	<tr>
		<td colspan=2>입력 정보가 일치하지 않습니다.</td>
	</tr>
	</c:when>
	<c:when test="${isSend==false}">
	<tr>
		<td>메일 전송을 실패하였습니다.</td>
	</tr><tr>
		<td><a href='javascript:history.back();'>[다시 시도]</a></td>
	</tr>
	</c:when>
	<c:otherwise>
	<tr>
		<td colspan="2">입력하신 이메일로 임시비밀번호가 전송되었습니다.</td>
	</tr>
	<tr>
		<th>전송 이메일</th>
		<td>${email}</td>
	</tr>
	</c:otherwise>
	</c:choose>

	<tr>
		<td colspan="2">
			<input type="button" value="로그인" onclick="location.href='loginform.do'">&nbsp;&nbsp; 
			<input type="button" value="뒤로가기" onclick="history.back()">
		</td>
	</tr>
</table>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>