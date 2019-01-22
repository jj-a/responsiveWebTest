<%@ page contentType="text/html; charset=UTF-8"%>
</div>
</div>
</div>
<!-- Contents end -->

<!-- Footer start -->
<footer class="container-fluid bg-4 text-center">

	<div id="visit-counter">

		<%
			if (session.isNew()) {
		%>
		<jsp:setProperty property="counter" name="visit" value="1" />
		<%
			}
		%>
		<p>Total Visit : <jsp:getProperty property="counter" name="visit" /></p>
	</div>

	<p>
		copyright <a href="<%=request.getContextPath()%>/index.jsp">myWeb</a> since 2019. All rights reserved. <br>이 사이트는 드래그 방지가 적용되어 있습니다. 소스 확인 및
		디버깅 시 우클릭 or F12키를 이용해주세요.
	</p>
</footer>
<!-- Footer end -->
</body>
</html>