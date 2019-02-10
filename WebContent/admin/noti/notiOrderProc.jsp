<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../adminAuth.jsp"%>
<%@ include file="../../notice/ssi.jsp"%>

<%
	String selectchk[] = request.getParameterValues("selectchk");	// String형 배열로 반환됨
	//int selectchk[] = Arrays.stream(request.getParameterValues("selectchk")).mapToInt(Integer::parseInt).toArray();
	
	// 체크박스 체크한 글만 삭제
	int res = dao.adjustOrder(selectchk);

	if (res == 0) {
		out.println("<script>");
		out.println("alert('게시물 삭제에 실패했습니다.');");
		out.println("history.back();");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('선택한 게시물이 삭제되었습니다.');");
		out.println("window.location.href='notiManagement.jsp';");
		out.println("</script>");
	}
%>
