package net.bbs2;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class BbsUpdate implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {

		int num=Integer.parseInt(req.getParameter("num"));	// 글번호
		String pageNum=req.getParameter("pageNum");	// 페이지번호
		
		BoardDTO article=new BoardDTO();
		article.setNum(Integer.parseInt(req.getParameter("num")));
		article.setWriter(req.getParameter("writer"));
		article.setEmail(req.getParameter("email"));
		article.setSubject(req.getParameter("subject"));
		article.setContent(req.getParameter("content"));
		article.setPasswd(req.getParameter("passwd"));
		article.setReg_date(new Timestamp(System.currentTimeMillis()));
		article.setIp(req.getRemoteAddr());
		
		BoardDAO dao=new BoardDAO();
		int res=dao.updateArticle(article);	// update 수행

		req.setAttribute("num", new Integer(num));
		req.setAttribute("pageNum",new Integer(pageNum));
		req.setAttribute("res", new Integer(res));
		
		return "updateProc.jsp";
		
	} // requestPro() end

}
