<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- bbsList -->

<h3> * 게시판 목록 * </h3>
<p><a href="bbsForm.jsp">[글쓰기]</a></p>

	<table border="1" class="list">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>내용<br>(삭제예정)</th>
			<th>그룹번호<br>(삭제예정)</th>
			<th>등록일</th>
			<th>IP<br>(삭제예정)</th>
		</tr>
		<%
			// 전체 목록
			ArrayList<BbsDTO> list = dao.list();
			if (list == null) {
				out.println("<tr>");
				out.println("<tr><td colspan='5'>자료가 존재하지 않습니다.</td></tr>");
				out.println("</tr>");
			} else {

				for (int i = 0; i < list.size(); i++) {
					dto = list.get(i);		
		%>
		<tr onclick="window.location='bbsRead.jsp?bbsno=<%=dto.getBbsno()%>'" onmouseover="style='cursor:pointer;'">
			<td><%=dto.getBbsno()%></td>
			<td><a href="bbsRead.jsp?bbsno=<%=dto.getBbsno()%>"><%=dto.getSubject()%></a></td>
			<td><%=dto.getWname()%></td>
			<td><%=dto.getContent()%></td>
			<td><%=dto.getGrpno()%></td>
			<td><%=dto.getRegdt().substring(0, 10)%></td>
			<td><%=dto.getIp()%></td>
		</tr>
		<%
				} // for end
			} // else end
		%>
	</table>

<!-- bbsList end -->

<%@ include file="../footer.jsp" %>