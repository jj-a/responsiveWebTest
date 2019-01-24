<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.utility.*" %>

<% 
		// adminAuth.jsp
		// 관리자 로그인 상태 확인 페이지
		
		String s_adm_id="";
		String s_adm_passwd="";
		String s_adm_mlevel="";

		if(session.getAttribute("s_adm_id")==null || session.getAttribute("s_adm_passwd")==null || session.getAttribute("s_adm_mlevel")==null){
			s_adm_id="guest";
			s_adm_passwd="guest";
			s_adm_mlevel="E1";		// 비회원 등급
			
			//로그인 하지 않은 경우 관리자 로그인 페이지로 자동 이동
			String root=Utility.getRoot();
			%>
			<script>
			alert("관리자 로그인 후 이용해주세요.");
			location.href="<%=root%>/admin/adminLogin.jsp";
			</script>
			<%
			
		}
		else{
			s_adm_id=(String)session.getAttribute("s_adm_id");
			s_adm_passwd=(String)session.getAttribute("s_adm_passwd");
			s_adm_mlevel=(String)session.getAttribute("s_adm_mlevel");
		}
	
%>
