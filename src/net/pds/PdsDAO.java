package net.pds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.utility.DBClose;
import net.utility.DBOpen;
import net.utility.Utility;

public class PdsDAO {

	// -- Object

	private DBOpen dbopen = null;
	private DBClose dbclose = null;

	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;

	// -- Constructor

	public PdsDAO() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}

	// -- Method
	//////////////////////////////////////////////

	public boolean insert(PdsDTO dto) {

		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append("INSERT INTO tb_pds(pdsno, wname, subject, passwd, filename, filesize, regdate) ");
			sql.append("VALUES((SELECT NVL(MAX(pdsno),0)+1 FROM tb_pds), ?, ?, ?, ?, ?, SYSDATE) ");

			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setString(4, dto.getFilename());
			pstmt.setLong(5, dto.getFilesize());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 추가를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		if (res == 0)
			return false;
		else
			return true;

	} // insert() end ////////////////////////////////////////////

	public synchronized ArrayList<PdsDTO> list() {

		ArrayList<PdsDTO> list = null;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append("SELECT pdsno, wname, subject, regdate, passwd, readcnt, filename, filesize ");
			sql.append("FROM tb_pds ");
			sql.append("ORDER BY pdsno DESC ");

			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList<PdsDTO>();
				do {

					PdsDTO dto = new PdsDTO(); // 한줄 저장
					dto.setPdsno(rs.getInt("pdsno"));
					dto.setWname(rs.getString("wname"));
					dto.setSubject(rs.getString("subject"));
					dto.setRegdate(rs.getString("regdate"));
					dto.setPasswd(rs.getString("passwd"));
					dto.setReadcnt(rs.getInt("readcnt"));
					dto.setFilename(rs.getString("filename"));
					dto.setFilesize(rs.getLong("filesize"));
					list.add(dto);

				} while (rs.next());
			} else {
				throw new Exception("rs.next()가 제대로 동작하지 않습니다. " + "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 자료 조회를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return list;

	} // list() end ////////////////////////////////////////////

	public PdsDTO read(int pdsno) {

		PdsDTO dto = null;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append("SELECT pdsno, wname, subject, regdate, passwd, readcnt, filename, filesize ");
			sql.append("FROM tb_pds ");
			sql.append("WHERE pdsno=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new PdsDTO();
				dto.setPdsno(rs.getInt("pdsno"));
				dto.setWname(rs.getString("wname"));
				dto.setSubject(rs.getString("subject"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setReadcnt(rs.getInt("readcnt"));
				dto.setFilename(rs.getString("filename"));
				dto.setFilesize(rs.getLong("filesize"));

			} else {
				throw new Exception("rs.next()가 제대로 동작하지 않습니다. " + "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 상세 보기를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return dto;

	} // read() end ////////////////////////////////////////////

	public int incrementCnt(int pdsno) {
		// readcnt(조회수) 증가

		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("UPDATE tb_pds ");
			sql.append("SET readcnt=readcnt+1 ");
			sql.append("WHERE pdsno=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 조회수 증가에 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} //incrementCnt() end ////////////////////////////////////////////

	public PdsDTO update(PdsDTO dto) {

		try {

			con = dbopen.getConnection();

			sql = new StringBuilder();
			sql.append("SELECT pdsno, wname, subject, regdate, passwd, filename, filesize ");
			sql.append("FROM tb_pds ");
			sql.append("WHERE pdsno=?AND passwd=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getPdsno());
			pstmt.setString(2, dto.getPasswd());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new PdsDTO();
				dto.setPdsno(rs.getInt("pdsno"));
				dto.setWname(rs.getString("wname"));
				dto.setSubject(rs.getString("subject"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setFilename(rs.getString("filename"));
				dto.setRegdate(rs.getString("regdate"));
			} else {
				dto = null;
				throw new Exception("rs.next()가 제대로 동작하지 않습니다. " + "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 수정할 자료가 존재하지 않거나 비밀번호 오류입니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return dto;

	} // update() end ////////////////////////////////////////////

	
	public int updateProc(PdsDTO dto) {	// 수정 (파일수정X)

		int res = 0;

		try {
			
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("UPDATE tb_pds ");
			sql.append("SET wname=?, subject=?, passwd=?, regdate=sysdate ");
			sql.append("WHERE pdsno=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setInt(4, dto.getPdsno());
                   
			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 수정을 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;
	} // updateProc() end ////////////////////////////////////////////


	
	public int updateProc(PdsDTO dto, String saveDir) {	// 수정 (파일수정O)

		int res = 0;

		try {

			String filename = "";
			PdsDTO oldDTO = read(dto.getPdsno());
			if (oldDTO != null) {
				filename = oldDTO.getFilename();
			}
			
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("UPDATE tb_pds ");
			sql.append("SET wname=?, subject=?, passwd=?, filename=?, filesize=?, regdate=sysdate ");
			sql.append("WHERE pdsno=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setString(4, dto.getFilename());
			pstmt.setLong(5, dto.getFilesize());
			pstmt.setInt(6, dto.getPdsno());

			res = pstmt.executeUpdate();

			if (res == 1) {
				// 테이블에서 레코드가 성공적으로 삭제되면 서버 로컬 경로의 첨부파일도 삭제됨
				Utility.deleteFile(saveDir, filename);
			} else {
				throw new Exception("삭제할 파일을 찾을 수 없습니다.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 행 수정을 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;
	} // updateProc() end ////////////////////////////////////////////
	
	
	
	public int delete(int pdsno, String passwd, String saveDir) {

		int res = 0;

		try {
			String filename = "";
			PdsDTO oldDTO = read(pdsno);
			if (oldDTO != null) {
				filename = oldDTO.getFilename();
			}

			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append("DELETE FROM tb_pds ");
			sql.append("WHERE pdsno=?AND passwd=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			pstmt.setString(2, passwd);

			res = pstmt.executeUpdate();

			if (res == 1) {
				// 테이블에서 레코드가 성공적으로 삭제되면 서버 로컬 경로의 첨부파일도 삭제됨
				Utility.deleteFile(saveDir, filename);
			} else {
				throw new Exception("삭제할 파일을 찾을 수 없습니다.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 행 삭제를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // delete() end ////////////////////////////////////////////

}
