<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h3><a href="bbsList.jsp"> 게시글 </a></h3>
<p>&nbsp;</p>
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	dto = dao.read(bbsno);
	if (dto == null) {
		out.println("<tr>");
		out.println("<tr><td colspan='7'>자료가 존재하지 않습니다.</td></tr>");
		out.println("</tr>");
	} else {
		
		int res = dao.incrementCnt(bbsno);	// 조회수 증가
		int cnt = dao.replyCnt(bbsno);	// 답글수 확인
		
%>

<table border="1" class="list">
	<tr>
		<th colspan=1>제목</th>
		<td colspan=7 class="list-subj">
		<%
			// 답변 글 = Re icon 출력
			for(int j=0;j<dto.getIndent();j++) out.println("<img src='../images/icon_re.png'>");
		%>
		<%=dto.getSubject()%>
		</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td colspan=2><%=dto.getWname()%></td>
		<th>등록일</th>
		<td colspan=4><%=dto.getRegdt()%></td>
	</tr>
	<tr>
		<th style="width: 10%;">IP</th>
		<td colspan=2 style="width: 30%;" onclick="window.open('http://<%=dto.getIp()%>:9090/myweb/index.jsp')" onmouseover="style='cursor:pointer;'">
			<%	// IP 변환
			String ip=dto.getIp();
			out.println(dao.ipConvent(ip));
			out.println(" ("+ip+")");
			%>
		</td>
		<th style="width: 10%;">조회수</th>
		<td colspan=2 style="width: 15%;"><%=dto.getReadcnt()%></td>
		<th style="width: 10%;">답글수</th>
		<td colspan=2 style="width: 15%;"><%=cnt%></td>
	</tr>
	<tr>
		<th colspan=8>내용</th>
	</tr>
	<tr>
		<td colspan=8 height="100px">
			<%
				//	특수문자 그대로 입력되게 변경
					String content = Utility.convertChar(dto.getContent());
					out.println(content);
			%>
		</td>
	</tr>
	<tr>
		<th colspan=2>IP</th>
		<td colspan=6 onclick="window.open('http://<%=dto.getIp()%>:9090/myweb/index.jsp')">
			<%	// IP 변환
			ip=dto.getIp();
			out.println(dao.ipConvent(ip));
			out.println("  ("+ip+")");
			%>
		</td>
	</tr>

</table>
<p></p>
<form name="" method="get" action="" onsubmit="">
	<input type="hidden" name="bbsno" value="<%=bbsno%>">
	<input type="hidden" name="col" value="<%=col%>">
	<input type="hidden" name="word" value="<%=word%>">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="button" value="목록" onclick="move(this.form,'bbsList.jsp');">
	<input type="button" value="답변" onclick="move(this.form,'bbsReply.jsp')">
	<% if(s_mlevel.equals("A1") || s_mlevel.equals("B1")){ %>
	<input type="button" value="수정" onclick="move(this.form,'bbsUpdate.jsp')">
	<input type="button" value="삭제" onclick="move(this.form,'bbsDelete.jsp?')">
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
