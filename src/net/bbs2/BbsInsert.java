package net.bbs2;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class BbsInsert implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {

		String pageNum=req.getParameter("pageNum");
		if(pageNum==null) pageNum="1";
		
		BoardDTO article=new BoardDTO();
		article.setNum(Integer.parseInt(req.getParameter("num")));
		article.setWriter(req.getParameter("writer"));
		article.setEmail(req.getParameter("email"));
		article.setSubject(req.getParameter("subject"));
		article.setContent(req.getParameter("content"));
		article.setPasswd(req.getParameter("passwd"));
		article.setReg_date(new Timestamp(System.currentTimeMillis()));
		article.setRef(Integer.parseInt(req.getParameter("ref")));
		article.setRe_step(Integer.parseInt(req.getParameter("re_step")));
		article.setRe_level(Integer.parseInt(req.getParameter("re_level")));
		article.setIp(req.getRemoteAddr());
		
		BoardDAO dao=new BoardDAO();
		int res=dao.insertArticle(article);
		
		req.setAttribute("pageNum", new Integer(pageNum));
		req.setAttribute("res", new Integer(res));	// query 성공여부
		req.setAttribute("action", "등록");
		
		return "bbsRedirect.jsp";	// insertProc.jsp
		
	} // requestPro() end

}
