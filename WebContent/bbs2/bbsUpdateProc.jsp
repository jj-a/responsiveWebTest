<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- Contents -->
	<h3><a href="bbsList.jsp"> 게시글 수정 </a></h3>
	<p>&nbsp;</p>
	<p><a href="bbsList.jsp">[글 목록]</a></p>
	<%
	
		int bbsno = Integer.parseInt(request.getParameter("bbsno"));
		col = request.getParameter("col");
		word = request.getParameter("word");
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
			out.print("<p>게시글 수정에 실패했습니다. <br>비밀번호를 확인해주세요.</p>");
			out.print("<p><a href='javascript:history.back();'>[다시시도]</a>");
			out.print("<a href='bbsList.jsp'> [글 목록] </a></p>");
		} else {
			out.print("<script>");
			out.print("alert('게시글이 수정되었습니다.');");
			out.print("  window.location='bbsList.jsp?col="+col+"&word="+word+"&nowPage="+nowPage+"';");//페이지 이동
			out.print("</script>");
		}
	%>
	
<!-- Contents end -->

<%@ include file="../footer.jsp" %>

