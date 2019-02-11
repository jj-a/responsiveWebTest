package net.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Index implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		return "index.jsp";
	}

}
