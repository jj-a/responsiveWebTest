<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h3>회원가입</h3>

<%
	// 1) 사용자가 입력한 정보를 변수에 저장

	String id = request.getParameter("id").trim();
	String passwd = request.getParameter("passwd").trim();
	String mname = request.getParameter("mname").trim();
	String tel = request.getParameter("tel").trim();
	String email = request.getParameter("email").trim();
	String zipcode = request.getParameter("zipcode").trim();
	String address1 = request.getParameter("address1").trim();
	String address2 = request.getParameter("address2").trim();
	String job = request.getParameter("job").trim();
	

	// 2) dto Object에 저장
	dto.setId(id);
	dto.setPasswd(passwd);
	dto.setMname(mname);
	dto.setTel(tel);
	dto.setEmail(email);
	dto.setZipcode(zipcode);
	dto.setAddress1(address1);
	dto.setAddress2(address2);
	dto.setJob(job);
	
	int res = dao.join(dto);

	// 3) member 테이블에 입력
	if (res == 0) {
		out.print("오류가 발생해 회원가입에 실패했습니다.<br/>");
		out.print("<a href='javascript:history.back();'>[다시시도]</a>");
	} else {
		out.print("<script>");
		out.print("  alert('회원가입이 완료되었습니다.');");
		out.print("  window.location='loginForm.jsp';");
		out.print("</script>");
	}
%>

<!-- Contents end -->

<!-- Contents -->

<%@ include file="../footer.jsp"%>