package web.tool;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

public class Log {
  public static synchronized void w(String str){
    String os = System.getProperty("os.name");
    String path = "";
    
    if (os.indexOf("Window") >= 0){
      path = "C:/secure1/ws_web/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/admin_v1jq/log";
    }else{
      path="/home/hosting_users/soldeskit/tomcat/webapps/ROOT/log";
    }
    String file = path + "/" + "log.txt"; // �α� ����
    String Enter = System.getProperty("line.separator"); // Enter
    FileWriter fw = null; // ���� ��� 
    
    try {
      fw = new FileWriter(file, true); // true: �߰� ���
      fw.write(new Date().toLocaleString() + Enter);
      fw.write(str + Enter);
      fw.write("-----------------------------------" + Enter);
      fw.flush();
    } catch (IOException e) {
      e.printStackTrace();
    } finally{
      try {
        fw.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }

  public static synchronized void w(HttpServletRequest request, String str){
    // /log ������ ��� ����
    String path = request.getServletContext().getRealPath("/log");
    String file = path + "/" + "log.txt"; // �α� ����
    System.out.println("file: " + file);
    String Enter = System.getProperty("line.separator"); // Enter
    FileWriter fw = null; // ���� ��� 
    
    try {
      fw = new FileWriter(file, true); // true: �߰� ���
      fw.write(new Date().toLocaleString() + Enter);
      fw.write(str + Enter);
      fw.write("-----------------------------------" + Enter);
      fw.flush();
    } catch (IOException e) {
      e.printStackTrace();
    } finally{
      try {
        fw.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }
  
  public static void main(String[] args) {
    // Ŭ������ ��ġ�ϴ� ���� ��� ����
    // String path = Log.class.getResource("").getPath();
    // System.out.println("--> path: " + path);
    // /C:/secure1/ws_web/admin_v1jq/build/classes/web/tool/
    
    // System.out.println(System.getProperty("os.name"));
    // Windows 7, Windows 10
    
    w("�ݿ��� JAVA ���� �α� �׽�Ʈ");
  }

}
