<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ page import="web.tool.*"%>
<%@ page import="net.utility.*"%>
<%@ page import="net.pds.*"%>

<jsp:useBean id="dto" class="net.pds.PdsDTO"></jsp:useBean>
<jsp:useBean id="dao" class="net.pds.PdsDAO"></jsp:useBean>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%
/*	검색 관련 변수 */
String col=request.getParameter("col");	// 검색칼럼
String word=request.getParameter("word");	// 검색어

// null이면 공백문자열 반환
col=Utility.checkNull(col);
word=Utility.checkNull(word);

// 현재 페이지
int nowPage=1;
if(request.getParameter("nowPage")!=null) 
	nowPage=Integer.parseInt(request.getParameter("nowPage"));


%>
