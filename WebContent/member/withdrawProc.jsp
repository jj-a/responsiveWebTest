<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- Contents -->
	<h3><a href="loginForm.jsp"> 회원 탈퇴 </a></h3>
	<p>&nbsp;</p>
	<%
		
		// form에서 받은 정보 저장
	
		String passwd=request.getParameter("passwd").trim();
		String email=request.getParameter("email").trim();
		
		dto.setId(s_id);
		dto.setPasswd(passwd);
		dto.setEmail(email);
		
		// 메소드(db query) 수행

		int res = dao.withdraw(dto);
		
		// 회원탈퇴와 동시에 Session에 저장된 정보 변경 (guest)

		if (res == 0) {
			out.print("<p>회원 탈퇴에 실패했습니다. <br>입력 정보가 올바르지 않습니다.</p>");
			out.print("<p><a href='javascript:history.back();'>[다시시도]</a>");
			out.print("<a href='loginForm.jsp'> [마이페이지] </a></p>");
		} else {
			out.print("<script>");
			out.print("alert('회원 탈퇴되었습니다. 이용해주셔서 감사합니다.');");
			// Session 정보 삭제
			session.removeAttribute("s_id");
			session.removeAttribute("s_passwd");
			session.removeAttribute("s_mlevel");
			session.removeAttribute("s_adm_id");
			session.removeAttribute("s_adm_passwd");
			session.removeAttribute("s_adm_mlevel");
			out.print("location.href='../index.jsp'");
			out.print("</script>");
		}
	%>
	
<!-- Contents end -->

<%@ include file="../footer.jsp" %>

