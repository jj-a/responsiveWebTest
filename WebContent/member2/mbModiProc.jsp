<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h3><a href="loginform.do"> 회원정보 수정 </a></h3>
<p>&nbsp;</p>

<c:choose>
	<c:when test="${res==0}">
		<p>회원정보 수정에 실패했습니다. <br>비밀번호를 확인해주세요.</p>
		<p><a href='javascript:history.back();'>[다시시도]</a> <a href='loginform.do'> [마이페이지] </a></p>
	</c:when>
	<c:otherwise>
		<script>
			alert('회원정보가 수정되었습니다.');
			window.location = 'loginform.do';
		</script>
	</c:otherwise>
</c:choose>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>

