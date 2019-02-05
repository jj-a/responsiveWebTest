<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../adminAuth.jsp"%>
<%@ include file="../../member/ssi.jsp"%>

<%
	String id = request.getParameter("id").trim();


	// 관리자만 삭제 권한 부여
	String ip = request.getRemoteAddr(); // 클라이언트 PC의 IP
	boolean isAdmin=ip.equals("127.0.0.1") || ip.equals("0:0:0:0:0:0:0:1");
	
	if(isAdmin==false) {
		out.println("<script>");
		out.println("alert('회원은 관리자 IP에서만 삭제할 수 있습니다.');");
		out.println("history.back();");//페이지 이동      
		out.println("</script>");
	}
	
	int res = dao.delete(id);

	if (res == 0) {
		out.println("<script>");
		out.println("alert('회원 삭제에 실패했습니다. 휴면계정 혹은 탈퇴회원만 삭제 가능합니다.');");
		out.println("history.back();");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('회원이 영구적으로 삭제되었습니다.');");
		out.println("location.href='memLevel.jsp';");
		out.println("</script>");
	}
%>
