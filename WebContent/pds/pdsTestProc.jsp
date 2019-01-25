<%@page import="org.apache.catalina.filters.SetCharacterEncodingFilter"%>
<%@page import="com.sun.xml.internal.messaging.saaj.soap.MultipartDataContentHandler"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="net.utility.*"%>

<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>pdsTestProc.jsp</title>
</head>
<body style="margin: 0 auto; text-align:center;">
	<h3>파일 첨부 테스트 결과</h3>
	<h6>입력된 정보는 IP와 함께 서버로 전부 전송되었습니다*^^*</h6>

	<%
		request.setCharacterEncoding("UTF-8");
		String path = application.getRealPath("upload");
		//D:\java_1113\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\myweb\\upload
		System.out.println(path);
		int size = 1024 * 1024 * 10;
		String file = "";
		String oriFile = "";
		String ip=request.getRemoteAddr();

		try {
			// 파일 업로드
			MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", 
																										new DefaultFileRenamePolicy());

			// 파일명 확인
			Enumeration files = multi.getFileNames();
			String elemt = (String) files.nextElement();

			file = multi.getFilesystemName(elemt);
			oriFile = multi.getOriginalFileName(elemt);
			
			
			// 파일 세부정보 확인
			File f=multi.getFile(elemt);
			
			String fname="";
			long fsize=0;
			String fsizestr="";
			
			if(f.exists()){
				fname=f.getName();	//파일명
				fsize=f.length();	//파일크기
				fsizestr=Utility.toUnitStr(file.length());	//파일크기
			}else{
				out.print("해당 파일이 존재하지 않습니다.");
			}
			
			// 업로드 정보 console창에 전송
			System.out.println("**Upload Success** 업로드 정보");
			System.out.println("업로드 경로 파일명: "+file+" / 원본 파일명: "+oriFile);
			System.out.println("업로더: "+ip);
			System.out.println("이름: "+multi.getParameter("uname")+" / 제목: "+multi.getParameter("subject")+" / 내용: "+multi.getParameter("content")+"\n");
			
			// 업로드 결과 client 웹 화면에 전송
			out.println("<script> alert('파일 업로드 성공'); </script>");
		
	%>

	<table style="border: 1px solid #cccccc; padding: 10px; margin: 0 auto; text-align:center;">
		<tr>
			<td>이름:</td>
			<td><%=multi.getParameter("uname")%> (<%=ip%>)</td>
		</tr>
		<tr>
			<td>제목:</td>
			<td><%=multi.getParameter("subject")%></td>
		</tr>
		<tr>
			<td>내용:</td>
			<td><textarea rows="5" cols="20" name="content" style="resize: none;"><%=multi.getParameter("content")%></textarea></td>
		</tr>
		<tr>
			<td>첨부파일:</td>
			<td><a href="../upload/<%=fname%>" target="_new"> <%=file%> </a></td>
		</tr>
		<tr>
			<td></td>
			<td>(파일명- <%=fname%>  파일크기-<%=fsize/1024%>kb)
			</td>
		</tr>
		<tr>
			<td colspan="2"><img src="../upload/<%=file%>" width="300px"></td>
		</tr>
	</table>
	<%
		} catch (Exception e) {
			e.printStackTrace();
			// 업로드 결과 client 웹 화면에 전송
			out.println("<script> alert('파일 업로드 실패'); history.back(); </script>");
		}
	%>

</body>
</html>