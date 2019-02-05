<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../adminAuth.jsp"%>
<%@ include file="../../notice/ssi.jsp"%>
<%@ include file="../includeCss.jsp"%>
<%@ include file="../includeJs.jsp"%>

<!-- Contents -->

<div class="wrap">
	<h3>공지사항 수정</h3>
	
	<%
		int noticeno = Integer.parseInt(request.getParameter("noticeno"));
		col=request.getParameter("col");
		word=request.getParameter("word");
		System.out.println("업뎃폼: "+col+" "+word);	//★★★
		
		dto.setNoticeno(noticeno);
		
		dto = dao.update(dto);
		
	%>
	
	<form method="get" action="../../notice/noticeUpdateProc.jsp" onsubmit="return noticeCheck(this)">
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
	
</div>

<!-- Contents end -->
