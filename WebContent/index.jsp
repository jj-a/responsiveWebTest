<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="visit" class="net.utility.Visit" scope="application"></jsp:useBean>
<!DOCTYPE html>
<html lang="ko">

<head>
<title>* * Jina * *</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<!--<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/css?family=Montserrat&after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/stylesheet.css?ver=1.01">
<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/clock.js"></script>
<style>
#clock-box {
	display: block;
	margin: 0 auto;
	text-align: center;
}

.time {
	display: block; /* div option */
	width: 100%;
	line-height: 70px;
	background-color: white;
	color: black;
	font-weight: bold;
	font-size: 20pt;
	text-align: center;
	margin: 0 auto;
	border: 0 none;
	cursor: default;
}
</style>
</head>

<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">

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
					<li><a href="${pageContext.request.contextPath}#">NOTICE</a></li>
					<li><a href="${pageContext.request.contextPath}/member/loginForm.jsp">LOGIN</a></li>
					<li><a href="${pageContext.request.contextPath}#">PHOTO</a></li>
					<li><a href="${pageContext.request.contextPath}#">MAIL</a></li>
					<li><a href="${pageContext.request.contextPath}#">BOARD(mvc)</a></li>
					<li><a href="${pageContext.request.contextPath}#">LOGIN(mvc)</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- clock-box 시계 -->
	<div id="clock-box">
		<form name="clockform">
			<input type="text" name="clock" id="clock" class="time" size=25 readonly>
			<!-- 
			<p />
			<input type="button" value="▶" onclick="starttime()">&nbsp; <input
				type="button" value="▶■" onclick="killtime()">&nbsp; <input
				type="button" value="■" onclick="endtime()">
				 -->
		</form>
	</div>
	<!-- clock-box end -->

	<!-- First Container -->
	<div class="container-fluid bg-1 text-center">
		<h3 class="margin">Who Am I?</h3>
		<img src="images/apeach2.gif" class="img-responsive img-circle margin" style="display: inline" alt="Bird" width="350" height="350">
		<h3>I'm Apeach</h3>
	</div>

	<!-- Second Container -->
	<div class="container-fluid bg-2 text-center">
		<h3 class="margin">What Am I?</h3>
		<p>peach peach apeach! apeach! apeach! peach peach apeach!</p>
		<a href="https://www.google.com/search?q=어피치" class="btn btn-default btn-lg" target="new"> <span class="glyphicon glyphicon-search"></span>
			Google
		</a>
	</div>

	<!-- Third Container (Grid) -->
	<div class="container-fluid bg-3 text-center">
		<h3 class="margin">Where To Find Me?</h3>
		<br>
		<div class="row">
			<div class="col-sm-4">
				<p>little friends very goooooooood</p>
				<img src="images/007.gif" class="img-responsive margin" style="width: 100%" alt="Image">
			</div>
			<div class="col-sm-4">
				<p>pink cake apeach bboom bboom</p>
				<img src="images/002.gif" class="img-responsive margin" style="width: 100%" alt="Image">
			</div>
			<div class="col-sm-4">
				<p>shalalalalala</p>
				<img src="images/001.gif" class="img-responsive margin" style="width: 100%" alt="Image">
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="container-fluid bg-4 text-center">
	
		<div id="visit-counter">
	
			<%
				if (session.isNew()) {
			%>
			<jsp:setProperty property="counter" name="visit" value="1" />
			<%
				}
			%>
			<p>Today Visit : <jsp:getProperty property="counter" name="visit" /></p>
		</div>
	
		<p>
			copyright <a href="<%=request.getContextPath()%>/index.jsp">myWeb</a> since 2019. All rights reserved. <br>이 사이트는 드래그 방지가 적용되어 있습니다. 소스 확인 및
			디버깅 시 우클릭 or F12키를 이용해주세요.
		</p>
	</footer>

</body>

</html>