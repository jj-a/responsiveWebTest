<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../member/ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<!-- <frameset cols="300, *">
   <frame name="main" src="adminLmenu.jsp" noresize="noresize">
   <frame name="sub">
</frameset>
 -->

<div class="left-box">
	<%@ include file="./adminLmenu.jsp"%>
</div>

<div class="right-box">
	<iframe name="content" id="ifr_content" onload="calcHeight();" frameborder="0" scrolling="no"
		style="overflow-x: hidden; overflow: auto; width: 100%; min-height: 500px;">
		<!-- <p>좌측의 메뉴를 클릭해주세요</p> -->
	</iframe>
</div>


<script type="text/javascript">
	//<![CDATA[
	function calcHeight() {
		//find the height of the internal page

		var ifr_h = document.getElementById('ifr_content').contentWindow.document.body.scrollHeight;

		//change the height of the iframe
		document.getElementById('ifr_content').height = ifr_h;

		//document.getElementById('ifr_content').scrolling = "no";
		document.getElementById('ifr_content').style.overflow = "hidden";
	}
	//
</script>


<!-- Contents end -->

<%@ include file="../footer.jsp"%>