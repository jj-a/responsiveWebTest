<%@ page contentType="text/html; charset=UTF-8"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<%@ include file="../includeCss.jsp"%>


<div class="top-box">
	<%@ include file="./noti_menu.jsp"%>
</div>

<div class="btm-box">
	<iframe name="sub-content" id="ifr_subcontent" onload="calcHeight();" frameborder="0" scrolling="no"
		style="overflow-x: hidden; overflow: auto; width: 100%; min-height: 500px;">
		<!-- <p>상단의 메뉴를 클릭해주세요</p> -->
	</iframe>
</div>


<script type="text/javascript">
	//<![CDATA[
	function calcHeight() {
		//find the height of the internal page

		var ifr_h = document.getElementById('ifr_subcontent').contentWindow.document.body.scrollHeight;

		//change the height of the iframe
		document.getElementById('ifr_subcontent').height = ifr_h;

		//document.getElementById('ifr_subcontent').scrolling = "no";
		document.getElementById('ifr_subcontent').style.overflow = "hidden";
	}
	//
</script>
