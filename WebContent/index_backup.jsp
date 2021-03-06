<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/header.jsp" %>
<%@ include file="/footer.jsp" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<title>* * Jina * *</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/css?family=Montserrat&after">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/stylesheet.css?after">
<script src="./js/jquery-3.3.1.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/script.js"></script>
<style>
</style>
</head>

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
					<li><a href="#">BOARD</a></li>
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
	<!--Main Category end -->


	<!-- Contents start -->

	<!-- Third Container (Grid) -->
	<div class="container-fluid bg-3 text-center">
		<div class="row">
			<div class="col-sm-12">
				<p>&nbsp;</p>
			</div>
		</div>
	</div>
	<!-- Contents end -->


	<!-- Footer start -->
	<footer class="container-fluid bg-4 text-center">
		<p>
			copyright <a href="<%=request.getContextPath()%>/index.jsp">myWeb</a> since 2019. All rights reserved.
		</p>
	</footer>
	<!-- Footer end -->

</body>
</html>