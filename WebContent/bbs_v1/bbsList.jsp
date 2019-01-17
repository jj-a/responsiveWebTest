<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- bbsList -->

<h3> * 게시판 목록 * </h3>
<p><a href="bbsForm.jsp">[글쓰기]</a></p>

	<table border="1" class="list">
		<tr>
			<th class="list-no">번호</th>
			<th class="list-subj">제목</th>
			<th class="list-name">작성자</th>
			<!-- 
			<th class="list-no">그룹번호<br>(삭제예정)</th>
			<th class="list-no">indent<br>(삭제예정)</th>
			<th class="list-no">ansnum<br>(삭제예정)</th>
			 -->
			<th class="list-date">등록일</th>
			<th class="list-no">조회수</th>
			<th class="list-ip">IP<br>(삭제예정)</th>
		</tr>
		<%
			// 전체 목록
			ArrayList<BbsDTO> list = dao.list();
			if (list == null) {
				out.println("<tr>");
				out.println("<tr><td colspan='5'>자료가 존재하지 않습니다.</td></tr>");
				out.println("</tr>");
			} else {
				// 오늘 날짜를 yyyy-mm-dd 문자열로 저장
				String today=Utility.getDate();
				
				for (int i = 0; i < list.size(); i++) {
					dto = list.get(i);		
		%>
		<tr onclick="window.location='bbsRead.jsp?bbsno=<%=dto.getBbsno()%>'">
			<td class="list-no"><%=dto.getBbsno()%></td>
			<td class="list-subj" onmouseover="style='cursor:pointer;'">
				<%
					// 답변 글 = Re icon 출력
						for(int j=0;j<dto.getIndent();j++) out.println("<img src='../images/icon_re.png'>");
				%>
				<a href="bbsRead.jsp?bbsno=<%=dto.getBbsno()%>"><%=dto.getSubject()%></a>
				<%
				// 오늘 작성한 글 = New icon 출력
				String regdt=dto.getRegdt().substring(0,10);
				if(regdt.equals(today)) out.println("<img src='../images/icon_new.png'>");

				// 조회수 20 이상인 글 = Hot icon 출력
				if(dto.getReadcnt()>=20) out.println("<img src='../images/icon_hot.png'>");
				%>
			</td>
			<td class="list-name"><%=dto.getWname()%></td>
			<!-- 
			<td class="list-no"><%=dto.getGrpno()%></td>
			<td class="list-no"><%=dto.getIndent()%></td>
			<td class="list-no"><%=dto.getAnsnum()%></td>
			 -->
			<td class="list-date"><%=dto.getRegdt().substring(0, 10)%></td>
			<td class="list-no"><%=dto.getReadcnt()%></td>
			<td class="list-ip">
			<%	// IP 변환
				if(dto.getIp().equals("127.0.0.1")) out.println("Admin");
				else if(dto.getIp().equals("172.16.10.6")) out.println("장민수");
				else if(dto.getIp().equals("172.16.10.8")) out.println("누리누리");
				else if(dto.getIp().equals("172.16.10.16")) out.println("계석준");
				else if(dto.getIp().equals("172.16.10.22")) out.println("나기범");
				else if(dto.getIp().equals("172.16.10.100")) out.println("강사님");
				else if(dto.getIp().equals("172.16.10.253")) out.println("Mobile");
				else out.println(dto.getIp());
			%></td>
		</tr>
		<%
				} // for end
			} // else end
		%>
	</table>

<!-- bbsList end -->

<%@ include file="../footer.jsp" %>

