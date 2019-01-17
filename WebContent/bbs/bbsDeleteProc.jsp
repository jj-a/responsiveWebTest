<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- Contents -->
	<h1>* 게시글 삭제 *</h1>
	<p>
		<a href="bbsList.jsp">[글 목록]</a>
	</p>
	<%
		String passwd=request.getParameter("passwd").trim();
		int bbsno = Integer.parseInt(request.getParameter("bbsno"));
		
		dto.setPasswd(passwd);
		dto.setBbsno(bbsno);
		
		int res = dao.delete(dto);
		if (res == 0) {
			out.println("<p>게시글 삭제에 실패했습니다. <br>비밀번호를 확인해주세요.</p>");
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
