<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>sessionTest.jsp</title>
</head>
<body>
	<h3>Session</h3>
	<%
		/*
			● Session 내부객체
			- HTTPSession session
			- 요청한 사용자에게 개별적으로 접근
			- 선언된 세션변수는 전역적으로 사용 가능
			- 일정 시간동안 이벤트가 발생되지 않으면 자동 삭제
		*/

		out.println("현재 세션 유지 시간: ");
		out.println(session.getMaxInactiveInterval());
		out.println("<hr>");

		// 세션 유지 시간 변경

		// 1)	
		session.setMaxInactiveInterval(60 * 10);
		out.println("변경된 세션 유지 시간: ");
		out.println(session.getMaxInactiveInterval());
		out.println("초(10분)");
		out.println("<hr>");

		// 2) web.xml (배치파일) 이용
		// 세션 시간 설정, 환경 설정, ...

		// Session 변수 : 프로젝트의 모든 페이지에서 공유 (별도의 자료형 없음)
		// 세션 변수 선언 : session.setAttribute("변수명", 값)

		session.setAttribute("s_id", "soldesk");
		session.setAttribute("s_pw", "12341234");

		Object obj = session.getAttribute("s_id");
		String s_id = (String) obj;
		String s_pw = (String) session.getAttribute("s_pw");

		out.println("s_id: " + s_id + "<br>");
		out.println("s_pw: " + s_pw + "<br>");

		// 세션변수 삭제 (로그아웃)
		session.removeAttribute("s_id");
		session.removeAttribute("s_pw");
		out.println("<hr>");

		// 세션변수 삭제 후
		out.println("세션변수 삭제 후: ");
		out.println("<br>s_id: " + session.getAttribute("s_id"));
		out.println("<br>s_pw: " + session.getAttribute("s_pw"));
		out.println("<hr>");

		// 세션에 있는 모든 값 전체 삭제
		//session.invalidate();

		// session객체에서 발급하는 임시 계정
		out.println("세션 임시 계정:  ");
		out.println(session.getId());
		out.println("<hr>");

		/*
			● Application 내부객체
			- ServletContext application
			- 사용자 모두가 공유하는 전역적 객체
		*/

		// member 폴더의 실제 물리적 경로
		// d:\java1113\workspace\myweb\WebContent\member
		out.println(application.getRealPath("/member"));
		out.println("<hr>");

		// request 객체의 getrealpath
		out.println(request.getRealPath("/member"));
		out.println("<hr>");

		// application 변수
		application.setAttribute("uname", "꿀매실");
		out.println(application.getAttribute("uname"));
		out.println("<hr>");

		/*
			●response 내부객체
			- 요청한 사용자에게 응답할 때 사용
		*/

		// 페이지 이동
		//response.sendRedirect(location);

		// 요청한 사용자에게 응답할 메시지 전송
		//PrintWriter prn=response.getWriter();
	%>


</body>
</html>