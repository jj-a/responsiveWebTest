<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<title>* * Jina * *</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/stylesheet.css?after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/css?family=Montserrat&after">
<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
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
					<li><a href="#">NOTICE</a></li>
					<li><a href="#">LOGIN</a></li>
					<li><a href="#">PHOTO</a></li>
					<li><a href="#">MAIL</a></li>
					<li><a href="#">BOARD(mvc)</a></li>
					<li><a href="#">LOGIN(mvc)</a></li>
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
			