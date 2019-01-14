package web.tool; 

public class Paging { 
  /** 
   * ���� ������ ����¡, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *  
   * @param totalRecord ��ü ���ڵ�� 
   * @param nowPage     ���� ������
   * @param recordPerPage �������� ���ڵ� ��
   * @param col �˻� �÷�  
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  public String paging1(int totalRecord, int nowPage, int recordPerPage, String col, String word){ 
    int pagePerBlock = 10; // ���� ������ �� 
    int totalPage = (int)(Math.ceil((double)totalRecord/recordPerPage));// ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/pagePerBlock));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/pagePerBlock));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * pagePerBlock);             // Ư�� �׷��� ������ ��� ����   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:underline; background-color: #ffffff; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
     
    int _nowPage = (nowGrp-1) * pagePerBlock; // 10�� ���� �������� �̵� 
    if (nowGrp >= 2){ 
      str.append("[<A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>����</A>]"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ // ���� �������̸� ���� ȿ�� 
        str.append("<span style='font-size: 1.2em; font-weight: bold;'>"+i+"</span> ");   
      }else{ 
        str.append("<A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+i+"'>"+i+"</A> "); 
      } 
       
    } 
     
    _nowPage = (nowGrp * pagePerBlock)+1; // 10�� ���� �������� �̵� 
    if (nowGrp < totalGrp){ 
      str.append("[<A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>����</A>]"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  } 
   
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *  
   * @param totalRecord ��ü ���ڵ�� 
   * @param nowPage     ���� ������ 
   * @param recordPerPage �������� ���ڵ� �� 
   * @param col �˻� �÷�  
   * @param word �˻���
   * @return Box ��� ����¡ ���� ���ڿ�
   */ 
  public String paging2(int totalRecord, int nowPage, int recordPerPage, String col, String word){ 
    int pagePerBlock = 10; // ���� ������ �� 
    int totalPage = (int)(Math.ceil((double)totalRecord/recordPerPage)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/pagePerBlock));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/pagePerBlock));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * pagePerBlock);             // Ư�� �׷��� ������ ��� ����   
     
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
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{");
    str.append("    text-align: center;");    
    str.append("    background-color: #CCCCCC;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 

    int _nowPage = (nowGrp-1) * pagePerBlock; // 10�� ���� �������� �̵� 
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>����</A></span>"); 
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
     
    _nowPage = (nowGrp * pagePerBlock)+1; // 10�� ���� �������� �̵� 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  } 
   
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *  
   * @param totalRecord ��ü ���ڵ�� 
   * @param nowPage     ���� ������, 1���������� ����
   * @param recordPerPage �������� ���ڵ� ��
   * @param col �˻� �÷�  
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  public String paging3(int totalRecord, int nowPage, int recordPerPage, String col, String word){ 
    int pagePerBlock = 10; // ���� ������ �� 
    int totalPage = (int)(Math.ceil((double)totalRecord/recordPerPage)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/pagePerBlock));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/pagePerBlock));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * pagePerBlock);             // Ư�� �׷��� ������ ��� ����   
     
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
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 

    int _nowPage = (nowGrp-1) * pagePerBlock; // 10�� ���� �������� �̵� 
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>���� 10 ��</A></span>"); 
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
     
    _nowPage = (nowGrp * pagePerBlock)+1; // 10�� ���� �������� �̵� 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>���� 10 ��</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  } 

  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param listFile ��� ���ϸ�
   * @param totalRecord ��ü ���ڵ�� 
   * @param nowPage     ���� ������
   * @param recordPerPage �������� ���ڵ� ��
   * @param col �˻� �÷�  
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  public String paging4(String listFile, int totalRecord, int nowPage, int recordPerPage, String col, String word){ 
    int pagePerBlock = 10; // ���� ������ �� 
    int totalPage = (int)(Math.ceil((double)totalRecord/recordPerPage)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/pagePerBlock));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/pagePerBlock));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * pagePerBlock);             // Ư�� �׷��� ������ ��� ����   
     
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
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 

    int _nowPage = (nowGrp-1) * pagePerBlock; // 10�� ���� �������� �̵� 
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./"+listFile+"?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>����</A></span>"); 
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
     
    _nowPage = (nowGrp * pagePerBlock)+1; // 10�� ���� �������� �̵� 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./"+listFile+"?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  } 
  
} 


