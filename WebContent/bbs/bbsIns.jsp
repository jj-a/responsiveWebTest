<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="/header.jsp"%>

<!-- Contents -->

<%
	// 1) 사용자가 입력한 정보를 변수에 저장
	String wname = request.getParameter("wname").trim();
	String subject = request.getParameter("subject").trim();
	String content = request.getParameter("content").trim();
	String passwd = request.getParameter("passwd").trim();
	String ip = request.getRemoteAddr(); // 클라이언트 PC의 IP

	// 2) dto Object에 저장
	//BbsDTO dto = new BbsDTO(wname, subject, content, passwd, ip);
	dto.setWname(wname);
	dto.setSubject(subject);
	dto.setContent(content);
	dto.setPasswd(passwd);
	dto.setIp(ip);
	int res = dao.insert(dto);

	// 3) tb_bbs 테이블에 입력
	if (res == 0) {
		out.print("게시글 등록에 실패하였습니다.<br/>");
		out.print("<a href='javascript:history.back();'>[다시시도]</a>");
	} else {
		out.print("<script>");
		out.print("  alert('게시글이 등록되었습니다.');");
		out.print("  window.location='bbsList.jsp';");
		out.print("</script>");
	}
%>

<!-- Contents end -->

<%@ include file="/footer.jsp"%>


