<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/view/color.jspf" %>
<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3>* 글쓰기 *</h3>
<p><a href="bbsList.jsp">[글 목록]</a></p>

<form method="post" name="writeform" action="./bbsinsert.do">
<input type="hidden" name="num"      value="${num }">
<input type="hidden" name="ref"      value="${ref }">
<input type="hidden" name="re_step"  value="${re_step }">
<input type="hidden" name="re_level" value="${re_level }">

<table class="writefrm" width="450" border="1">
<tr>
  <td align="right" colspan=2 bgcolor="${value_c }">
      <a href="/myweb/bbs2/bbslist.do">글목록</a></td>
</tr>
<tr>
  <td bgcolor="${value_c }">이름</td>
  <td><input type="text" name="writer"></td>
</tr>
<tr>
  <td bgcolor="${value_c }">제목</td>
  <td><input type="text" name="subject"></td>
</tr>
<tr>
  <td bgcolor="${value_c }">이메일</td>
  <td><input type="text" name="email"></td>
</tr>
<tr>
  <td bgcolor="${value_c }">내용</td>
  <td><textarea name="content" rows="5" cols="40"></textarea></td>
</tr>
<tr>
  <td bgcolor="${value_c }">비밀번호</td>
  <td><input type="password" name="passwd"></td>
</tr>
<tr>
  <td colspan=2 bgcolor="{$value_c }" align="center">
  <input type="submit" value="글쓰기">
  <input type="reset"  value="취소">
  <input type="button" value="목록보기" onClick="location.href='./bbslist.do'">
  </td>
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
