<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="/header.jsp"%>

<!-- Contents -->

<%
	// 1) 사용자가 입력한 정보를 변수에 저장
	String subject = request.getParameter("subject").trim();
	String content = request.getParameter("content").trim();
%>
	
<script>
	function wherewego() {
		//var pagename = getPagename();
		//if (pagename == "adminStart.jsp") {
		if(parent && parent!=this){
			window.location.href = "../admin/noti/notiManagement.jsp";
		} else {
			window.location = "noticeList.jsp";
		}
	}
</script>

<%

	// 2) dto Object에 저장
	dto.setSubject(subject);
	dto.setContent(content);
	
	int res = dao.insert(dto);

	// 3) tb_notice 테이블에 입력
	if (res == 0) {
		out.print("공지사항 등록에 실패하였습니다.<br/>");
		out.print("<a href='javascript:history.back();'>[다시시도]</a>");
	} else {
		out.println("<script>");
		out.println("alert('공지사항이 등록되었습니다.');");
		out.println("wherewego();");
		out.println("</script>");
	}
%>


<!-- Contents end -->

<%@ include file="/footer.jsp"%>


