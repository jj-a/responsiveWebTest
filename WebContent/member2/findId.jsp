<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3>아이디 찾기</h3>

<c:if test="${!(sessionScope.s_id==null || sessionScope.s_mlevel=='E1' || sessionScope.s_mlevel=='F1')}">
	<script>
		alert("로그인한 상태에선 아이디 찾기를 할 수 없습니다.");
		location.href = "${pageContext.request.contextPath}/member2/loginform.do";
	</script>
</c:if>

<table border="1" class="writefrm">
	<tr>
		<td colspan="2">아이디 찾기 결과</td>
	</tr>
	<c:choose>
	<c:when test="${id==null}">
	<tr>
		<td colspan=2>입력하신 정보와 일치하는 아이디가 없습니다.</td>
	</tr>
	</c:when>
	<c:otherwise>
	<tr>
		<th>아이디</th>
		<td>${id}</td>
	</tr>
	</c:otherwise>
	</c:choose>
	<tr>
		<td colspan="2">
			<input type="button" value="로그인" onclick="location.href='loginform.do'">&nbsp;&nbsp; 
			<input type="button" value="비밀번호 찾기" onclick="location.href='findmember.do'">
		</td>
	</tr>
</table>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>