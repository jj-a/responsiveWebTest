<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>scopeTest.jsp</title>
</head>
<body>
	<h3>웹페이지의 Scope(유효범위)</h3>
	<%
		/*
		1. pageContext
		 현재 페이지에서만 유효
		
		2. request
		 페이지간의 연관성이 있을 경우 유효
		
		3. session
		모든 페이지에서 공유할 수 있는 전역적인 성격 영역
		단, 일정시간만 해당값이 유지된다. 
		시간이 지나면 자동으로 session영역 값은 삭제 된다.
		예) 로그인, 인터넷 뱅킹등
		
		4. application
		모든 사용자가 공유하고 싶을때
		예)파일이 저장되어 있는 물리적 경로를 파악하고 싶을 때
		*/

		// 변수 선언형식
		//pageContext.setAttribute("변수명", 값);
		//request.setAttribute("변수명", 값);
		//session.setAttribute("변수명", 값);
		//application.setAttribute("변수명", 값);

		// 값 가져오기
		//pageContext.getAttribute("변수명");
		//request.getAttribute("변수명");
		//session.getAttribute("변수명");
		//application.getAttribute("변수명");

		// 변수 삭제
		//pageContext.removeAttribute("변수명");
		//request.removeAttribute("변수명");
		//session.removeAttribute("변수명");
		//application.removeAttribute("변수명");

		int a = 3;

		//1)page영역
		pageContext.setAttribute("kor", 10);
		out.print(a + "<br/>");
		out.print(pageContext.getAttribute("kor") + "<br/>");

		//2)request영역
		request.setAttribute("eng", new Integer(20)); //추천
		out.print(request.getAttribute("eng") + "<br/>");

		//3)session영역
		session.setAttribute("mat", new Integer(30));
		out.print(session.getAttribute("mat") + "<br/>");

		//4)application영역
		application.setAttribute("uname", new String("SOLDESK"));
		out.print(application.getAttribute("uname") + "<br/>");

		int kor = (int) pageContext.getAttribute("kor");
		int eng = (int) request.getAttribute("eng");
		int mat = (int) session.getAttribute("mat");
		Object obj = application.getAttribute("uname");
		String uname = (String) obj;

		out.println("<br>pageContext영역: " + kor);
		out.println("<br>request영역: " + eng);
		out.println("<br>session영역: " + mat);
		out.println("<br>application영역: " + uname);

		// 변수 삭제
		/*
		pageContext.removeAttribute("kor");
		request.removeAttribute("eng");
		session.removeAttribute("mat");
		application.removeAttribute("uname");
		
		out.println("<p/>변수 삭제 후");
		out.println("<br>pageContext영역: "+pageContext.getAttribute("kor"));
		out.println("<br>request영역: "+request.getAttribute("eng"));
		out.println("<br>session영역: "+session.getAttribute("mat"));
		out.println("<br>application영역: "+application.getAttribute("uname"));
		*/
		out.println("<p></p>");

		// request.getAttribute() & request.getParameter()
		request.setAttribute("aver", 85);
		int aver = (int) request.getAttribute("aver");
		out.println(aver);

		// getParameter() = page?[~~~~]
		//int aver=(int)request.getParameter("aver");	// String형
		//out.println(aver);

		/*
		페이지 이동 방법
		
		<a href=""></a>
		<form action=""></form>
		location.href=""
		<jsp:foward page=""></jsp:foward>
		response.sendRedirect("");
		*/

		out.println();
		out.println("");
	%>

	<h4>결과 확인</h4>
	<table border=1 style="text-align: right; padding: 1px 1px 1px 1px;">
		<tr>
			<td>a href</td>
			<td><a href="scopeResult.jsp">Scope 결과 페이지</a></td>
		</tr>
		<tr>
			<td>form</td>
			<td><form action="scopeResult.jsp">
					<input type="submit" value="Scope 결과 페이지">
				</form></td>
		</tr>
		<tr>
			<td>location.href</td>
			<td><button onclick="location.href='scopeResult.jsp'">Scope 결과 페이지</button></td>
		</tr>
		<tr>
			<td>response.sendRedirect</td>
			<td>사용 제약 까다로움=???</td>
		</tr>
	</table>
	
	<%
		// redirect방식 (request 객체로 받은 값 전달 안됨)
		//response.sendRedirect("scopeResult.jsp");
	
		//foward방식 (request 객체로 받은 값 살아있음)
		String view="scopeResult.jsp";
		RequestDispatcher rd=request.getRequestDispatcher(view);
		rd.forward(request,response);
	%>
	
	<%-- jsp 주석 --%>
	
	<%--
	<jsp:foward page="scopeResult.jsp" />
	--%>


</body>
</html>