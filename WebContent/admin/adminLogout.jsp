<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3>관리자 페이지 로그아웃</h3>

<%
	session.removeAttribute("s_adm_id");
	session.removeAttribute("s_adm_passwd");
	session.removeAttribute("s_adm_mlevel");
%>

<script>
alert("관리자 페이지에서 로그아웃합니다.");
location.href="adminLogin.jsp";
</script>

<!-- Contents end -->
