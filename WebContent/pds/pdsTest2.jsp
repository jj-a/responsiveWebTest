<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>pdsTest2.jsp</title>
</head>
<body style="margin: 0 auto; text-align:center;">
	<h3>파일 첨부 테스트 (다중파일)</h3>
	<form action="pdsTestProc2.jsp" method="post" enctype="multipart/form-data">
	<!-- multipart/form-data : post방식으로만 전송 가능 -->
		<table style="border: 1px solid #cccccc; padding: 10px; margin: 0 auto; text-align:center;">
			<tr>
				<td>이름:</td>
				<td><input type="text" name="uname" size="18"></td>
			</tr>
			<tr>
				<td>제목:</td>
				<td><input type="text" name="subject" size="18"></td>
			</tr>
			<tr>
				<td>내용:</td>
				<td><textarea rows="5" cols="20" name="content" style="resize:none;"></textarea></td>
			</tr>
			<tr>
				<td>첨부파일①:</td>
				<td><input type="file" name="filenm3"></td>
			</tr>
			<tr>
				<td>첨부파일②:</td>
				<td><input type="file" name="filenm2"></td>
			</tr>
			<tr>
				<td>첨부파일③:</td>
				<td><input type="file" name="filenm1"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="전송"></td>
			</tr>
		</table>
	</form>


</body>
</html>