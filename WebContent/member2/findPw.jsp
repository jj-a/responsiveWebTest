<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%@ include file="../header.jsp"%>

<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Session"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="javax.mail.PasswordAuthentication"%>

<!-- Contents -->

<h3>비밀번호 찾기</h3>

<%
	if (!(s_id.equals("guest") || s_passwd.equals("guest") || s_mlevel.equals("E1"))) {
		// 비회원이 아닌 경우
%>
<script>
	alert("로그인한 상태에선 비밀번호 찾기를 할 수 없습니다.");
	location.href = "${pageContext.request.contextPath}/member/loginForm.jsp";
</script>
<%
	} else {
		
%>
		<table border="1" class="writefrm">
			<tr>
				<td colspan="2">비밀번호 찾기 결과</td>
			</tr>
<%

		String id = request.getParameter("id").trim();
		String mname = request.getParameter("mname").trim();
		String tel = request.getParameter("tel").trim();
		String email = request.getParameter("email").trim();
		
		dto.setId(id);
		dto.setMname(mname);
		dto.setTel(tel);
		dto.setEmail(email);

		// 입력정보 검사 및 임시비밀번호 생성
		dto = dao.findPW(dto);

		if (dto == null) {
			// 아이디와 입력정보가 일치하지 않는 경우
			%>
				<tr>
					<td colspan="2">입력정보가 일치하지 않습니다.</td>
				</tr>
			<%
		} else {
			////메일발송////

			// Mail Server (POP3/SMTP) 지정
			String mailServer = "mw-002.cafe24.com";

			Properties props = new Properties();
			props.put("mail.smtp.host", mailServer);
			props.put("mail.smtp.auth", "true");

			// Mail Server에서 인증받은 계정/비밀번호
			Authenticator myAuth = new MyAuthenticator();

			// 유효성 검증
			Session se = Session.getInstance(props, myAuth);
			//out.print("<p>메일 서버 인증 성공</p>");

			try {
				// 메일 발송
				request.setCharacterEncoding("UTF-8");
				String from = "admin@is.me";
				String subject = "* * JINA * * 임시 비밀번호";
				String msgText = "";

				// 메일 내용			
				msgText += "<h4>비밀번호 찾기 결과</h4>";
				msgText += "<p>임시비밀번호 : " + dto.getPasswd()+"</p>";
				msgText += "<h6>보안을 위해 로그인 후 반드시 비밀번호 변경을 해주세요.</h6>";
				msgText += "<p><a href='http://172.16.10.9:9090/myweb/member/loginForm.jsp'>홈페이지 이동</a></p>";
				
				// 수신자
				InternetAddress address[] = { new InternetAddress(email) };

				MimeMessage msg = new MimeMessage(se);

				msg.setRecipients(Message.RecipientType.TO, address); // 수신인
				msg.setFrom(new InternetAddress(from, "JINA")); // 발신인
				msg.setSubject(subject); // 제목
				msg.setContent(msgText, "text/html; charset=UTF-8"); // 내용
				msg.setSentDate(new Date()); // 보낸 날짜

				// 메일 발송
				Transport.send(msg);
				
				%>
				<tr>
					<td colspan="2">입력하신 이메일로 임시비밀번호가 전송되었습니다.</td>
				</tr>
				<tr>
					<th>전송 이메일</th>
					<td><%=email%></td>
				</tr>
				<%

			} catch (Exception e) {
				out.println("<p>메일 전송 실패" + e + "</p>");
				out.println("<p><a href='javascript:history.back();'>[다시 시도]</a></p>");
			}

		}	// if(dto==null)~else end

	} // if~else 비회원검사 end
%>
				<tr>
					<td colspan="2">
					<input type="button" value="로그인" onclick="location.href='loginForm.jsp'">&nbsp;&nbsp; 
					<input type="button" value="뒤로가기" onclick="history.back()">
					</td>
				</tr>
			</table>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>