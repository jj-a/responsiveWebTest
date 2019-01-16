package net.bbs;

import net.utility.DBOpen;
import net.utility.DBClose;

import java.sql.*;
import java.util.ArrayList;


public class BbsDAO {

	
	// -- Object
	
	private DBOpen dbopen = null;
	private DBClose dbclose = null;

	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;

	
	// -- Constructor
	
	public BbsDAO() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}

	
	// -- Method
	//////////////////////////////////////////////
	
	public int insert(BbsDTO dto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append("INSERT INTO tb_bbs(bbsno,wname,subject,content,passwd,grpno,ip) ");
			sql.append(" VALUES(SELECT NVL(MAX(bbsno),0)+1 FROM tb_bbs),?,?,?,?,(SELECT NVL(MAX(bbsno),0)+1 FROM tb_bbs),?) ");

			/*
			 * INSERT INTO tb_bbs(bbsno,wname,subject,content,passwd,grpno,ip) VALUES(bbsno_seq.nextval,'김용택','달이 떴다고 전화를
			 * 주시다니요','달이 떴다고 전화를 주시다니요 이 밤 너무 신나고 근사해요 (후략)','1234',( SELECT nvl(MAX(bbsno),0)+1 FROM tb_bbs ),'127.0.0.1') ;
			 */

			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getIp());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 추가를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // insert() end ////////////////////////////////////////////

	
	public synchronized  ArrayList<BbsDTO> list() { 

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = null;
		ArrayList<BbsDTO> list = null;
		
		/*
		 * SELECT bbsno, wname, subject, readcnt, indent, regdt 
		 * FROM tb_bbs 
		 * ORDER BY grpno DESC, ansnum ASC ;
		 */

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip");
			sql.append(" FROM tb_bbs");
			sql.append(" ORDER BY grpno, indent, ansnum DESC");

			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList<>();
				do {

					BbsDTO dto = new BbsDTO(); // 한줄 저장
					dto.setBbsno(rs.getInt("bbsno"));
					dto.setWname(rs.getString("wname"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setPasswd(rs.getString("passwd"));
					dto.setReadcnt(rs.getInt("readcnt"));
					dto.setRegdt(rs.getString("regdt"));
					dto.setGrpno(rs.getInt("grpno"));
					dto.setIndent(rs.getInt("indent"));
					dto.setAnsnum(rs.getInt("ansnum"));
					dto.setIp(rs.getString("ip"));
					list.add(dto);

				} while (rs.next());
			}

		} catch (Exception e) {
			System.out.println("*Error* 자료 조회를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return list;

	} // list() end ////////////////////////////////////////////
	

	public BbsDTO read(int bbsno) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = null;
		BbsDTO dto = null;

		/*
		 * SELECT bbsno, wname, subject, content, readcnt, grpno, ip, regdt 
		 * FROM tb_bbs 
		 * WHERE bbsno=?
		 */

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip");
			sql.append(" FROM tb_bbs");
			sql.append(" WHERE bbsno=?");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setWname(rs.getString("wname"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setReadcnt(rs.getInt("readcnt"));
				dto.setRegdt(rs.getString("regdt"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
				dto.setIp(rs.getString("ip"));

			}

		} catch (Exception e) {
			System.out.println("*Error* 상세 보기를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return dto;

	} // read() end ////////////////////////////////////////////
	
	
	public int incrementCnt(int bbsno) {
		// readcnt(조회수) 증가
		
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		int res = 0;

		/*
		 * UPDATE tb_bbs 
		 * SET readcnt=readcnt+1 
		 * WHERE bbsno=?
		 */

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" UPDATE tb_bbs ");
			sql.append(" SET readcnt=readcnt+1 ");
			sql.append(" WHERE bbsno=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 조회수 증가에 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}
		
		return res;

	} //incrementCnt() end ////////////////////////////////////////////
	
	
	public int reply(BbsDTO dto) { 
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = null;
		*/
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			
			// 1) 부모글 정보 가져오기 (grpno, indent, ansnum)
			
			int grpno=0, indent=0, ansnum=0;
			sql.append("SELECT grpno, indent, ansnum ");
			sql.append("FROM tb_bbs ");
			sql.append("WHERE bbsno=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getBbsno());
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				grpno=rs.getInt("grpno");
				indent=rs.getInt("indent")+1;
				ansnum=rs.getInt("ansnum")+1;

				System.out.println(grpno);
				System.out.println(indent);
				System.out.println(ansnum);
			}
			else {
				System.out.println("rs.next가 없어염");
			}
			
			// 2) 글순서 재조정
			
			sql.delete(0,sql.length());	// 이전에 사용한 sql문 삭제
			sql.append("UPDATE tb_bbs ");
			sql.append("SET ansnum=ansnum+1 ");
			sql.append("WHERE grpno=? AND ansnum>=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);
			
			pstmt.executeUpdate();
			
			
			// 3) 답변글 추가

			sql.delete(0,sql.length());	// 이전에 사용한 sql문 삭제
			sql.append("INSERT INTO tb_bbs(bbsno,wname,subject,content,passwd,ip,grpno,indent,ansnum) ");
			sql.append(" VALUES((SELECT nvl(MAX(bbsno),0)+1 FROM tb_bbs),?,?,?,?,?,?,?,?) ");

			/*
			 * INSERT INTO tb_bbs(bbsno,wname,subject,content,passwd,grpno,indent,ansnum,ip)
			 * VALUES(bbsno_seq.nextval,?,?,?,?,(SELECT nvl(MAX(bbsno),0)+1 FROM tb_bbs)),?,?,?) ;
			 */

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getIp());
			pstmt.setInt(6, grpno);
			pstmt.setInt(7, indent);
			pstmt.setInt(8, ansnum);
			
			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 추가를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return res;
		
	} // reply() end ////////////////////////////////////////////
	
	
	public BbsDTO update(int bbsno) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = null;
		BbsDTO dto = null;

		try {

			con = dbopen.getConnection();

			sql = new StringBuilder();
			sql.append(" SELECT bbsno, wname, subject, content, passwd, ip, regdt");
			sql.append(" FROM tb_bbs");
			sql.append(" WHERE bbsno=?");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				dto = new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setWname(rs.getString("wname"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setIp(rs.getString("ip"));
				dto.setRegdt(rs.getString("regdt"));
			}

		} catch (Exception e) {
			System.out.println("*Error* 수정할 자료가 존재하지 않습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return dto;

	} // update() end ////////////////////////////////////////////
	

	public int updateProc(BbsDTO dto) {

		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" UPDATE tb_bbs ");
			sql.append(" SET wname=?, subject=?, content=?, passwd=?, regdt=sysdate ");
			sql.append(" WHERE bbsno=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getRegdt());
			pstmt.setInt(6, dto.getBbsno());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 수정을 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;
	} // updateProc() end ////////////////////////////////////////////


	
	public int delete(int bbsno) {

		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" DELETE FROM tb_bbs");
			sql.append(" WHERE bbsno=?");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 삭제를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // delete() end ////////////////////////////////////////////

	
	
}
