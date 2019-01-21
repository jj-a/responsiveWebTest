<%@page import="net.utility.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- bbsList -->

<%
try {
	// throw new Exception("수리중");
%>
<h3><a href="bbsList.jsp"> 게시판 </a></h3>
	<p><h6><%
	String ip=request.getRemoteAddr();
	out.println(ip+" 님, 안녕하세요! ");
	out.println("&nbsp;&nbsp;오늘의 방문자 수: "+dao.ipCheck(ip)+"<br> 카운트를 어떡해야하는걸까,,,");
	%></h6></p>
<p><a href="bbsComment.jsp">[댓글 목록]</a></p>
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
		
			// 글수 카운트 변수
			int totalRecord=dao.count(col, word);

			// 페이지당 게시글수
			int recordPerPage=10;			
			
			
			// 전체 목록
			ArrayList<BbsDTO> list = dao.list(col,word,nowPage,recordPerPage);
			
			if (list == null) {
				out.println("<tr>");
				out.println("<tr><td colspan='6'>자료가 존재하지 않습니다.</td></tr>");
				out.println("</tr>");
			} else {
				// 오늘 날짜를 yyyy-mm-dd 문자열로 저장
				String today=Utility.getDate();
				
				for (int i = 0; i < list.size(); i++) {
					dto = list.get(i);		
		%>
		<tr onclick="window.location='bbsRead.jsp?bbsno=<%=dto.getBbsno()%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>'">
			<td class="list-no"><%=dto.getBbsno()%></td>
			<%
				if(dto.getIndent()!=0){
			%>
			<td class="list-subj re" onmouseover="style='cursor:pointer;'">
			<%
				} // if end
				else{
			%>
			<td class="list-subj" onmouseover="style='cursor:pointer;'">
				<%
				} // else end
					// 답변 글 = Re icon 출력
						for(int j=0;j<dto.getIndent();j++) out.println("<img src='../images/icon_re.png'>");
				%>
				<a href="bbsRead.jsp?bbsno=<%=dto.getBbsno()%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>"><%=dto.getSubject()%></a>
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
			ip=dto.getIp();
			out.println(dao.ipConvent(ip));
			%></td>
		</tr>
		<%
				} // for end
				
				// 글수 카운트
				out.println("<tr><td colspan='6'>");
				out.println(totalRecord+"개의 글이 있습니다.");
				out.println("</td></tr>");
				
		%>
		<tr><td colspan="6">
		<!-- 페이지 리스트 -->
		<%
		String paging=new Paging().paging(totalRecord,nowPage,recordPerPage,col,word,"bbsList.jsp");
		out.print(paging);
		 %>
		<!-- 검색 시작 -->
		<form method="get" action="bbsList.jsp" onsubmit="return searchCheck(this)" class="search" style="display:inline;'">
		<select name="col">
			<option value="wname">작성자
			<option value="subject">제목
			<option value="content">내용
			<option value="subj_cont">제목+내용
		</select>
		<input type="text" name="word" class="search">
		<input type="submit" value="검색" class="search">
		</form>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<div class="button-box">
		<input type="button" value="글쓰기" class="button" onclick="window.location='bbsForm.jsp'">
		</div>
		</td></tr>
		<%
			} // else end

		%>
	</table>
<%
} catch(Exception e) {
	out.println("</table><div>공사중입니다. 이따 방문해주세요.</div>");
}
%>
<!-- bbsList end -->

<%@ include file="../footer.jsp" %>

