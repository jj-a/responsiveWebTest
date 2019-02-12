<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h3><a href="bbslist.do"> 게시글 </a></h3>
<p>&nbsp;</p>

<table border="1" class="list">
<c:choose>
	<c:when test="${article==null}">
	<tr><td colspan='7'>자료가 존재하지 않습니다.</td></tr>
	</c:when>
	<c:otherwise>
	<tr>
		<th colspan=1>제목</th>
		<td colspan=7 class="list-subj">
		<%-- 답글 Re 아이콘 출력 --%>
		<c:forEach var="i" begin="1" end="${article.re_level}"><img src='../images/icon_re.png'></c:forEach>
		${article.subject}
		</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td colspan=2>${article.writer}</td>
		<th>등록일</th>
		<td colspan=4>${article.reg_date}</td>
	</tr>
	<tr>
		<th style="width: 10%;">IP</th>
		<td colspan=2 style="width: 30%;" onclick="window.open('http://${article.ip}:9090/myweb/index.jsp')" onmouseover="style='cursor:pointer;'">
			${article.ip}
			<%	// IP 변환
			//String ip=dto.getIp();
			//out.println(dao.ipConvent(ip));
			//out.println(" ("+ip+")");
			%>
		</td>
		<th style="width: 10%;">조회수</th>
		<td colspan=2 style="width: 15%;">${article.readcount}</td>
		<th style="width: 10%;">답글수</th>
		<td colspan=2 style="width: 15%;">답글수칸</td>
	</tr>
	<tr>
		<th colspan=8>내용</th>
	</tr>
	<tr>
		<td colspan=8 height="100px">
			<%
				// 특수문자 치환 변수
				pageContext.setAttribute("cr","\r");
				pageContext.setAttribute("crcn","\r\n");
				pageContext.setAttribute("cn","\n");
				pageContext.setAttribute("br","<br>");
			%>
			<%-- ${article.content} --%>
			${fn:replace(article.content, cn, '<br>') }
			
		</td>
	</tr>
	<tr>
		<th colspan=2>IP</th>
		<td colspan=6 onclick="window.open('http://${article.ip}:9090/myweb/index.jsp')">
			${article.ip}
			<%	// IP 변환
			//ip=dto.getIp();
			//out.println(dao.ipConvent(ip));
			//out.println("  ("+ip+")");
			%>
		</td>
	</tr>

	</c:otherwise>
</c:choose>

</table>
<p></p>

<input type="button" value="목록" onclick="location.href='./bbslist.do?pageNum=${pageNum}'">
<input type="button" value="답변" onclick="location.href='./bbsform.do?num=${article.num}&ref=${article.ref}&re_step=${article.re_step}&re_level=${article.re_level}'">
<% if(s_mlevel.equals("A1") || s_mlevel.equals("B1")){ %>
<input type="button" value="수정" onclick="location.href='./bbscheck.do?num=${article.num}&pageNum=${pageNum}&page=bbsmodiform'">
<input type="button" value="삭제" onclick="location.href='./bbscheck.do?num=${article.num}&pageNum=${pageNum}&page=bbsdelete'">
<% } %>
	
<!-- Contents end -->

<%@ include file="../footer.jsp"%>
