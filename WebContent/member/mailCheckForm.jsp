<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>idCheckForm.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/stylesheet.css?ver=1.008">
<style></style>
</head>
<body>

	<div>
		<h3>이메일 중복 확인</h3>
		<form method="post" action="mailCheckProc.jsp" onsubmit="return blankCheck(this)">
			<table class="writefrm">
				<tr>
					<th>이메일</th>
					<td><input type="text" name="email" id="email" size="30" maxlength="100" autofocus> <input type="submit" value="중복확인"></td>
				</tr>
				<tr><td colspan="2"></td></tr>
				<tr>
					<td colspan="2"><input type="submit" value="이메일 사용" /> <input type="reset" value="취소" /></td>
				</tr>
			</table>
		</form>
	</div>
	
<script>
	function blankCheck(f){
		var email=f.email.value;
		email=email.trim();
		if(email.length<1){
			alert("이메일을 입력해주세요.");
			f.email.focus();
			return false;
		}
		if(email.length<8){
			alert("이메일은 최소 8자 이상 입력해주세요.");
			f.email.focus();
			return false;
		}else if(email.indexOf("@")==-1 || email.indexOf(".")==-1 || email.indexOf("@")>email.indexOf(".")){
			// 나중에 정규식으로 다듬기
			// 정규식 : /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			alert("이메일 형식이 올바르지 않습니다.");
			f.email.focus();
			return false;
		}
		return true;
	} // blankCheck() end
	
</script>

</body>
</html>