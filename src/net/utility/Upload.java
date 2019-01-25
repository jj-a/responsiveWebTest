package net.utility;

import java.io.*;
import java.sql.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/////////////////////////////// 수정중 ///////////////////////////////////////

public class Upload {

	// -- Object

	private DBOpen dbopen = null;
	private DBClose dbclose = null;

	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;

	// -- Constructor

	public Upload() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}

	// -- Method

	public boolean uploadFile(HttpServletRequest req) {

		boolean b = false;

		try {

			String uploadDir = req.getServletContext().getRealPath("upload"); //절대 경로

			//			String uploadDir = "D:/java_1113/workspace/soldesk/WebContent/images"; 유닉스방식

			MultipartRequest multi = new MultipartRequest(req, uploadDir, 5 * 1024 * 1024, "utf-8",
					new DefaultFileRenamePolicy());

			//MultipartRequest(request객체, 업로드할 절대경로, 파일크기, 인코딩방식, 보안관련)

			con = dbopen.getConnection();

			String sql = "INSERT INTO upload_file VALUES(,?,?,?,SYSDATE,?,?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, multi.getParameter("uname"));
			pstmt.setString(2, multi.getParameter("subject"));
			pstmt.setString(3, multi.getParameter("content"));
			pstmt.setString(4, multi.getParameter("filenm"));

			if (multi.getFilesystemName("image") == null) {
				pstmt.setString(5, "ready.gif");
			} else {
				pstmt.setString(5, multi.getFilesystemName("image")); //이미지 경로를 insert할 경우			
			}
			if (pstmt.executeUpdate() > 0) {
				b = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				;
			}
		}

		return b;

	} // uploadFile() end

}
