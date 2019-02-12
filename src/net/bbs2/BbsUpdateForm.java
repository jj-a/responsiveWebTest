package net.bbs2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class BbsUpdateForm implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		int num=Integer.parseInt(req.getParameter("num"));	// 글번호
		String pageNum=req.getParameter("pageNum");	// 페이지번호

		BoardDTO article=new BoardDTO();
		article.setNum(Integer.parseInt(req.getParameter("num")));
		article.setPasswd(req.getParameter("passwd").trim());

		BoardDAO dao=new BoardDAO();
		article=dao.loadArticle(article);
		
		req.setAttribute("num",new Integer(num));
		req.setAttribute("pageNum",new Integer(pageNum));
		req.setAttribute("article", article);
		
		return "bbsUpdate.jsp";
		
	} // requestPro() end

}
