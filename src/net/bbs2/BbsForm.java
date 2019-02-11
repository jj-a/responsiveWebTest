package net.bbs2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class BbsForm implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		
		int num=0, ref=1, re_step=0, re_level=0;
		
		try {
			
			if(req.getParameter("num")!=null) {	// 부모글번호 존재여부 확인
				num=Integer.parseInt(req.getParameter("num"));
				ref=Integer.parseInt(req.getParameter("ref"));
				re_step=Integer.parseInt(req.getParameter("re_step"));
				re_level=Integer.parseInt(req.getParameter("re_level"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		req.setAttribute("num",new Integer(num));
		req.setAttribute("ref",new Integer(ref));
		req.setAttribute("re_step",new Integer(re_step));
		req.setAttribute("re_level",new Integer(re_level));
		
		return "bbsForm.jsp";
		
	} // requestPro() end

}
