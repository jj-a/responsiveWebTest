<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>idCheckForm.jsp</title>
<%@ include file="../includeNewWin.jsp"%>
<style></style>
</head>
<body>

	<div>
		<h3>아이디 중복 확인</h3>
		<form method="post" action="idCheckProc.jsp" onsubmit="return blankCheck(this)">
			<table class="writefrm">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id" id="id" size="15" maxlength="10" autofocus> <input type="submit" value="ID중복확인"></td>
				</tr>
				<tr><td colspan="2"></td></tr>
				<tr>
					<td colspan="2"><input type="submit" value="아이디 사용" /> <input type="reset" value="취소" /></td>
				</tr>
			</table>
		</form>
	</div>
	
<script>
	function blankCheck(f){
		var id=f.id.value;
		id=id.trim();
		if(id.length<4){
			alert("아이디는 4글자 이상 가능합니다.");
			f.id.focus();
			return false;
		}
		return true;
	} // blankCheck() end
	
</script>

</body>
</html>