package net.utility;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MyAuthenticator extends Authenticator {
	// 사용하고자 하는 메일서버에서 인증받은 계정/비밀번호
	
	private PasswordAuthentication pwauth;

	public MyAuthenticator() {
		pwauth=new PasswordAuthentication("soldesk@pretyimo.cafe24.com","soldesk6901");
		
	}

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return pwauth;
	}
	
	
	
}
