<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- Contents -->

	<%
		int noticeno = Integer.parseInt(request.getParameter("noticeno"));
		col = request.getParameter("col");
		word = request.getParameter("word");
		String subject = request.getParameter("subject").trim();
		String content = request.getParameter("content").trim();
		System.out.println("업뎃proc: "+col+" "+word);
	%>
	
<script>
	function wherewego() {
		//var pagename = getPagename();
		//if (pagename == "adminStart.jsp") {
		if(parent && parent!=this){
			window.location.href = "../admin/noti/notiManagement.jsp?col="+col+"&word="+word;//+"&nowPage="+nowPage;
		} else {
			window.location = "noticeList.jsp?col="+col+"&word="+word+"&nowPage="+nowPage;
		}
	}
</script>

	<%
	
		dto.setNoticeno(noticeno);
		dto.setSubject(subject);
		dto.setContent(content);

		int res = dao.updateProc(dto);

		if (res == 0) {
			out.print("<p>게시글 수정에 실패했습니다. <br>비밀번호를 확인해주세요.</p>");
			out.print("<p><a href='javascript:history.back();'>[다시시도]</a>");
			out.print("<a href='noticeList.jsp'> [글 목록] </a></p>");
		} else {
			out.println("<script>");
			out.println("alert('게시글이 수정되었습니다.');");
			out.println("wherewego();");
			out.println("</script>");
		}
	%>
	
<!-- Contents end -->

<%@ include file="../footer.jsp" %>

