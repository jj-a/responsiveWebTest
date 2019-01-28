<%@page import="net.utility.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3>
	<a href="pdsList.jsp">포토갤러리</a>
</h3>
<p>
	<a href="pdsForm.jsp">[사진올리기]</a>
</p>



<%
	try {
		// throw new Exception("수리중");
%>
<table class="list" border="1">
	<%
		ArrayList<PdsDTO> list = dao.list();

			if (list == null) {
				out.println("<tr>");
				out.println("<tr><td colspan='6'>자료가 존재하지 않습니다.</td></tr>");
				out.println("</tr>");
			} else {
				// 오늘 날짜를 yyyy-mm-dd 문자열로 저장
				String today = Utility.getDate();

				for (int i = 0; i < list.size(); i++) {
					dto = list.get(i);
	%>
	<!-- loop -->
	<tbody style="border-top: 20px solid white;" onclick="window.location='pdsRead.jsp?pdsno=<%=dto.getPdsno()%>'" onmouseover="style='cursor:pointer;'">
	<tr>
		<th>no</th>
		<td><%=dto.getPdsno()%></td>
		<th>제목</th>
		<td colspan="3"><%=dto.getSubject()%></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td><%=dto.getWname()%></td>
		<th>작성일</th>
		<td><%=dto.getRegdate()%></td>
		<th>조회수</th>
		<td><%=dto.getReadcnt()%></td>
	</tr>
	<tr style="border-top: 2px solid #cccccc; border-bottom:3px solid #cccccc;">
		<td colspan="6" style="background-color:white; "><img src="../upload/<%=dto.getFilename()%>" style="max-width:300px; max-height: auto; overflow:hidden;"></td>
	</tr>
	</tbody>
	<!-- loop -->

	<%
		} // for end
				/*
				// 글수 카운트
				out.println("<tr><td colspan='6'>");
				out.println(totalRecord + "개의 글이 있습니다.");
				out.println("</td></tr>");
				*/
	%>

	<tr>
		<td colspan="6">
			<!-- 페이지 리스트 --> 
			<%
			/*
 			String paging = new Paging().paging(totalRecord, nowPage, recordPerPage, col, word, "bbsList.jsp");
 			out.print(paging);
 			*/
 			%> 
	 <!-- 검색 시작 -->
			<form method="get" action="pdsList.jsp" onsubmit="return searchCheck(this)" class="search" style="display: inline;'">
				<select name="col">
					<option value="wname">작성자
					<option value="subject">제목
					<option value="content">내용
					<option value="subj_cont">제목+내용
				</select> <input type="text" name="word" class="search"> <input type="submit" value="검색" class="search">
			</form> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<div class="button-box">
				<input type="button" value="글쓰기" class="button" onclick="window.location='pdsForm.jsp'">
			</div>
		</td>
	</tr>
	<%
		} // else end
	%>
</table>
<%
	} catch (Exception e) {
		out.println("</table><div>공사중입니다. 이따 방문해주세요.</div>");
	}
%>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>
