<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h3><a href="pdsList.jsp"> 상세 보기 </a></h3>
<p>&nbsp;</p>

<%
	int pdsno = Integer.parseInt(request.getParameter("pdsno"));

	dto = dao.read(pdsno);

	if (dto == null) {
		out.println("<tr>");
		out.println("<tr><td colspan='6'>자료가 존재하지 않습니다.</td></tr>");
		out.println("</tr>");
	} else {

		int res = dao.incrementCnt(pdsno); // 조회수 증가
		//int cnt = dao.replyCnt(pdsno); // 답글수 확인
		String fileextend = dto.getFilename().substring(dto.getFilename().lastIndexOf(".") + 1);
%>

<table border="1" class="list">
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
	<tr style="border-top: 3px solid #cccccc; border-bottom: 3px solid #cccccc;">
		<td colspan="6" style="background-color: white;"><img src="../upload/<%=dto.getFilename()%>" style="max-width: 700px; overflow: hidden;"></td>
	</tr>
	<tr>
		<th>파일명</th>
		<td><%=dto.getFilename()%></td>
		<th>포맷</th>
		<td><%=fileextend%></td>
		<th>파일크기</th>
		<td>
		<% // 파일 크기 변환
		double filesize=dto.getFilesize();
		String sizefm[]={"Byte","KB","MB","GB"};
		int cntfm=0;
		while(filesize/1024>=1){
			filesize/=1024;
			cntfm++;
		}
		%>
		<%=String.format("%.2f",filesize)%><%=sizefm[cntfm]%>
		</td>
	</tr>

</table>
<p></p>
<form name="" method="get" action="" onsubmit="">
	<input type="hidden" name="pdsno" value="<%=dto.getPdsno()%>"> 
	<!-- 
	<input type="hidden" name="col" value="<%=col%>"> 
	<input type="hidden" name="word" value="<%=word%>"> 
	<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
	<input type="button" value="답변" onclick="move(this.form,'bbsReply.jsp')">
	 -->
	<input type="button" value="▼이전 게시물"  onclick="window.location='pdsRead.jsp?pdsno=<%=dto.getPdsno()-1%>';">
	<input type="button" value="목록" onclick="move(this.form,'pdsList.jsp');">
	<%
		if (s_mlevel.equals("A1") || s_mlevel.equals("B1")) {
	%>
	<input type="button" value="수정" onclick="move(this.form,'pdsUpdate.jsp')"> 
	<input type="button" value="삭제" onclick="move(this.form,'pdsDelete.jsp?')">
	<input type="button" value="다음 게시물▲"  onclick="window.location='pdsRead.jsp?pdsno=<%=dto.getPdsno()+1%>';">
	<%
		}
	%>
</form>
<%
	}
%>

<!-- Contents end -->

<script>
	function move(f, file) {
		f.action = file;
		f.submit();
	}
</script>

<%@ include file="../footer.jsp"%>
