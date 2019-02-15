<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<!-- Contents -->

<h3><a href="bbslist.do"> 게시글 ${action} </a></h3>
<p>&nbsp;</p>

<%--${msg} --%>
	
<c:choose>
	<c:when test="${res==-1}">
		<%-- 관리자 IP 이외에서 삭제 수행 시 = 삭제 수행 안한 상태 --%>
		<script>
			alert('게시글은 관리자 IP에서만 삭제할 수 있습니다.');
			window.location="bbslist.do?pageNum="+${pageNum};     
		</script>
	</c:when>
	<c:when test="${res==0}">
		<%-- Query 실패 --%>
		<p>게시글 ${action}에 실패했습니다.</p>
		<p><a href="javascript:history.back()"> [다시시도] </a>
		<a href="bbslist.do?pageNum=${pageNum}"> [글 목록] </a></p>
	</c:when>
	<c:otherwise>
		<!-- Query 성공 -->
		<script>
			alert("게시글이 ${action}되었습니다.");
			window.location="bbslist.do?pageNum="+${pageNum};
		</script>
	</c:otherwise>
</c:choose>
	
<!-- Contents end -->

<%@ include file="../footer.jsp" %>

