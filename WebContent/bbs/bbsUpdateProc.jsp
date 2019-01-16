<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- Contents -->
	<h1>* 게시글 수정 *</h1>
	<p>
		<a href="bbsList.jsp">[글 목록]</a> <a href="bbsForm.jsp">[글쓰기]</a>
	</p>
	<%
		int bbsno = Integer.parseInt(request.getParameter("bbsno"));
		String wname = request.getParameter("wname").trim();
		String subject = request.getParameter("subject").trim();
		String content = request.getParameter("content").trim();
		String passwd = request.getParameter("passwd").trim();
		int kor = Integer.parseInt(request.getParameter("kor").trim());
		String addr = request.getParameter("addr").trim();

		dto.setBbsno(bbsno);
		dto.setWname(wname);
		dto.setSubject(subject);
		dto.setContent(content);
		dto.setPasswd(passwd);

		int res = dao.updateProc(dto);

		if (res == 0) {
			out.println("<p>성적 수정에 실패했습니다</p>");
			out.println("<p><a href='javascript:history.back()'>[다시시도]</a></p>");
		} else {
			out.println("<script>");
			out.println("   alert('성적이 수정되었습니다');");
			out.println("   location.href='bbsList.jsp';");//페이지 이동      
			out.println("</script>");
		}
	%>
	
<!-- Contents end -->

<%@ include file="../footer.jsp" %>

