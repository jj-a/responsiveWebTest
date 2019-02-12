package net.bbs2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class BbsPwCheck implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		int num=Integer.parseInt(req.getParameter("num"));	// 글번호
		String pageNum=req.getParameter("pageNum");	// 페이지번호
		// 이동하려는 페이지 (수정:bbsmodiform/삭제:bbsdelete)
		String page=req.getParameter("page");	
		
		BoardDAO dao=new BoardDAO();
		
		BoardDTO article=dao.getArticle(num);
		
		req.setAttribute("num", new Integer(num));
		req.setAttribute("pageNum",new Integer(pageNum));
		req.setAttribute("page",new String(page));
		req.setAttribute("article", article);
		
		return "bbsCheck.jsp";
		
	} // requestPro() end

}
