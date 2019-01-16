<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h1>* 게시글 *</h1>
<p>
	<a href="bbsList.jsp">[글 목록]</a> <a href="bbsForm.jsp">[글쓰기]</a>
</p>
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	dto = dao.read(bbsno);
	if (dto == null) {
		out.println("<tr>");
		out.println("<tr><td colspan='7'>자료가 존재하지 않습니다.</td></tr>");
		out.println("</tr>");
	} else {
		// 조회수 증가
		int res = dao.incrementCnt(bbsno);
%>

<table border="1" class="list">
	<tr>
		<th colspan=1>그룹번호</th>
		<td colspan=1><%=dto.getGrpno()%></td>
		<th colspan=1>제목</th>
		<td colspan=4><%=dto.getSubject()%></td>
	</tr>
	<tr>
		<th style="width: 15%;">작성자</th>
		<td colspan=2 style="width: 25%;"><%=dto.getWname()%></td>
		<th style="width: 15%;">등록일</th>
		<td colspan=2 style="width: 45%;"><%=dto.getRegdt()%></td>
	</tr>
	<tr>
		<th>조회수</th>
		<td colspan=2><%=dto.getReadcnt()%></td>
		<th>indent</th>
		<td colspan=2><%=dto.getIndent()%></td>
	</tr>
	<tr>
		<th colspan=6>내용</th>
	</tr>
	<tr>
		<td colspan=6 height="100px">
			<%
				//	특수문자 그대로 입력되게 변경
					String content = Utility.convertChar(dto.getContent());
					out.println(content);
			%>
		</td>
	</tr>
	<tr>
		<th colspan=2>IP</th>
		<td colspan=4>
			<%
				//관리자
					if (dto.getIp().equals("127.0.0.1"))
						out.println("Admin");
					else
						out.println(dto.getIp());
			%>
		</td>
	</tr>

</table>
<p></p>
<form name="" method="post" action="" onsubmit="">
	<input type="hidden" name="bbsno" value="<%=bbsno%>">
	<input type="button" value="목록" onclick="move(this.form,'bbsList.jsp');">
	<input type="button" value="답변" onclick="move(this.form,'bbsReply.jsp')">
	<input type="button" value="수정" onclick="move(this.form,'bbsUpdate.jsp')">
	<input type="button" value="삭제" onclick="move(this.form,'bbsDelete.jsp?')">
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
