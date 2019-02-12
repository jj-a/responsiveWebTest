<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- Contents -->
	<%
		// 관리자만 삭제 권한 부여
		String ip = request.getRemoteAddr(); // 클라이언트 PC의 IP
		boolean isAdmin=ip.equals("127.0.0.1") || ip.equals("0:0:0:0:0:0:0:1");

		if(isAdmin==false) {
	%>
			<script>
			alert('게시글은 관리자 IP에서만 삭제할 수 있습니다.');
			window.location="bbslist.do?nowPage="+${pageNum};     
			</script>
	<%
		}
	%>
	
<c:choose>
	<c:when test="${res==0}">
		<p>게시글 삭제에 실패했습니다. <br>비밀번호를 확인해주세요.</p>
		<p><a href="javascript:history.back()"> [다시시도] </a>
		<a href="bbslist.do?nowPage=${pageNum}"> [글 목록] </a></p>
	</c:when>
	<c:otherwise>
		<script>
		 alert("게시글이 삭제되었습니다");
		window.location="bbslist.do?nowPage="+${pageNum};     
		</script>
	</c:otherwise>
</c:choose>

	
<!-- Contents end -->

<%@ include file="../footer.jsp" %>
