<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h3>회원가입</h3>
<p>&nbsp;</p>

<c:choose>
	<c:when test="${res==0}">
		오류가 발생해 회원가입에 실패했습니다.
		<br><a href='javascript:history.back();'>[다시시도]</a>
	</c:when>
	<c:otherwise>
		<script>
			alert('회원가입이 완료되었습니다.');
			window.location='loginform.do';
		</script>
	</c:otherwise>
</c:choose>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>