package web.tool;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.File;
import java.util.Date;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Tool {
  /**
   * 문자열의 길이가 length 보다 크면 "..." 을 표시하는 메소드
   * 
   * @param str 문자열
   * @param length 선별할 문자열 길이
   * @return
   */
  public static synchronized String textLength(String str, int length) {

    if (str != null) {
      if (str.length() > length) {
        str = str.substring(0, length) + "...";
      }
    } else {
      str = "";
    }

    return str;
  }

  
  /**
   * 마스터 계정인지 검사합니다.
   * @param request
   * @return true: 마스터 계정
   */
  public static synchronized boolean isMaster(HttpServletRequest request){
    boolean sw = false;
    
    HttpSession session = request.getSession();
    String act = (String)session.getAttribute("act");
    // System.out.println("--> Tool.java act: " + act);
    
    if (act != null){
      if (act.equals("M")){
        sw = true;
      }
    }
    return sw;
  }

  /**
   * 일반 관리자 계정인지 검사합니다.
   * @param request
   * @return true: 일반 관리자
   */
  public static synchronized boolean isAdmin(HttpServletRequest request){
    boolean sw = false;
    
    HttpSession session = request.getSession();
    String act = (String)session.getAttribute("act");
    
    if (act != null){
      if (act.equals("Y")){
        sw = true;
      }
    }
    return sw;
  }

  
  /**
   * 키를 조합합니다. 예) ABC + 현재시간: ABC1234567890123
   * @return
   */
  public static synchronized String key(){
    String code = "";
    
    //  ASCII: 65 ~ 90, (A ~ Z: 26자)
    Random rnd = new Random();
    int su = rnd.nextInt(26) + 65; // 0 ~ 25 --> 65 ~ 90
    // System.out.println((char)su);
    code = code + (char)su;
    
    su = rnd.nextInt(26) + 65; // 0 ~ 25 --> 65 ~ 90
    // System.out.println((char)su);
    code = code + (char)su;
    
    su = rnd.nextInt(26) + 65; // 0 ~ 25 --> 65 ~ 90
    // System.out.println((char)su);
    code = code + (char)su;

    code = code + new Date().getTime(); // 1000 = 1초
    // System.out.println("CODE: " + code); // CODE: XGL1449819012230 
    
    return code;
  }
 
  // 문자열을 null인지 검사하여 null 이면 ""으로 변환하여 리턴  
  public static synchronized String checkNull(String str){
    if (str == null){
      str = "";
    } else if (str.equals("null")){
      str = "";
    }
      
    return str;
  }
  
  /**
   * 이미지 사이즈를 변경하여 새로운 이미지를 생성합니다.
   <pre>
   사용예): Tool.imgResize(srcFile 객체, destFile 객체, 200, 150)
   </pre>
   * @param src 원본 이미지 파일
   * @param dest 생성되는 이미지 파일
   * @param width 생성될 이미지 너비
   * @param height 생성될 이미지 높이, ImageUtil.RATIO는 자동 비례 비율
   * @return 생성된 이미지 파일명 리턴, src.jpg -> dest.jpg
   */
  public static synchronized String imgResize(File src, File dest, int width,
      int height) {
    int RATIO = 0;
    int SAME = -1;

    Image srcImg = null;
    // 파일의 확장자 추출
    String name = src.getName().toLowerCase(); // 파일명 추출
    // 이미지 파일인지 검사
    if (name.endsWith("jpg") || name.endsWith("bmp") || name.endsWith("png")
        || name.endsWith("gif")) {
      try {
        srcImg = ImageIO.read(src); // 메모리에 원본 이미지 생성
        int srcWidth = srcImg.getWidth(null); // 원본 이미지 너비 추출
        int srcHeight = srcImg.getHeight(null); // 원본 이미지 높이 추출
        int destWidth = -1, destHeight = -1; // 대상 이미지 크기 초기화

        if (width == SAME) { // width가 같은 경우
          destWidth = srcWidth;
        } else if (width > 0) {
          destWidth = width; // 새로운 width를 할당
        }

        if (height == SAME) { // 높이가 같은 경우
          destHeight = srcHeight;
        } else if (height > 0) {
          destHeight = height; // 새로운 높이로 할당
        }

        // 비율에 따른 크기 계산
        if (width == RATIO && height == RATIO) {
          destWidth = srcWidth;
          destHeight = srcHeight;
        } else if (width == RATIO) {
          double ratio = ((double) destHeight) / ((double) srcHeight);
          destWidth = (int) ((double) srcWidth * ratio);
        } else if (height == RATIO) {
          double ratio = ((double) destWidth) / ((double) srcWidth);
          destHeight = (int) ((double) srcHeight * ratio);
        }

        // 메모리에 대상 이미지 생성
        Image imgTarget = srcImg.getScaledInstance(destWidth, destHeight,
            Image.SCALE_SMOOTH);
        int pixels[] = new int[destWidth * destHeight];
        PixelGrabber pg = new PixelGrabber(imgTarget, 0, 0, destWidth,
            destHeight, pixels, 0, destWidth);

        pg.grabPixels();

        BufferedImage destImg = new BufferedImage(destWidth, destHeight,
            BufferedImage.TYPE_INT_RGB);
        destImg.setRGB(0, 0, destWidth, destHeight, pixels, 0, destWidth);

        // 파일에 기록
        ImageIO.write(destImg, "jpg", dest);

        System.out.println(dest.getName() + " 이미지를 생성했습니다.");
      } catch (Exception e) {
        e.printStackTrace();
      }

      name = dest.getName(); // 새로 생성된 파일명
    }

    return name;
  }

  /**
   * 이미지 사이즈를 변경하여 새로운 Preview 이미지를 생성합니다.
   <pre>
   사용예): Too.preview(folder 명, 원본 파일명, 200, 150)
   </pre>
   * @param upDir 원본 이미지 폴더
   * @param _src 원본 파일명
   * @param width 생성될 이미지 너비
   * @param height  생성될 이미지 높이, ImageUtil.RATIO는 자동 비례 비율
   * @return src.jpg 파일을 이용하여 src_t.jpg 파일을 생성하여 파일명 리턴
   */
  public static synchronized String preview(String upDir, String _src, int width,
      int height) {
    int RATIO = 0;
    int SAME = -1;

    File src = new File(upDir + "/" + _src); // 원본 파일 객체 생성
    String srcname = src.getName(); // 원본 파일명 추출

    // 순수 파일명 추출, mt.jpg -> mt 만 추출
    String _dest = srcname.substring(0, srcname.indexOf("."));

    // 축소 이미지 조합 /upDir/mt_t.jpg
    File dest = new File(upDir + "/" + _dest + "_t.jpg");

    Image srcImg = null;
    // 파일의 확장자 추출
    String name = src.getName().toLowerCase(); // 파일명 추출
    // 이미지 파일인지 검사
    if (name.endsWith("jpg") || name.endsWith("bmp") || name.endsWith("png")
        || name.endsWith("gif")) {
      try {
        srcImg = ImageIO.read(src); // 메모리에 원본 이미지 생성
        int srcWidth = srcImg.getWidth(null); // 원본 이미지 너비 추출
        int srcHeight = srcImg.getHeight(null); // 원본 이미지 높이 추출
        int destWidth = -1, destHeight = -1; // 대상 이미지 크기 초기화

        if (width == SAME) { // width가 같은 경우
          destWidth = srcWidth;
        } else if (width > 0) {
          destWidth = width; // 새로운 width를 할당
        }

        if (height == SAME) { // 높이가 같은 경우
          destHeight = srcHeight;
        } else if (height > 0) {
          destHeight = height; // 새로운 높이로 할당
        }

        // 비율에 따른 크기 계산
        if (width == RATIO && height == RATIO) {
          destWidth = srcWidth;
          destHeight = srcHeight;
        } else if (width == RATIO) {
          double ratio = ((double) destHeight) / ((double) srcHeight);
          destWidth = (int) ((double) srcWidth * ratio);
        } else if (height == RATIO) {
          double ratio = ((double) destWidth) / ((double) srcWidth);
          destHeight = (int) ((double) srcHeight * ratio);
        }

        // 메모리에 대상 이미지 생성
        Image imgTarget = srcImg.getScaledInstance(destWidth, destHeight,
            Image.SCALE_SMOOTH);
        int pixels[] = new int[destWidth * destHeight];
        PixelGrabber pg = new PixelGrabber(imgTarget, 0, 0, destWidth,
            destHeight, pixels, 0, destWidth);

        pg.grabPixels();

        BufferedImage destImg = new BufferedImage(destWidth, destHeight,
            BufferedImage.TYPE_INT_RGB);
        destImg.setRGB(0, 0, destWidth, destHeight, pixels, 0, destWidth);

        // 파일에 기록
        ImageIO.write(destImg, "jpg", dest);

        System.out.println(dest.getName() + " 이미지를 생성했습니다.");
      } catch (Exception e) {
        e.printStackTrace();
      }
    }

    return dest.getName();
  }

  /**
   * Youtube 이미지의 축소 출력
   * @param str 주소
   * @param width 변경할 너비
   * @param height 변경할 높이
   * @return
   */
  public static synchronized String youtube(String str, int width, int height) {
    int index1 = str.indexOf("\""); // 첫번째 문자 검색
    int index2 = str.indexOf("\"", index1 + 1); // 첫번째 이후부터 검색
    int index3 = str.indexOf("\"", index2 + 1); // 두번째 이후부터 검색
    int index4 = str.indexOf("\"", index3 + 1); // 세번째 이후부터 검색
    // System.out.println("--> index1: " + index1);
    // System.out.println("--> index2: " + index2);
    // System.out.println("--> index3: " + index3);
    // System.out.println("--> index4: " + index4);

    String str1 = str.substring(0, index1 + 1); // <iframe width='
    String str2 = str.substring(index2, index3 + 1); // ' height='
    String str3 = str.substring(index4); // ' src=이후의 모든 문자열
    String url = str1 + width + "px" + str2 + height + "px" + str3;

    // System.out.println("--> str1: " + str1);
    // System.out.println("--> str1: " + str2);
    // System.out.println("--> str1: " + str3);
    return url;
  }

  /**
   * 파일을 삭제합니다.
   */
  public static synchronized boolean deleteFile(String folder, String fileName) {
    boolean ret = false;

    try {
      if (fileName != null) { // 기존에 파일이 존재하는 경우 삭제
        File file = new File(folder + "/" + fileName);
        if (file.exists()) {
          ret = file.delete();
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    return ret;
  }

  /**
   * 파일 삭제
   * @param fname
   * @return
   */
  public static synchronized boolean deleteFile(String fname) {
    File file = new File(fname);
    boolean ret = false;
    
      if (file.exists()){
        ret = file.delete();
      }
    
    return ret;
  }
  
  /**
   * 파일이 이미지인지 검사합니다.
   * @param file 파일명
   * @return true: 이미지, false: 일반 파일
   */
  public static synchronized boolean isImage(String file) {
    boolean sw = false;
 
    if (file != null) {
      file = file.toLowerCase(); // 소문자
      if (file.endsWith(".jpg") || file.endsWith(".jpeg")
          || file.endsWith(".png") || file.endsWith(".gif")) {
        sw = true;
      }
    }
    return sw;
  }

  /**
   * 파일 용량의 단위를 추가합니다.
   * @param size 파일 크기
   * @return KB, MB, GB, TB
   */
  public static synchronized String unit(long size) {
    String str = "";
 
    if (size < (1024 * 1024)) { // 0 ~ 1048575, 1MB 보다 작은 경우
      str = (int) (Math.ceil(size / 1024.0)) + " KB";
    } else if (size < (1024 * 1024 * 1024)) { // 1 GB 보다 작은 경우
      str = (int) (Math.ceil(size / 1024.0 / 1024.0)) + " MB";
    } else if (size < (1024 * 1024 * 1024 * 1024)) { // 1 TB 보다 작은 경우
      str = (int) (Math.ceil(size / 1024.0 / 1024.0 / 1024.0)) + " GB";
    } else {
      str = (int) (Math.ceil(size / 1024.0 / 1024.0 / 1024.0 / 1024.0)) + " TB";
    }
 
    return str;
  }
  
  /**
   * 문자열을 지정된 길이로 짤라냅니다.
   * 
   * @param str
   * @param length
   * @return
   */
  public static synchronized String trim(String str, int length) {
    String _str = "";

    if (str != null) { // 문자열이 있다면
      if (str.length() > length) { // 문자열의 길이를 검사
        _str = str.substring(0, length) + "..."; // 지정된 길이의 문자만 추출
      } else {
        _str = str; // 원판 그대로 사용
      }
    } else {
      _str = "";
    }

    return _str;
  }

  /**
   * 특수문자를 코드로 변환합니다. static: 객체를 만들지않고 호출가능합니다. synchronized: 동시 접속을 순차접속으로
   * 변환합니다.
   */
  public static synchronized String convertChar(String str) {
    str = str.replaceAll("<", "&lt;");
    str = str.replaceAll(">", "&gt;");
    str = str.replaceAll("'", "&#39;");
    str = str.replaceAll("\"", "&quot;");
    str = str.replaceAll("\r\n", "<BR>");
 
    return str;
  }
  
  /**
   * 폴더를 입력받아 절대 경로를 산출합니다. 
   * 예) getRealPath(request, "/media/storage")
   * 
   * @param request
   * @param dir 절대 경로를 구할 폴더명
   * @return 절대 경로 리턴
   * @throws IOException
   */
  public static synchronized String getRealPath(HttpServletRequest request, String dir) {
    String path = "";
    
    try{
      path = request.getRealPath(dir) + "/";  
      // System.out.println("Upload path: " + path);
    }catch(Exception e){
      System.out.println(e.toString());
    }

    return path;
  }
  
}


