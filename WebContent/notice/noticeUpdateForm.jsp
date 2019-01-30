<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../admin/adminAuth.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3><a href="noticeList.jsp">공지사항 수정</a></h3>
<p><a href="noticeList.jsp">[글 목록]</a></p>

<%
	if (s_adm_id.equals("guest") || s_adm_passwd.equals("guest") || s_adm_mlevel.equals("E1")) {
		// 비회원, 로그인 안한 경우
%>
		<script>
		alert("관리자만 접근 가능한 페이지입니다.");
		location.href="${pageContext.request.contextPath}/member/loginForm.jsp";
		</script>
<%		
	}else{
%>
	
	<%
		int noticeno = Integer.parseInt(request.getParameter("noticeno"));
		col=request.getParameter("col");
		word=request.getParameter("word");
		
		dto.setNoticeno(noticeno);
		
		dto = dao.update(dto);
		
	
		if (dto==null) {
			out.println("<script>");
			out.println("   alert('비밀번호가 일치하지 않습니다.');");
			out.println("   location.href='noticeList.jsp';");//페이지 이동      
			out.println("</script>");
		} else {
			
	%>
	
	<!-- noticeno, wname, subject, content, passwd, ip -->
	
	
	<form method="get" action="noticeUpdateProc.jsp" onsubmit="return noticeCheck(this)">
		<input type="hidden" name="noticeno" value="<%=noticeno%>">
		<input type="hidden" name="col" value="<%=col%>">
		<input type="hidden" name="word" value="<%=word%>">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		<table class="writefrm" border=1>
			<tr>
				<th>작성자</th>
				<td>관리자</td>
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

<%
	}
%>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>

