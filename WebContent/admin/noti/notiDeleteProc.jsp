<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../adminAuth.jsp"%>
<%@ include file="../../notice/ssi.jsp"%>

<%
	String selectchk[] = request.getParameterValues("selectchk");	// String형 배열로 반환됨
	//int selectchk[] = Arrays.stream(request.getParameterValues("selectChk")).mapToInt(Integer::parseInt).toArray();

	//System.out.println("몇개:"+selectchk.length);
	System.out.println(selectchk[0]);
	
	// 관리자만 삭제 권한 부여
	String ip = request.getRemoteAddr(); // 클라이언트 PC의 IP
	boolean isAdmin=ip.equals("127.0.0.1");
	
	if(isAdmin==false) {
		out.println("<script>");
		out.println("alert('관리자 IP에서만 삭제할 수 있습니다.');");
		out.println("history.back();");//페이지 이동      
		out.println("</script>");
	}
	
	// 체크박스 체크한 글만 삭제
	int res = dao.delete(selectchk);

	if (res == 0) {
		out.println("<script>");
		out.println("alert('게시물 삭제에 실패했습니다.');");
		out.println("history.back();");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('선택한 게시물이 삭제되었습니다.');");
		out.println("window.location.href='notiDelete.jsp';");
		out.println("</script>");
	}
%>
