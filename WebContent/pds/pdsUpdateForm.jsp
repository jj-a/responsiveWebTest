<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<%
	String passwd = request.getParameter("passwd").trim();
	int pdsno = Integer.parseInt(request.getParameter("pdsno"));
	/*
	col=request.getParameter("col");
	word=request.getParameter("word");
	*/
	dto.setPasswd(passwd);
	dto.setPdsno(pdsno);
	
	dto = dao.update(dto);
	

	if (dto==null) {
		out.println("<script>");
		out.println("alert('비밀번호가 일치하지 않습니다.');");
		out.println("location.href='pdsList.jsp';");//페이지 이동      
		out.println("</script>");
	} else {
		
%>

<h3><a href="pdsList.jsp"> 게시글 수정 </a></h3>

<form name="frmData" method="post" enctype="multipart/form-data" action="pdsUpdateProc.jsp" onsubmit="return pdsUdtCheck(this)">
	<input type="hidden" name="pdsno" value="<%=pdsno%>">
	<table border="1" class="writefrm">
		<tr>
			<th colspan="2">파일 등록</th>
		</tr>
		<tr>
			<th width="97">작성자</th>
			<td width="5"><input type="text" name="wname" value="<%=dto.getWname()%>"></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><textarea name="subject" rows='5' cols='30'><%=dto.getSubject()%></textarea></td>
		</tr>
		<tr>
			<th>비밀번호*</th>
			<td><input type="password" name="passwd" value="<%=dto.getPasswd()%>"></td>
		</tr>
		<tr>
			<th>파일</th>
			<td>
				<input type="file" name="filename" style="color:transparent;" onchange="style='color:auto;'">
				<label for="filename"><%=dto.getFilename()%></label>
			</td>
		</tr>
		<tr>
			<th>등록일</th>
			<td><%=dto.getRegdate()%></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="수정"> <input type="reset" value="지우기"> <input type="button" value="취소" onclick="history.go(-2)">
			</td>
		</tr>
	</table>
</form>
<%
	}
%>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>

