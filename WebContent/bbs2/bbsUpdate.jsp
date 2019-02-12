<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3><a href="bbslist.do"> 게시글 수정 </a></h3>
<p><a href="bbslist.do">[글 목록]</a></p>

<c:choose>
	<c:when test="${article==null}">
		<script>
		alert("비밀번호가 일치하지 않습니다.");
		window.location="bbscontent.do?num="+${num}+"nowPage="+${pageNum};
		</script>
	</c:when>
	<c:otherwise>
	
	<form method="get" action="bbsmodify.do" onsubmit="return bbsCheck(this)">
		<input type="hidden" name="num" value="${num}">
		<input type="hidden" name="pageNum" value="${pageNum}">
		<table class="writefrm" border=1>
			<tr>
				<th>이름</th>
				<td><input type="text" value="${article.writer}" name="writer" maxlength="10" required autofocus></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" value="${article.email}" name="email" maxlength="50" required autofocus></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" value="${article.subject}" name="subject" maxlength="100" required autofocus></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="5" cols="40" name="content">${article.content}</textarea></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" value="${article.passwd}" name="passwd" size="5" min="0" max="100" autofocus></td>
			</tr>
			<tr>
				<th>등록 IP</th>
				<td>
				<c:choose>
					<c:when test="${article.ip=='127.0.0.1'}||${article.ip=='0:0:0:0:0:0:0:1'}">Admin</c:when>
					<c:otherwise>${article.ip}</c:otherwise>
				</c:choose>
				</td>
			</tr>
			<tr>
				<th>등록일</th>
				<td>${article.reg_date}</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정"> 
					<input type="button" value="취소" onclick="javascript:history.back()">
				</td>
			</tr>
		</table>
	</form>
	
	</c:otherwise>
</c:choose>


<!-- Contents end -->

<%@ include file="../footer.jsp"%>

