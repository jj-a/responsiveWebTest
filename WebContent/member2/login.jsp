<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<c:choose>
	<c:when test="${sessionScope.s_id==null}">
		<script>
			alert('아이디가 없거나 아이디/비밀번호가 일치하지 않습니다.');
			history.back();
		</script>"
	</c:when>
	<c:otherwise>
		<script>
			alert("로그인되었습니다.");
			location.href="../index.do";
		</script>
	</c:otherwise>
</c:choose>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>