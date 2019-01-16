<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- Contents -->
	<h1>* 글 삭제 *</h1>
	<p>
		<a href="bbsList.jsp">[글 목록]</a> <a href="bbsForm.jsp">[글쓰기]</a>
	</p>
	<%
		// 사용자가 요청한 bbsno 가져오기
		// ex. bbsRead.jsp?bbsno=2
		int bbsno = Integer.parseInt(request.getParameter("bbsno"));

		int res = dao.delete(bbsno);
		if (res == 0) {
			out.println("<p>게시글 삭제에 실패했습니다</p>");
			out.println("<p><a href='javascript:history.back()'>[다시시도]</a></p>");
		} else {
			out.println("<script>");
			out.println("   alert('게시글이 삭제되었습니다');");
			out.println("   location.href='bbsList.jsp';");//페이지 이동      
			out.println("</script>");
		}
	%>
	
<!-- Contents end -->

<%@ include file="../footer.jsp" %>
