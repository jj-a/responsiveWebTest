package web.tool;

/**
 * �˻��� ����¡�� ���� DTO
 * @author soldesk
 *
 */
public class SearchDTO {
  /** �˻� �÷�, �ʱⰪ�� ""���� ���� */
  private String col = "";
  
  /** �˻���, �ʱⰪ�� ""���� ���� */
  private String word = "";
  
  /** ���� ������: 1���� ���� */
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
