<%@page import="net.utility.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../adminAuth.jsp"%>
<%@ include file="../../bbs/ssi.jsp"%>
<%@ include file="../includeCss.jsp"%>
<%@ include file="../includeJs.jsp"%>

<div class="wrap">
	<h3>게시판</h3>
		
	<form action="bbsDeleteProc.jsp">
		<table class="list">
			<tr>
				<th class="list-ip"><input type="checkbox" name="allchk" value="allchk" onclick="checkAll(this.form)"></th>
				<th class="list-no">번호</th>
				<th class="list-subj">제목</th>
				<th class="list-name">작성자</th>
				<th class="list-date">등록일</th>
				<th class="list-no">조회수</th>
				<th class="list-ip">IP</th>
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
					out.println("<tr><td colspan='7'>자료가 존재하지 않습니다.</td></tr>");
					out.println("</tr>");
				} else {
					// 오늘 날짜를 yyyy-mm-dd 문자열로 저장
					String today=Utility.getDate();
					
					for (int i = 0; i < list.size(); i++) {
						dto = list.get(i);		
			%>
			<tr>
				<td class="list-no"><input type="checkbox" name="selectchk" value=<%=dto.getBbsno()%>></td>
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
							for(int j=0;j<dto.getIndent();j++) out.println("<img src='../../images/icon_re.png'>");
					%>
					<a href="../../bbs/bbsRead.jsp?bbsno=<%=dto.getBbsno()%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>" target="_new"><%=dto.getSubject()%></a>
					<%
					
					// 오늘 작성한 글 = New icon 출력
					String regdt=dto.getRegdt().substring(0,10);
					if(regdt.equals(today)) out.println("<img src='../../images/icon_new.png'>");
	
					// 조회수 20 이상인 글 = Hot icon 출력
					if(dto.getReadcnt()>=20) out.println("<img src='../../images/icon_hot.png'>");
					%>
				</td>
				<td class="list-name"><%=dto.getWname()%></td>
				<td class="list-date"><%=dto.getRegdt().substring(0, 10)%></td>
				<td class="list-no"><%=dto.getReadcnt()%></td>
				<td class="list-ip">
				<%	// IP 변환
				String ip=dto.getIp();
				out.println(dao.ipConvent(ip));
				%></td>
			</tr>
			<%
					} // for end
					
					// 글수 카운트
					out.println("<tr><td colspan='7'>");
					out.println(totalRecord+"개의 글이 있습니다.");
					out.println("</td></tr>");
					
			%>
			<tr><td colspan="7">
			<!-- 페이지 리스트 -->
			<%
			String paging=new Paging().paging(totalRecord,nowPage,recordPerPage,col,word,"bbsManagement.jsp");
			out.print(paging);
			 %>
			</td></tr>
			<%
				} // else end
	
			%>
		</table>
	<input type="button" value="선택 삭제" onclick="delAdmin(this.form)">
	</form>			
	
		<!-- 검색 시작 -->
		<form method="get" action="bbsManagement.jsp" onsubmit="return searchCheck(this)" class="search" style="display:inline;'">
		<select name="col">
			<option value="wname">작성자
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
	
	function bbsDel(f) {
		var message="선택한 게시물을 삭제하시겠습니까?";
		if(confirm(message)) f.submit();
	}
</script>


<!-- Contents end -->
