package net.bbs2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class BbsDelete implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {

		int num=Integer.parseInt(req.getParameter("num"));	// 글번호
		String pageNum=req.getParameter("pageNum");	// 페이지번호

		BoardDTO article=new BoardDTO();
		article.setNum(Integer.parseInt(req.getParameter("num")));
		article.setPasswd(req.getParameter("passwd").trim());
		
		BoardDAO dao=new BoardDAO();
		int res=dao.deleteArticle(article);	// delete 수행
		
		req.setAttribute("num", new Integer(num));
		req.setAttribute("pageNum",new Integer(pageNum));
		req.setAttribute("res",new Integer(res));	// query 성공여부
		
		return "deleteProc.jsp";
		
	} // requestPro() end

}
