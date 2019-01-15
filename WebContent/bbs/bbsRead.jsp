<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- Contents -->
	<h1>* 성적 상세보기 *</h1>
	<p>
		<a href="bbsList.jsp">[성적목록]</a> <a href="bbsForm.jsp">[성적쓰기]</a>
	</p>
	<%
		int bbsno = Integer.parseInt(request.getParameter("bbsno"));
		dto = dao.read(bbsno);
		if (dto == null) {
			out.println("<tr>");
			out.println("<tr><td colspan='7'>자료가 존재하지 않습니다.</td></tr>");
			out.println("</tr>");
		} else {
	%>

	<table border="1" class="list">
		<tr>
			<th>제목</th>
			<td colspan=3><%=dto.getSubject()%></td>
		</tr>
		<tr>
			<th style="width:25%;">작성자</th>
			<td style="width:25%;"><%=dto.getWname()%></td>
			<th style="width:25%;">등록일</th>
			<td style="width:25%;"><%=dto.getRegdt()%></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=dto.getReadcnt()%></td>
			<th>답글수</th>
			<td><%=dto.getReadcnt()%></td>
		</tr>
		<tr>
			<th colspan=4>내용</th>
		</tr>
		<tr>
			<td colspan=4 height="100px"><%=dto.getContent()%></td>
		</tr>
		<tr>
			<th>IP</th>
			<td colspan=3><%=dto.getIp()%></td>
		</tr>

	</table>
	<p>
		<a href="bbsUpdate.jsp?sno=<%=bbsno%>">[수정]</a> <a
			href="bbsDel.jsp?sno=<%=bbsno%>">[삭제]</a>
	</p>
	<%
		}
	%>
	
<!-- Contents end -->
