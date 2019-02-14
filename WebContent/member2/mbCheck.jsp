<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h3><a href="bbslist.do"> 게시글 
<c:if test="${page=='bbsmodiform'}">수정</c:if>
<c:if test="${page=='bbsdelete'}">삭제</c:if>
</a></h3>

<form method="post" action="${page}.do" onsubmit="return pwCheck(this)">
	<input type="hidden" name="num" value="${num }">
	<input type="hidden" name="pageNum" value="${pageNum }">
	<table class="writefrm" border=1>
		<tr>
			<td colspan="2">비밀번호를 입력해주세요.</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="passwd" size="5" min="0" max="100" autofocus required></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="확인"> <input type="button" value="취소" onclick="javascript:history.back()"></td>
		</tr>
	</table>
</form>

<script>

function pwCheck(f) {
	var passwd = f.passwd.value;
	passwd = passwd.trim();
	if (passwd.length < 4) {
		alert("비밀번호를 4자 이상 입력해주세요.");
		f.passwd.focus();
		return false;
	}
	<c:choose>
		<c:when test="${page=='bbsdelete'}">
			var msg="삭제 후엔 다시 되돌릴 수 없습니다. 계속 진행하시겠습니까?";
			if(confirm(msg)) return true;	// 확인 시 삭제 작업 수행
			else return false;
		</c:when>
		<c:otherwise>
		return true;
		</c:otherwise>
	</c:choose>
	
} // delPwCheck() end

</script>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>
