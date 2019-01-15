<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%@ page import="web.tool.*"%>
<%@ page import="net.utility.*"%>
<%@ page import="net.bbs.*"%>

<jsp:useBean id="dto" class="net.bbs.BbsDTO"></jsp:useBean>
<jsp:useBean id="dao" class="net.bbs.BbsDAO"></jsp:useBean>

<%
	request.setCharacterEncoding("UTF-8");
%>