<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="./adminAuth.jsp"%>
<style>
body, table {
	font-size: 18px;
}

table {
	width: 80%;
}
</style>
<div align="center">
	<table>
		<tr><td align=center>관리자 메뉴</td></tr>
		<tr><td height=3 bgcolor=#808080></td></tr>
		<tr><td align="right"><a href="adminLogout.jsp" target="_top">로그아웃</a></td></tr>
		<tr><td height=1 bgcolor=#808080></td></tr>
		<tr><td><a href="bbs/bbs_fra.jsp" target="content">게시판 관리</a></td></tr>
		<tr><td height=1 bgcolor=#808080></td></tr>
		<tr><td><a href="noti/noti_fra.jsp" target="content">공지사항 관리</a></td></tr>
		<tr><td height=1 bgcolor=#808080></td></tr>
		<tr><td><a href="mem/mem_fra.jsp" target="content">회원 관리</a></td></tr>
		<tr><td height=1 bgcolor=#808080></td></tr>
		<tr><td style="background: '../images/009.gif'; background-repeat: no-repeat;"></td></tr>
	</table>
	<img src="../images/009.gif" style="width:100%;"> 
</div>
