<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="net.utility.*"%>

<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Session"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="javax.mail.PasswordAuthentication"%>

<%@ include file="../header.jsp"%>

<!-- Contents -->

<h3>문의 메일 전송</h3>

<%
	// Mail Server (POP3/SMTP) 지정
	String mailServer = "mw-002.cafe24.com";

	Properties props = new Properties();
	props.put("mail.smtp.host", mailServer);
	props.put("mail.smtp.auth", "true");

	// Mail Server에서 인증받은 계정/비밀번호
	Authenticator myAuth = new MyAuthenticator();

	// 유효성 검증
	Session se = Session.getInstance(props, myAuth);
	out.print("<p>메일 서버 인증 성공</p>");
	
	try{
		// 메일 발송
		request.setCharacterEncoding("UTF-8");
		String to=request.getParameter("to").trim();
		String from=request.getParameter("from").trim();
		String subject=request.getParameter("subject").trim();
		String msgText=request.getParameter("msgText").trim();
		
		// 엔터 및 특수문자 변환
		msgText=Utility.convertChar(msgText);
		
		// 테이블 보여주기
		msgText+="<table border=1>";
		msgText+="<tr><th>기종</th><td>PC</td></tr>";
		msgText+="<tr><th>문의 내용</th><td>테스트를 합니다,,</td></tr>";
		msgText+="</table>";

		// 이미지 보여주기
		msgText+="<p><img src='http://172.16.10.9:9090/myweb/images/001.gif'></p>";
		
		// 수신자
		InternetAddress address[]={new InternetAddress(to)};
		// 수신인이 다수일 경우
		//InternetAddress address[]={new InternetAddress(to1), new InternetAddress(to2), new InternetAddress(to3)};
		
		MimeMessage msg=new MimeMessage(se);
			
		msg.setRecipients(Message.RecipientType.TO, address);	// 수신인
		msg.setFrom(new InternetAddress(from));	// 발신인
		msg.setSubject(subject);	// 제목
		msg.setContent(msgText,"text/html; charset=UTF-8");	// 내용
		msg.setSentDate(new Date());	// 보낸 날짜

		// 메일 발송
		Transport.send(msg);
		out.println("<p>"+to+" 님에게 메일이 발송되었습니다.</p>");
		
		
	}catch(Exception e){
		out.println("<p>메일 전송 실패"+e+"</p>");
		out.println("<p><a href='javascript:history.back();'>[다시 시도]</a></p>");
	}


%>

<!-- Contents end -->

<%@ include file="../footer.jsp"%>
