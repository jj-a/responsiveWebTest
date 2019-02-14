<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${action} 중복 확인</title>
<%@ include file="../includeNewWin.jsp"%>
</head>
<body>

	<div>
		<h3>${action} 중복 확인</h3>
		<form method="post" action="" onsubmit="return blankCheck(this)">
		<input type="hidden" name="action" value="${action}">
			<table class="writefrm">
				<tr>
					<th>${action}</th>
					<td><input type="text" name="checkvalue" id="checkvalue" size="30" maxlength="100" autofocus> <input type="submit" value="${action} 중복확인"></td>
				</tr>
				<tr><td colspan="2"></td></tr>
				<tr>
					<td colspan="2"><input type="submit" value="${action} 사용" /> <input type="button" value="취소" onclick="window.close()"/></td>
				</tr>
			</table>
		</form>
	</div>
	
<script>
	function blankCheck(f) {

		var checkvalue = f.checkvalue.value.trim();
		
		<c:choose>
		<c:when test="${action=='아이디'}">
			// 아이디 체크
		
			if (checkvalue.length < 4) {
				alert("아이디는 4글자 이상 가능합니다.");
				f.checkvalue.focus();
				return false;
			}
			
			f.action = "idcheck.do";
			return true;
		</c:when>
		
		<c:when test="${action=='이메일'}">
			// 이메일 체크
		
			if (checkvalue.length < 1) {
				alert("이메일을 입력해주세요.");
				f.checkvalue.focus();
				return false;
			} else if (checkvalue.length < 8) {
				alert("이메일은 최소 8자 이상 입력해주세요.");
				f.checkvalue.focus();
				return false;
			} else if (checkvalue.indexOf("@") == -1 || checkvalue.indexOf(".") == -1 || checkvalue.indexOf("@") > checkvalue.indexOf(".")) {
				// 나중에 정규식으로 다듬기
				// 정규식 : /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
				alert("이메일 형식이 올바르지 않습니다.");
				f.checkvalue.focus();
				return false;
			}
		
			f.action = "mailcheck.do";
			return true;
		</c:when>
		</c:choose>
	
		return false;
	
	} // blankCheck() end
</script>

</body>
</html>