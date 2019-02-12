<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- Contents -->
	<h3><a href="bbslist.do"> 게시글 수정 </a></h3>
	<p>&nbsp;</p>
	<p><a href="bbslist.do">[글 목록]</a></p>
	
<c:choose>
	<c:when test="${res==0}">
		<p>게시글 수정에 실패했습니다.</p>
		<p><a href="javascript:history.back()"> [다시시도] </a>
		<a href="bbslist.do?nowPage=${pageNum}"> [글 목록] </a></p>
	</c:when>
	<c:otherwise>
		<script>
		alert("게시글이 수정되었습니다.");
		window.location="bbslist.do?nowPage="+${pageNum};
		</script>
	</c:otherwise>
</c:choose>
	
<!-- Contents end -->

<%@ include file="../footer.jsp" %>

