<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h1>* 게시글 수정 *</h1>
<p>
	<a href="bbsList.jsp">[글 목록]</a>
</p>
<%
	String passwd = request.getParameter("passwd").trim();
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	
	dto.setPasswd(passwd);
	dto.setBbsno(bbsno);
	
	dto = dao.update(dto);
	

	if (dto==null) {
		out.println("<script>");
		out.println("   alert('비밀번호가 일치하지 않습니다.');");
		out.println("   location.href='bbsList.jsp';");//페이지 이동      
		out.println("</script>");
	} else {
		
		out.println(dto);
%>

<!-- bbsno, wname, subject, content, passwd, ip -->


<form method="post" action="bbsUpdateProc.jsp" onsubmit="return bbsCheck(this)">
	<input type="hidden" name="bbsno" value="<%=bbsno%>">
	<table class="writefrm" border=1>
		<tr>
			<th>작성자</th>
			<td><input type="text" value="<%=dto.getWname()%>" name="wname" maxlength="10" required autofocus></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" value="<%=dto.getSubject()%>" name="subject" maxlength="100" required autofocus></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="5" cols="30" name="content"><%=dto.getContent()%></textarea></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" value="<%=dto.getPasswd()%>" name="passwd" size="5" min="0" max="100" autofocus></td>
		</tr>
		<tr>
			<th>등록 IP</th>
			<td>
				<%
					if (dto.getIp().equals("127.0.0.1"))
							out.println("Admin");
						else
							out.println(dto.getIp());
				%>
			</td>
		</tr>
		<tr>
			<th>등록일</th>
			<td><%=dto.getRegdt()%></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="수정"> <input type="button" value="취소" onclick="javascript:history.back()"></td>
		</tr>
	</table>
</form>
<%
	}
%>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>

