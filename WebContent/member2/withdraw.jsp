<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3><a href="loginform.do"> 회원 탈퇴 </a></h3>
<p>&nbsp;</p>

<%-- 회원탈퇴와 동시에 Session에 저장된 정보 변경 (guest) --%>
<c:choose>
	<c:when test="${res==0}">
		<p>회원 탈퇴에 실패했습니다. <br>입력 정보가 올바르지 않습니다.</p>
		<p><a href='javascript:history.back();'>[다시시도]</a> <a href='loginform.do'> [마이페이지] </a></p>
	</c:when>
	<c:otherwise>
		<script>
			alert('회원 탈퇴되었습니다. 이용해주셔서 감사합니다.');
			<%-- location.href='../index.do'; --%>
		</script>
		
		<%-- Session 정보 삭제 --%>
		<c:remove var="s_id" scope="session"/>
		<c:remove var="s_passwd" scope="session"/>
		<c:remove var="s_mlevel" scope="session"/>
		<c:remove var="s_adm_id" scope="session"/>
		<c:remove var="s_adm_passwd" scope="session"/>
		<c:remove var="s_adm_mlevel" scope="session"/>
		<meta http-equiv="refresh" content="0;url=../index.do">
		
	</c:otherwise>
</c:choose>
<!-- Contents end -->

<%@ include file="../footer.jsp"%>

