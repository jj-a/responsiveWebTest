package web.tool; 

public class Paging { 
  /** 
   * 숫자 형태의 페이징, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *  
   * @param totalRecord 전체 레코드수 
   * @param nowPage     현재 페이지
   * @param recordPerPage 페이지당 레코드 수
   * @param col 검색 컬럼  
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  public String paging1(int totalRecord, int nowPage, int recordPerPage, String col, String word){ 
    int pagePerBlock = 10; // 블럭당 페이지 수 
    int totalPage = (int)(Math.ceil((double)totalRecord/recordPerPage));// 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/pagePerBlock));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/pagePerBlock));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * pagePerBlock);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:underline; background-color: #ffffff; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
     
    int _nowPage = (nowGrp-1) * pagePerBlock; // 10개 이전 페이지로 이동 
    if (nowGrp >= 2){ 
      str.append("[<A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>이전</A>]"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ // 현재 페이지이면 강조 효과 
        str.append("<span style='font-size: 1.2em; font-weight: bold;'>"+i+"</span> ");   
      }else{ 
        str.append("<A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+i+"'>"+i+"</A> "); 
      } 
       
    } 
     
    _nowPage = (nowGrp * pagePerBlock)+1; // 10개 다음 페이지로 이동 
    if (nowGrp < totalGrp){ 
      str.append("[<A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>다음</A>]"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  } 
   
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *  
   * @param totalRecord 전체 레코드수 
   * @param nowPage     현재 페이지 
   * @param recordPerPage 페이지당 레코드 수 
   * @param col 검색 컬럼  
   * @param word 검색어
   * @return Box 모양 페이징 생성 문자열
   */ 
  public String paging2(int totalRecord, int nowPage, int recordPerPage, String col, String word){ 
    int pagePerBlock = 10; // 블럭당 페이지 수 
    int totalPage = (int)(Math.ceil((double)totalRecord/recordPerPage)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/pagePerBlock));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/pagePerBlock));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * pagePerBlock);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{");
    str.append("    text-align: center;");    
    str.append("    background-color: #CCCCCC;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 

    int _nowPage = (nowGrp-1) * pagePerBlock; // 10개 이전 페이지로 이동 
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>이전</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); 
      }else{ 
        str.append("<span class='span_box_1'><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
      } 
    } 
     
    _nowPage = (nowGrp * pagePerBlock)+1; // 10개 다음 페이지로 이동 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  } 
   
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *  
   * @param totalRecord 전체 레코드수 
   * @param nowPage     현재 페이지, 1페이지부터 시작
   * @param recordPerPage 페이지당 레코드 수
   * @param col 검색 컬럼  
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  public String paging3(int totalRecord, int nowPage, int recordPerPage, String col, String word){ 
    int pagePerBlock = 10; // 블럭당 페이지 수 
    int totalPage = (int)(Math.ceil((double)totalRecord/recordPerPage)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/pagePerBlock));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/pagePerBlock));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * pagePerBlock);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 

    int _nowPage = (nowGrp-1) * pagePerBlock; // 10개 이전 페이지로 이동 
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>이전 10 개</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); 
      }else{ 
        str.append("<span class='span_box_1'><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
      } 
    } 
     
    _nowPage = (nowGrp * pagePerBlock)+1; // 10개 다음 페이지로 이동 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>다음 10 개</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  } 

  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param listFile 목록 파일명
   * @param totalRecord 전체 레코드수 
   * @param nowPage     현재 페이지
   * @param recordPerPage 페이지당 레코드 수
   * @param col 검색 컬럼  
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  public String paging4(String listFile, int totalRecord, int nowPage, int recordPerPage, String col, String word){ 
    int pagePerBlock = 10; // 블럭당 페이지 수 
    int totalPage = (int)(Math.ceil((double)totalRecord/recordPerPage)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/pagePerBlock));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/pagePerBlock));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * pagePerBlock);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 

    int _nowPage = (nowGrp-1) * pagePerBlock; // 10개 이전 페이지로 이동 
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./"+listFile+"?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>이전</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); 
      }else{ 
        str.append("<span class='span_box_1'><A href='./"+listFile+"?col="+col+"&word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
      } 
    } 
     
    _nowPage = (nowGrp * pagePerBlock)+1; // 10개 다음 페이지로 이동 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./"+listFile+"?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  } 
  
} 


