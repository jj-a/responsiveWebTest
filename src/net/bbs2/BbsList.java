package net.bbs2;

import java.util.Collections;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;


public class BbsList implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {

		// 총 게시글 수 체크
		int total_cnt=0;
		BoardDAO dao=new BoardDAO();
		total_cnt=dao.getArticleCount();
		
		// 페이징
		int numPerPage=10;	// 한 페이지 당 레코드 개수
		int pagePerBlock=5;	// 페이지 리스트
		
		String pageNum=req.getParameter("pageNum");
		if(pageNum==null) pageNum="1";
		
		int currentPage=Integer.parseInt(pageNum);
		int startRow=(currentPage-1)*numPerPage+1;
		int endRow=currentPage*numPerPage;
		
		// 페이지 수
		double totcnt=(double)total_cnt/numPerPage;
		int totalPage=(int)Math.ceil(totcnt);
		
		double d_page=(double)currentPage/pagePerBlock;
		int Pages=(int)Math.ceil(d_page)-1;
		int startPage=Pages*pagePerBlock;
		int endPage=startPage+pagePerBlock+1;
		
		
		List<BoardDTO> articleList=null;
		// 형을 설정해주면 EMPTY_LIST가 경고뜨고 설정안하면 List가 경고뜨고.......
		
		if(total_cnt>0) {
			articleList=dao.getArticles(startRow, endRow);
		}else {
			articleList=Collections.EMPTY_LIST;	// 빈 리스트
		}
		
		int number=0;
		number=total_cnt-(currentPage-1)*numPerPage;
		
		// 값 세팅
		req.setAttribute("number",new Integer(number));
		req.setAttribute("pageNum",new Integer(pageNum));
		req.setAttribute("startRow",new Integer(startRow));
		req.setAttribute("endRow",new Integer(endRow));
		req.setAttribute("count",new Integer(total_cnt));
		req.setAttribute("pageSize",new Integer(pagePerBlock));
		req.setAttribute("totalPage",new Integer(totalPage));
		req.setAttribute("startPage",new Integer(startPage));
		req.setAttribute("endPage",new Integer(endPage));
		req.setAttribute("articleList",articleList);
		
		return "bbsList.jsp";
		
	} // requestPro() end

}
