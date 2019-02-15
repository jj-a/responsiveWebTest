package net.member2;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;
import net.utility.MyAuthenticator;

public class FindPw implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		String id = req.getParameter("id").trim();
		String mname = req.getParameter("mname").trim();
		String tel = req.getParameter("tel").trim();
		String email = req.getParameter("email").trim();
		
		MemberDTO dto=new MemberDTO();
		dto.setId(id);
		dto.setMname(mname);
		dto.setTel(tel);
		dto.setEmail(email);

		// 입력정보 검사 및 임시비밀번호 생성
		MemberDAO dao=new MemberDAO();
		dto = dao.findPW(dto);
		
		if(dto!=null) {
			
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
			//System.out.println("메일 서버 인증 성공");

			try {
				
				// 메일 발송
				req.setCharacterEncoding("UTF-8");
				String from = "admin@is.me";
				String subject = "* * JINA * * 임시 비밀번호";
				String mailcontent = "";

				// 메일 내용			
				mailcontent += "<h4>비밀번호 찾기 결과</h4>";
				mailcontent += "<p>임시비밀번호 : " + dto.getPasswd()+"</p>";
				mailcontent += "<h6>보안을 위해 로그인 후 반드시 비밀번호 변경을 해주세요.</h6>";
				mailcontent += "<p><a href='http://172.16.10.9:9090/myweb/member2/loginform.do'>홈페이지 이동</a></p>";
				
				// 수신자
				InternetAddress address[] = { new InternetAddress(email) };

				MimeMessage msg = new MimeMessage(se);

				msg.setRecipients(Message.RecipientType.TO, address); // 수신인
				msg.setFrom(new InternetAddress(from, "JINA")); // 발신인
				msg.setSubject(subject); // 제목
				msg.setContent(mailcontent, "text/html; charset=UTF-8"); // 내용
				msg.setSentDate(new Date()); // 보낸 날짜

				// 메일 발송
				Transport.send(msg);

				req.setAttribute("isSend", new Boolean(true));
				req.setAttribute("email", email);
				
			} catch (Exception e) {
				System.out.println("메일 발송 실패");
				req.setAttribute("isSend", new Boolean(false));
			} // try~catch end
			
		} // if(dto!=null) end
		
		return "findPw.jsp";
		
	} // requestPro() end

}
