<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h3><a href="noticeList.jsp"> 공지사항 </a></h3>
<p>&nbsp;</p>
<%
	int noticeno = Integer.parseInt(request.getParameter("noticeno"));
	dto = dao.read(noticeno);
	if (dto == null) {
		out.println("<tr>");
		out.println("<tr><td colspan='4'>자료가 존재하지 않습니다.</td></tr>");
		out.println("</tr>");
	} else {
		
		//int res = dao.incrementCnt(noticeno);	// 조회수 증가
		
%>

<table border="1" class="list">
	<tr>
		<th>제목</th>
		<td colspan="3" class=""><%=dto.getSubject()%></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>관리자</td>
		<th>등록일</th>
		<td><%=dto.getRegdt()%></td>
	</tr>
	<tr>
		<th colspan="4">내용</th>
	</tr>
	<tr>
		<td colspan="4" height="100px">
			<%
				//	특수문자 그대로 입력되게 변경
					String content = Utility.convertChar(dto.getContent());
					out.println(content);
			%>
		</td>
	</tr>
</table>
<p></p>
<form name="" method="get" action="" onsubmit="">
	<input type="hidden" name="noticeno" value="<%=noticeno%>">
	<input type="hidden" name="col" value="<%=col%>">
	<input type="hidden" name="word" value="<%=word%>">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="button" value="목록" onclick="move(this.form,'noticeList.jsp');">
	<% if(s_mlevel.equals("A1") || s_mlevel.equals("B1")){ %>
	<input type="button" value="수정" onclick="move(this.form,'noticeUpdateForm.jsp')">
	<input type="button" value="삭제" onclick="move(this.form,'noticeDelete.jsp?')">
	<% } %>
</form>
<%
	}
%>

<!-- Contents end -->

<script>

function move(f, file){
	f.action=file;
	f.submit();
}
</script>

<%@ include file="../footer.jsp"%>
