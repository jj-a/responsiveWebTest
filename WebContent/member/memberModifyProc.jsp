<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- Contents -->
	<h3><a href="loginForm.jsp"> 회원정보 수정 </a></h3>
	<p>&nbsp;</p>
	<%
	
		String id=request.getParameter("id").trim();
		String passwd=request.getParameter("passwd").trim();
		String mname=request.getParameter("mname").trim();
		String email=request.getParameter("email").trim();
		String tel=request.getParameter("tel").trim();
		String zipcode=request.getParameter("zipcode").trim();
		String address1=request.getParameter("address1").trim();
		String address2=request.getParameter("address2").trim();
		String job=request.getParameter("job").trim();
		
		dto.setId(id);
		dto.setPasswd(passwd);
		dto.setMname(mname);
		dto.setEmail(email);
		dto.setTel(tel);
		dto.setZipcode(zipcode);
		dto.setAddress1(address1);
		dto.setAddress2(address2);
		dto.setJob(job);

		int res = dao.modifyProc(dto);

		if (res == 0) {
			out.print("<p>회원정보 수정에 실패했습니다. <br>비밀번호를 확인해주세요.</p>");
			out.print("<p><a href='javascript:history.back();'>[다시시도]</a>");
			out.print("<a href='loginForm.jsp'> [마이페이지] </a></p>");
		} else {
			out.print("<script>");
			out.print("alert('게시글이 수정되었습니다.');");
			out.print("window.location='loginForm.jsp';");//페이지 이동
			out.print("</script>");
		}
	%>
	
<!-- Contents end -->

<%@ include file="../footer.jsp" %>

