<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../member/ssi.jsp"%>
<%@ include file="../member/auth.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<p>&nbsp;</p>

<%
	String admid = request.getParameter("admid").trim();
	String admpw = request.getParameter("admpw").trim();

	dto.setId(admid);
	dto.setPasswd(admpw);

	String mlevel = dao.login(dto);

	if (mlevel == null) {
		out.println("<script>");
		out.println("alert('아이디가 없거나 아이디/비밀번호가 일치하지 않습니다.');");
		out.println("history.back();");
		out.println("</script>");
	} else {
		
		// 회원 등급 확인 (A~B등급만 접근 가능)
		if(mlevel.equals("A1")||mlevel.equals("B1")){
			
			// Session 정보 // 로그인 정보 유지
			session.setAttribute("s_adm_id", admid);
			session.setAttribute("s_adm_passwd", admpw);
			session.setAttribute("s_adm_mlevel", mlevel);

			response.sendRedirect("adminStart.jsp");
			
		}
		else if(mlevel.equals("C1")||mlevel.equals("D1")){
			out.println("<script>");
			out.println("alert('등업 후 로그인 가능합니다.');");
			out.println("history.back();");
			out.println("</script>");
		}else{
			out.println("<script>");
			out.println("alert('관리자만 접근할 수 있습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}

%>

<!-- else -->

<%
	}
%>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>

