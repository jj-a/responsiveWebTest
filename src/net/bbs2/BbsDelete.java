package net.bbs2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class BbsDelete implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {

		int num=Integer.parseInt(req.getParameter("num"));	// 글번호
		String pageNum=req.getParameter("pageNum");	// 페이지번호
		String ip=req.getRemoteAddr(); // 클라이언트 PC의 IP
		boolean isAdmin=ip.equals("127.0.0.1") || ip.equals("0:0:0:0:0:0:0:1");
		
		int res;
		if(!isAdmin) {
			res=-1;
		}else {
			// 관리자일 때만 삭제 기능
			BoardDTO article=new BoardDTO();
			article.setNum(Integer.parseInt(req.getParameter("num")));
			article.setPasswd(req.getParameter("passwd").trim());
			
			BoardDAO dao=new BoardDAO();
			res=dao.deleteArticle(article);	// delete 수행
		}
		
		req.setAttribute("num", new Integer(num));
		req.setAttribute("pageNum", new Integer(pageNum));
		req.setAttribute("res", new Integer(res));	// query 성공여부
		req.setAttribute("isAdmin", new Boolean(isAdmin));
		req.setAttribute("action", "삭제");
		
		return "bbsRedirect.jsp";	// deleteProc.jsp
		
	} // requestPro() end

}
