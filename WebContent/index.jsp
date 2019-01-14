<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<title>* * Jina * *</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!--<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">-->
<link rel="stylesheet" href="./css/css?family=Montserrat&after">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/stylesheet.css?after">
<script src="./js/jquery-3.3.1.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/clock.js"></script>
<style>
.bg-1 {
	background-color: #ffdcc7; /* Apricot */
	color: #ffffff;
}

.bg-2 {
	background-color: #eeebe7; /* Light Grey */
	color: #ffffff;
}

.bg-3 {
	background-color: #ffffff; /* White */
	color: #555555;
}

.bg-4 {
	background-color: #2f2f2f; /* Black Gray */
	color: #fff;
}

#clock-box {
	display: block;
	margin: 0 auto;
	text-align: center;
	
}

.time {
	display: block;	/* div option */
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
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand"
					href="<%=request.getContextPath()%>/index.jsp">Me</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#">게시판</a></li>
					<li><a href="#">공지사항</a></li>
					<li><a href="#">로그인</a></li>
					<li><a href="#">포토갤러리</a></li>
					<li><a href="#">메일보내기</a></li>
					<li><a href="#">게시판(MVC)</a></li>
					<li><a href="#">로그인(MVC)</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- clock-box 시계 -->
	<div id="clock-box">
		<form name="clockform">
			<input type="text" name="clock" id="clock" class="time" size=25
				readonly>
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
		<img src="images/apeach2.gif" class="img-responsive img-circle margin"
			style="display: inline" alt="Bird" width="350" height="350">
		<h3>I'm Apeach</h3>
	</div>

	<!-- Second Container -->
	<div class="container-fluid bg-2 text-center">
		<h3 class="margin">What Am I?</h3>
		<p>peach peach apeach! apeach! apeach! peach peach apeach!</p>
		<a href="https://www.google.com/search?q=어피치"
			class="btn btn-default btn-lg" target="new"> <span
			class="glyphicon glyphicon-search"></span> Google
		</a>
	</div>

	<!-- Third Container (Grid) -->
	<div class="container-fluid bg-3 text-center">
		<h3 class="margin">Where To Find Me?</h3>
		<br>
		<div class="row">
			<div class="col-sm-4">
				<p>little friends very goooooooood</p>
				<img src="images/007.gif" class="img-responsive margin"
					style="width: 100%" alt="Image">
			</div>
			<div class="col-sm-4">
				<p>pink cake apeach bboom bboom</p>
				<img src="images/002.gif" class="img-responsive margin"
					style="width: 100%" alt="Image">
			</div>
			<div class="col-sm-4">
				<p>shalalalalala</p>
				<img src="images/001.gif" class="img-responsive margin"
					style="width: 100%" alt="Image">
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="container-fluid bg-4 text-center">
		<p>
			copyright <a href="<%=request.getContextPath()%>/index.jsp">myWeb</a>
			since 2019. All rights reserved.
		</p>
	</footer>

</body>

</html>