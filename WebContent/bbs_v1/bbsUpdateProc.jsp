<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- Contents -->
	<h1>* 게시글 수정 *</h1>
	<p>
		<a href="bbsList.jsp">[글 목록]</a>
	</p>
	<%
		int bbsno = Integer.parseInt(request.getParameter("bbsno"));
		String wname = request.getParameter("wname").trim();
		String subject = request.getParameter("subject").trim();
		String content = request.getParameter("content").trim();
		String passwd = request.getParameter("passwd").trim();
		String ip = request.getRemoteAddr(); // 클라이언트 PC의 IP

		dto.setBbsno(bbsno);
		dto.setWname(wname);
		dto.setSubject(subject);
		dto.setContent(content);
		dto.setPasswd(passwd);
		dto.setIp(ip);

		int res = dao.updateProc(dto);

		if (res == 0) {
			out.println("<p>게시글 수정에 실패했습니다. <br>비밀번호를 확인해주세요.</p>");
			out.println("<p><a href='javascript:history.back()'>[다시시도]</a></p>");
		} else {
			out.println("<script>");
			out.println("alert('게시글이 수정되었습니다.');");
			out.println("   location.href='bbsList.jsp';");//페이지 이동      
			out.println("</script>");
		}
	%>
	
<!-- Contents end -->

<%@ include file="../footer.jsp" %>

