<%@page import="net.utility.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../adminAuth.jsp"%>
<%@ include file="../../notice/ssi.jsp"%>
<%@ include file="../includeCss.jsp"%>

<div class="wrap">
	<h3>게시물 삭제</h3>
		
	<form action="notiDeleteProc.jsp">
		<table class="list">
			<tr>
				<th class="list-ip"><input type="checkbox" name="allchk" value="allchk" onclick="checkAll(this.form, selectchk)"></th>
				<th class="list-no">번호</th>
				<th class="list-subj">제목</th>
				<th class="list-name">작성자</th>
				<th class="list-date">등록일</th>
			</tr>
			<%
			
				// 글수 카운트 변수
				int totalRecord=dao.count(col, word);
	
				// 페이지당 게시글수
				int recordPerPage=10;			
				
				
				// 전체 목록
				ArrayList<NoticeDTO> list = dao.list(col,word,nowPage,recordPerPage);
				
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
			<tr>
				<td class="list-no"><input type="checkbox" name="selectchk" value=<%=dto.getNoticeno()%>></td>
				<td class="list-no"><%=dto.getNoticeno()%></td>
				<td class="list-subj" onmouseover="style='cursor:pointer;'">
				
					<a href="../../notice/noticeRead.jsp?noticeno=<%=dto.getNoticeno()%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>" target="_new"><%=dto.getSubject()%></a>
					<%				
					// 오늘 작성한 글 = New icon 출력
					String regdt=dto.getRegdt().substring(0,10);
					if(regdt.equals(today)) out.println("<img src='../../images/icon_new.png'>");
					%>
				</td>
				<td class="list-name">관리자</td>
				<td class="list-date"><%=dto.getRegdt().substring(0, 10)%></td>
			</tr>
			<%
					} // for end
					
					// 글수 카운트
					out.println("<tr><td colspan='5'>");
					out.println(totalRecord+"개의 글이 있습니다.");
					out.println("</td></tr>");
			%>
			<tr><td colspan="5">
			<!-- 페이지 리스트 -->
			<%
			String paging=new Paging().paging(totalRecord,nowPage,recordPerPage,col,word,"noticeList.jsp");
			out.print(paging);
			 %>
			</td></tr>
			<%
				} // else end
			%>
		</table>
	<input type="button" value="선택 삭제" onclick="notiDel(this.form)">
	</form>
		
	<!-- 검색 시작 -->
	<form method="get" action="noticeList.jsp" onsubmit="return searchCheck(this)" class="search" style="display:inline;'">
	<select name="col">
		<option value="subject">제목
		<option value="content">내용
		<option value="subj_cont">제목+내용
	</select>
	<input type="text" name="word" class="search">
	<input type="submit" value="검색" class="search">
	</form>

</div>

<script>
	function sort(f) {
		f.submit();
	}
	
	function notiDel(f) {
		var message="선택한 게시물을 삭제하시겠습니까?";
		if(confirm(message)) f.submit();
	}
</script>


<!-- Contents end -->
