<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3><a href="pdsList.jsp"> 게시글 수정 </a></h3>
<p><a href="pdsList.jsp">[글 목록]</a></p>

<%
	// form에서 값 가져오기 -> filename이 있는지 없는지 확인 
	// -> filename이 있으면 updateProc()2로, 없으면 updateProc()1으로 진행
	// -> updateProc()2로 진행시 메소드에서 기존파일 삭제 후, 현 페이지에서 새로운 파일 서버에 업로드

	// ISSUE //
	/*

	
	*/

	request.setCharacterEncoding("UTF-8");
	String path = application.getRealPath("upload");
	//D:\java_1113\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\myweb\\upload
	int size = 1024 * 1024 * 10;
	String file = "";
	String oriFile = "";
	String ip = request.getRemoteAddr();
	int res;

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
		
		String saveDir=application.getRealPath("/upload");

		int pdsno = Integer.parseInt(request.getParameter("pdsno"));

		String wname = multi.getParameter("wname").trim();
		String subject = multi.getParameter("subject").trim();
		//String filename = multi.getParameter("filename").trim();
		String passwd = multi.getParameter("passwd").trim();

		dto.setPdsno(pdsno);
		dto.setWname(wname);
		dto.setSubject(subject);
		dto.setPasswd(passwd);

		////////////// 수정파일여부 체크

		// 첨부파일 개수만큼 반복
		while (files.hasMoreElements()) {
			////////////////// loop ///////////////////

			elemt = (String) files.nextElement();
			file = multi.getFilesystemName(elemt);
			oriFile = multi.getOriginalFileName(elemt);

			if (file != null) { // 파일이 있을때??????????

				f = multi.getFile(elemt);

				if (f.exists()) {
					filename = f.getName(); //파일명
					filesize = f.length(); //파일크기

				} else {
					out.print("해당 파일이 존재하지 않습니다.");
				} // if(f.exists()) end

				dto.setFilename(filename);
				dto.setFilesize(filesize);

				res = dao.updateProc(dto, saveDir);

				if (res!=0) {
					// 업로드 결과 client 웹 화면에 전송
					out.println("<script> alert('파일 업로드 성공'); </script>");
					System.out.println();
%>
<!-- 반복구간 -->
<tr>
	<td>첨부파일:</td>
	<td><a href="../upload/<%=filename%>" target="_new"> <%=file%>
	</a>(<%=filesize / 1024%>kb)</td>
</tr>
<tr>
	<td colspan="2"><img src="../upload/<%=file%>" width="300px"></td>
</tr>
<!-- 반복구간 -->
<%
	////////////////////////////////////////수정파일있을때//////////////////////////////////

					dto.setFilename(filename);
					res = dao.updateProc(dto);

					if (res == 0) {
						out.print("<p>게시글 수정에 실패했습니다. <br>비밀번호를 확인해주세요.</p>");
						out.print("<p><a href='javascript:history.back();'>[다시시도]</a>");
						out.print("<a href='pdsList.jsp'> [글 목록] </a></p>");
					} else {
						out.print("<script>");
						out.print("alert('게시글이 수정되었습니다.');");
						out.print("window.location='pdsList.jsp?';");//페이지 이동
						out.print("</script>");
					}

					// 업로드 정보 console창에 전송
					System.out.println("**Upload Success** 업로드 정보");
					System.out.println("업로더: " + ip);
					System.out.println("이름: " + wname + " / 제목: " + subject);
					System.out.println("업로드 경로 파일명: " + file + " / 원본 파일명: " + oriFile);

				} else {	// flag==false
					// 업로드 결과 client 웹 화면에 전송
					out.println("<script> alert('파일 업로드 실패'); history.back(); </script>");
				} // if(flag==true) end

			}else{	// file==null
			
				System.out.println("file==null 접근");
				
			}// if(file!=null) end

			////////////////// loop ///////////////////

		} // while() end
	} catch (Exception e) {
		e.printStackTrace();
		out.println("<script>alert('파일 확인 중 오류 발생'); history.back();</script>");
	}
%>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>

