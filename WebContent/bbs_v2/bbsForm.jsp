<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3>* 글쓰기 *</h3>
<p><a href="bbsList.jsp">[글 목록]</a></p>

<form name="bbsfrm" method="post" action="bbsIns.jsp" onsubmit="return bbsCheck(this)">
	<table class="writefrm" border=1>
		<tr>
			<th>작성자</th>
			<td><input type="text" name="wname" size="10" maxlength="20" required></td>
		</tr><tr>
			<th>제목</th>
			<td><input type="text" name="subject" size="20" maxlength="100" required></td>
		</tr><tr>
			<th>내용</th>
			<td><textarea rows="5" cols="30" name="content"></textarea></td>
		</tr><tr>
			<th>비밀번호</th>
			<td><input type="password" name="passwd" size="10"></td>
		</tr>
		<tr class="checkbox-line"><td colspan="2"><input type="checkbox" class="chk_notice" > 공지여부</td></tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="등록"> <input type="reset" value="지우기"> <input type="button" value="취소" onclick="javascript:history.back()"></td>
		</tr>
	</table>
</form>

<!-- Contents end -->
<script>
// 공지체크박스 오픈 여부
$(document).ready(function() { 
	alert("로딩 완료");
	var ip = request.getRemoteAddr();
	alert(ip);
	var chkbox=document.getElementByClass("checkbox-line");
	if(ip=="127.0.0.1"){
		alert("관리자입니다");
		chkbox.style.display="table-row";
	}
	
});


</script>
<%@ include file="../footer.jsp"%>
