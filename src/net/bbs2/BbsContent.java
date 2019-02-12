package net.bbs2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class BbsContent implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		int num=Integer.parseInt(req.getParameter("num"));	// 글번호
		String pageNum=req.getParameter("pageNum");	// 페이지번호
		
		BoardDAO dao=new BoardDAO();
		
		BoardDTO article=dao.getArticle(num);
		
		req.setAttribute("num", new Integer(num));
		req.setAttribute("pageNum",new Integer(pageNum));
		req.setAttribute("article", article);
		
		return "bbsContent.jsp";
		
	} // requestPro() end

}
