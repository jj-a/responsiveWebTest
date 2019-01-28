<%@page import="net.utility.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3>
	<a href="pdsList.jsp">포토갤러리</a>
</h3>
<p>이미지 업로드가 완료되었습니다. 업로드 정보는 서버 콘솔창에 전달됩니다*^^*</p>

<%
	request.setCharacterEncoding("UTF-8");
	String path = application.getRealPath("upload");
	//D:\java_1113\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\myweb\\upload
	int size = 1024 * 1024 * 10;
	String file = "";
	String oriFile = "";
	String ip = request.getRemoteAddr();

	try {

		// 파일 업로드
		MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());

		// 파일명 확인
		Enumeration files = multi.getFileNames();
		String elemt = "";

		// 파일 세부정보 확인
		File f = null;
		String filename = "";
		long filesize = 0;
%>

<table class="writefrm">
	<tr>
		<td>작성자:</td>
		<td><%=multi.getParameter("wname")%> (<%=ip%>)</td>
	</tr>
	<tr>
		<td>제목:</td>
		<td><%=multi.getParameter("subject")%></td>
	</tr>
	<%
		// 첨부파일 개수만큼 반복
			while (files.hasMoreElements()) {
				////////////////// loop ///////////////////

				elemt = (String) files.nextElement();
				file = multi.getFilesystemName(elemt);
				oriFile = multi.getOriginalFileName(elemt);

				if (file != null) {

					f = multi.getFile(elemt);

					if (f.exists()) {
						filename = f.getName(); //파일명
						filesize = f.length(); //파일크기

					} else {
						out.print("해당 파일이 존재하지 않습니다.");
					} // if(f.exists()) end

					String wname = multi.getParameter("wname").trim();
					String subject = multi.getParameter("subject").trim();
					String passwd = multi.getParameter("passwd").trim();

					dto.setWname(wname);
					dto.setSubject(subject);
					dto.setPasswd(passwd);
					dto.setFilename(filename);
					dto.setFilesize(filesize);

					boolean flag = dao.insert(dto);

					if (flag == true) {
						// 업로드 결과 client 웹 화면에 전송
						out.println("<script> alert('파일 업로드 성공'); </script>");
						System.out.println();
	%>
				<!-- 반복구간 -->
				<tr>
					<td>첨부파일:</td>
					<td><a href="../upload/<%=filename%>" target="_new"> <%=file%>
					</a>(<%=filesize / 1024%>kb)
					</td>
				</tr>
				<tr>
					<td colspan="2"><img src="../upload/<%=file%>" width="300px"></td>
				</tr>
				<!-- 반복구간 -->

	<%
					// 업로드 정보 console창에 전송
						System.out.println("**Upload Success** 업로드 정보");
						System.out.println("업로더: " + ip);
						System.out.println("이름: " + wname + " / 제목: " + subject);
						System.out.println("업로드 경로 파일명: " + file + " / 원본 파일명: " + oriFile);

					} else {
						// 업로드 결과 client 웹 화면에 전송
						out.println("<script> alert('파일 업로드 실패'); history.back(); </script>");
					} // if(flag==true) end

				} // if(file!=null) end

				////////////////// loop ///////////////////

			} // while() end
	%>
	<tr><td colspan="2"><button onclick="location.href='pdsList.jsp'">리스트</button></td></tr>
</table>

<%
	} catch (Exception e) {
		e.printStackTrace();
		out.println("<script> alert('파일 확인 중 오류 발생'); history.back(); </script>");
	}
%>



<!-- Contents end -->

<%@ include file="../footer.jsp"%>
