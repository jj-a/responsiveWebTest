<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- Contents -->


<h3>회원 탈퇴</h3>

<c:choose>
	<c:when test="${sessionScope.s_id==null || sessionScope.s_mlevel}">
		<%-- 비회원, 로그인 안한 경우 --%>
		<script>
			alert("로그인 후 접근 가능한 페이지입니다.");
			location.href = "${pageContext.request.contextPath}/member2/loginform.do";
		</script>
	</c:when>
	<c:otherwise>
	
	<%-- form onsubmit에 memberCheck 부분에서 db에서 아이디 강제생성한 것들에 대해 id check(글자수,형식 제한...)가 들어가서 다음단계로 안넘어감 --%>
	
	<div>
	<form name="withdrawForm" method="post" action="withdraw.do" onsubmit="return withdrawCheck(this)">
		<table border="1" class="writefrm">
			<tr>
				<td colspan="3">회원가입 시 입력했던 정보를 입력해주세요.</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td colspan="2"><input type="password" name="passwd" id="passwd" size="10" required></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td colspan="2"><input type="password" name="repasswd" id="repasswd" size="10" required></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td colspan="2"><input type="text" name="email" id="email" size="30">			
				</td>
			</tr>
			<tr>
				<td colspan="3"><input type="submit" value="탈퇴하기"> <input type="button" value="취소" onclick="history.back()"></td>
			</tr>
		</table>
	</form>
	</div>
	
	<script>
	function withdrawCheck(f){
	
		var passwd=f.passwd.value;
		var repasswd=f.repasswd.value;
		
		if(passwd!=repasswd){
			alert("비밀번호 확인이 다릅니다. 다시 확인해주세요.");
			f.repasswd.focus();
			return false;
		}
		
		var msg="정말로 회원탈퇴를 진행하시겠습니까? 탈퇴가 된 후엔 되돌릴 수 없으며 로그인이 해제됩니다.";
		if(confirm(msg)) return true;
		else return false;
	}
	</script>

</c:otherwise>
</c:choose>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>
