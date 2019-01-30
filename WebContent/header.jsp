<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="member/auth.jsp"%>
<jsp:useBean id="visit" class="net.utility.Visit" scope="application"></jsp:useBean>
<!DOCTYPE html>
<html lang="ko">

<head>
<title>* * Jina * *</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/stylesheet.css?ver=1.014">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/css?family=Montserrat&after">
<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/script.js?ver=1.005"></script>
<script src="${pageContext.request.contextPath}/js/clock.js"></script>
<script src="${pageContext.request.contextPath}/js/nodrag.js"></script>
<style>
</style>
</head>

<!-- <body oncontextmenu="return false" onselectstart="return false" ondragstart="return false"> 드래그 방지-->
<body>

	<!--Main Category start -->
		<!-- Navbar -->
	<nav class="navbar navbar-default">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">Me</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="${pageContext.request.contextPath}/bbs/bbsList.jsp">BOARD</a></li>
					<li><a href="${pageContext.request.contextPath}/notice/noticeList.jsp">NOTICE</a></li>
					<li><a href="${pageContext.request.contextPath}/member/loginForm.jsp">
					<%if (s_id.equals("guest") || s_passwd.equals("guest") || s_mlevel.equals("E1")) {%>
					LOGIN
					<%}else{%>
					MYPAGE
					<%}%>
					</a></li>
					<li><a href="${pageContext.request.contextPath}/pds/pdsList.jsp">PHOTO</a></li>
					<li><a href="${pageContext.request.contextPath}/mail/mailForm.jsp">MAIL</a></li>
					<li><a href="${pageContext.request.contextPath}#">BOARD(mvc)</a></li>
					<li><a href="${pageContext.request.contextPath}#">LOGIN(mvc)</a></li>
				</ul>
			</div>
		</div>
	</nav>

		<!-- visit-ip 방문자 IP -->
	<div id="visit-ip">
		<p>
			<%
				String visitip = request.getRemoteAddr();
				out.print(visitip + " 님, 안녕하세요! ＼^0^/");
				if(visitip.equals("172.16.10.100")) out.print("");
				else out.print("<br><span style='color:#999999;'>오늘은 수요일 크리스피도넛 1+1</span>");
				visit.ipCheck(visitip);
			%>
		</p>
		</div>

		<!-- clock-box 시계 -->
	<div id="clock-box">
		<form name="clockform">
			<input type="text" name="clock" id="clock" class="time" size=25 readonly>
			<!-- 
			<p />
			<input type="button" value="▶" onclick="starttime()">&nbsp; 
			<input type="button" value="▶■" onclick="killtime()">&nbsp;
			<input type="button" value="■" onclick="endtime()">
				 -->
		</form>
	</div>

	
	<!--Main Category end -->


	<!-- Contents start -->

		<!-- Container (Grid) -->
	<div class="container-fluid bg-3 text-center">
		<div class="row">
			<div class="col-sm-12">
			