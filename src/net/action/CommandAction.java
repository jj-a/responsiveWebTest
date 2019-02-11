package net.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 요청 파라미터로 명령어를 전달하는 방식의 Super Interface
public interface CommandAction {

	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable;
	// 추상 메소드
	
}
