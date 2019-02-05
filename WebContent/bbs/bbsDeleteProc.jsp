<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- Contents -->
	<%
		String passwd=request.getParameter("passwd").trim();
		int bbsno = Integer.parseInt(request.getParameter("bbsno"));
		col=request.getParameter("col");
		word=request.getParameter("word");
		
		
		// 관리자만 삭제 권한 부여
		String ip = request.getRemoteAddr(); // 클라이언트 PC의 IP
		boolean isAdmin=ip.equals("127.0.0.1") || ip.equals("0:0:0:0:0:0:0:1");

		if(isAdmin==false) {
			out.println("<script>");
			out.println("alert('게시글은 관리자 IP에서만 삭제할 수 있습니다.');");
			out.println("window.location='bbsList.jsp?col="+col+"&word="+word+"';");//페이지 이동      
			out.println("</script>");
		}
		//
		
		dto.setPasswd(passwd);
		dto.setBbsno(bbsno);
		
		int res = dao.delete(dto);

		if (res == 0) {
			out.print("<p>게시글 삭제에 실패했습니다. <br>비밀번호를 확인해주세요.</p>");
			out.print("<p><a href='javascript:history.back()'> [다시시도] </a>");
			out.print("<a href='bbsList.jsp'> [글 목록] </a></p>");
		}
		else {
			out.print("<script>");
			out.print("   alert('게시글이 삭제되었습니다');");
			out.print("  window.location='bbsList.jsp?col="+col+"&word="+word+"&nowPage="+nowPage+"';");//페이지 이동      
			out.print("</script>");
		}
	%>
	
<!-- Contents end -->

<%@ include file="../footer.jsp" %>
