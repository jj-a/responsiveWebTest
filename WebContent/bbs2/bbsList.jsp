<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp" %>

<!-- bbsList -->

<h3><a href="bbslist.do"> 게시판 </a></h3>
<p>&nbsp;</p>

<table border="1" class="list">
	<tr>
		<th class="list-no">번호</th>
		<th class="list-subj">제목</th>
		<th class="list-name">작성자</th>
		<!-- 
		<th class="list-no">그룹번호<br>(삭제예정)</th>
		<th class="list-no">re_level (indent)<br>(삭제예정)</th>
		<th class="list-no">re_step (ansnum)<br>(삭제예정)</th>
		 -->
		<th class="list-date">등록일</th>
		<th class="list-no">조회수</th>
		<th class="list-ip">IP<br>(삭제예정)</th>
	</tr>
	<%
		int totalRecord=dao.count(col, word);	//글수 카운트 변수
		int recordPerPage=10;	// 페이지당 게시글수
		
		// 전체 목록
		//ArrayList<BbsDTO> list = dao.list(col,word,nowPage,recordPerPage);
	%>
	
	<!-- if(count==0) -->
	<c:if test="${count==0}">
		<tr><td colspan='6'>자료가 존재하지 않습니다.</td></tr>
	</c:if>
	
	<!-- if(count>0) -->
	<c:if test="${count>0}">
	
		<!-- fmt: formatDate 액션에서 Timestamp 객체를 사용하기 위해 사용 -->
		<c:set var="today" value="<%=new Timestamp(System.currentTimeMillis()) %>"/>
		<c:set var="today" value="${fn:substring(today,0,10) }"/>
		
		<c:forEach var="article" items="${articleList }">
		
	<tr onclick="window.location='bbscontent.do?num=${article.num}&pageNum=${pageNum}'">
		<td class="list-no"><c:out value="${number}"/><c:set var="number" value="${number-1}"/></td>
	
		<c:choose>
			<%-- 답글 --%>
			<c:when test="${article.re_level>0}">
				<td class="list-subj re" onmouseover="style='cursor:pointer;'">
				<%-- 답글 Re 아이콘 출력 --%>
				<c:forEach var="i" begin="1" end="${article.re_level}"><img src='../images/icon_re.png'></c:forEach>
			</c:when>
			<%--새글 --%>
			<c:otherwise>
				<td class="list-subj" onmouseover="style='cursor:pointer;'">
			</c:otherwise>
		</c:choose>
		
			<a href="bbscontent.do?num=${article.num}&pageNum=${pageNum}">
			${article.subject}
			</a>
		
			<c:set var="reg" value="${article.reg_date}"/>
			<c:set var="date" value="${fn:substring(reg,0,10)}"/>
				
			<!-- 새글 (오늘 작성한 글) -->
			<c:if test="${today==date}">
			<img src='../images/icon_new.png'>
			</c:if>
			
			<!-- 인기글 (조회수 20이상 글) -->
			<c:if test="${article.readcount>=20}">
			<img src='../images/icon_hot.png'>
			</c:if>
	
		</td> <!-- c:when/otherwise 안의 td 닫는태그 -->
			
		
		<td class="list-name"><a href="mailto:${article.email}">
		${article.writer}
		</a></td>
		<!-- 
		<td class="list-no">${article.ref}</td>
		<td class="list-no">${article.re_level}</td>
		<td class="list-no">${article.re_step}</td>
		 -->
		<td class="list-date">${date}</td>
		<td class="list-no">${article.readcount}</td>
		<td class="list-ip">
		${article.ip }
		<% //pageContext.setAttribute("ip",dto.getIp());
		// IP 변환
		//out.println(dao.ipConvent(ip)); %>
		</td>
	</tr>
		</c:forEach> <!-- for end -->
			
	<!-- 글수 카운트 -->
	<tr><td colspan='6'>
	${count} 개의 글이 있습니다.
	</td></tr>
	
	</c:if>	<!-- if(count>0) end -->		
			
			
	<tr><td colspan="6">
		<div class="paging">
		<!-- 페이지 리스트 -->
		<c:if test="${count>0}">
			<c:set var="pageCount" value="${totalPage}"/>
			<c:set var="startPage" value="${startPage}"/>
			<c:set var="endPage" value="${endPage}"/>
			
			<c:if test="${endPage>pageCount}">
				<c:set var="endPage" value="${pageCount+1}"/>
			</c:if>
			
			<c:if test="${startPage>0}">
				<a href="./bbslist.do?pageNum=${startPage}"> 이전 </a>
			</c:if>
			
			<c:forEach var="i" begin="${startPage+1}" end="${endPage-1}">
				<a href="./bbslist.do?pageNum=${i}"> ${i} </a>	<!-- 페이지번호 -->
			</c:forEach>
			
			<c:if test="${endPage<pageCount}">
				<a href="./bbslist.do?pageNum=${startPage+11}"> 다음 </a>
			</c:if>
			
		</c:if>	<!-- if(count>0) end -->
		</div>
	
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
		<input type="button" value="글쓰기" class="button" onclick="window.location='./bbsform.do'">
		</div>
	</td></tr>
		
</table>

<!-- bbsList end -->

<%@ include file="../footer.jsp" %>