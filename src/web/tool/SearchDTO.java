package web.tool;

/**
 * 검색과 페이징을 위한 DTO
 * @author soldesk
 *
 */
public class SearchDTO {
  /** 검색 컬럼, 초기값을 ""으로 지정 */
  private String col = "";
  
  /** 검색어, 초기값을 ""으로 지정 */
  private String word = "";
  
  /** 현재 페이지: 1부터 시작 */
  private int nowPage = 1;

  public String getCol() {
    return col;
  }

  public void setCol(String col) {
    this.col = col;
  }

  public String getWord() {
    return word;
  }

  public void setWord(String word) {
    this.word = word;
  }

  public int getNowPage() {
    return nowPage;
  }

  public void setNowPage(int nowPage) {
    this.nowPage = nowPage;
  }

  
}
