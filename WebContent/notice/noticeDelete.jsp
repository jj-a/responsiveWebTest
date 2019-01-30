<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../admin/adminAuth.jsp"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->
<h3><a href="noticeList.jsp">공지사항 삭제</a></h3>

<%
	if (s_adm_id.equals("guest") || s_adm_passwd.equals("guest") || s_adm_mlevel.equals("E1")) {
		// 비회원, 로그인 안한 경우
%>
		<script>
		alert("관리자만 접근 가능한 페이지입니다.");
		location.href="${pageContext.request.contextPath}/member/loginForm.jsp";
		</script>
<%		
	}else{
%>

<form name="deletefrm" id="deletefrm" method="post" action="noticeDeleteProc.jsp" onsubmit="return delCheck(this)">
	<input type="hidden" name="noticeno" value="<%=request.getParameter("noticeno")%>">
	<input type="hidden" name="col" value="<%=request.getParameter("col")%>">
	<input type="hidden" name="word" value="<%=word%>">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
</form>

<script>
$(document).ready(function() { 
	var msg="삭제 후엔 다시 되돌릴 수 없습니다. 계속 진행하시겠습니까?";
	if(confirm(msg)){
		this.document.getElementById("deletefrm").submit();
	}else {
		history.back();
	}
});

//this.document.getElementById("deletefrm").submit(); 

function delCheck(f){
	var msg="삭제 후엔 다시 되돌릴 수 없습니다. 계속 진행하시겠습니까?";
	if(confirm(msg)) return true;	// 확인 시 삭제 작업 수행
	else return false;
}
</script>

<%
	}
%>


<!-- Contents end -->

<%@ include file="../footer.jsp"%>
