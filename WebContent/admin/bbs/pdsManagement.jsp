<%@page import="net.utility.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../adminAuth.jsp"%>
<%@ include file="../../pds/ssi.jsp"%>
<%@ include file="../includeCss.jsp"%>

<div class="wrap">
	<h3>포토갤러리</h3>
		
	<form action="pdsDeleteProc.jsp">
	
		<table class="list">
			<tr>
				<td class="list-ip"><input type="checkbox" name="" value=""></td>
				<td colspan="7"></td>
			</tr>
		<%
			// 글수 카운트 변수
			int totalRecord=dao.count(col, word);
			// 페이지당 게시글수
			int recordPerPage=5;
			
			ArrayList<PdsDTO> list = dao.list(col,word,nowPage,recordPerPage);
	
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
		<tbody style="border-top: 20px solid white;" onmouseover="style='cursor:pointer;'">
			<tr>
				<td rowspan="2" class="list-ip"><input type="checkbox" name="" value=""></td>
				<th>no</th>
				<td><%=dto.getPdsno()%></td>
				<th>제목</th>
				<td colspan="3" class="list-subj">
					<a href="../../pds/pdsRead.jsp?pdsno=<%=dto.getPdsno()%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>" target="_new">
					<%=dto.getSubject()%>
					<%
					// 오늘 작성한 글 = New icon 출력
					String regdate=dto.getRegdate().substring(0,10);
					if(regdate.equals(today)) out.println("<img src='../../images/icon_new.png'>");
					// 조회수 20 이상인 글 = Hot icon 출력
					if(dto.getReadcnt()>=20) out.println("<img src='../../images/icon_hot.png'>");
					%>
					</a>
				</td>
				<td rowspan="2">
					<div class="img-square" style="width:100px; height:70px;">
					<a href="../../pds/pdsRead.jsp?pdsno=<%=dto.getPdsno()%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>" target="_new">
						<img src="../../upload/<%=dto.getFilename()%>">
					</a>
					</div>
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=dto.getWname()%></td>
				<th>작성일</th>
				<td><%=dto.getRegdate()%></td>
				<th>조회수</th>
				<td><%=dto.getReadcnt()%></td>
			</tr>
		</tbody>
		<!-- loop -->
	
		<%
			} // for end
					
					// 글수 카운트
					out.println("<tr><td colspan='8'>");
					out.println(totalRecord + "개의 글이 있습니다.");
					out.println("</td></tr>");
		%>
	
		<tr>
			<td colspan="8">
				<!-- 페이지 리스트 --> 
				<%
	 			String paging = new Paging().paging(totalRecord, nowPage, recordPerPage, col, word, "pdsManagement.jsp");
	 			out.print(paging);
	 			%> 

			</td>
		</tr>
		<%
			} // else end
		%>
		</table>
		<input type="button" value="선택 삭제" onclick="pdsDel(this.form)">
	</form>
	
 	<!-- 검색 시작 -->
	<form method="get" action="pdsManagement.jsp" onsubmit="return searchCheck(this)" class="search" style="display: inline;'">
		<select name="col">
			<option value="wname">작성자
			<option value="subject">제목
		</select> <input type="text" name="word" class="search"> <input type="submit" value="검색" class="search">
	</form>
</div>

<script>
	function sort(f) {
		f.submit();
	}
	
	function pdsDel(f) {
		var message="선택한 게시물을 삭제하시겠습니까?";
		if(confirm(message)) f.submit();
	}
</script>


<!-- Contents end -->
