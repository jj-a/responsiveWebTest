package net.bbs;

import net.utility.DBOpen;

import java.sql.*;
import java.util.ArrayList;
import java.io.*;

import net.utility.DBClose;

public class BbsDAO {
	
	// -- Object
	private DBOpen dbopen=null;
	private DBClose dbclose=null;
	
	private Connection con=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	private StringBuilder sql=null;
	
	
	// -- Constructor
	public BbsDAO() {
		dbopen=new DBOpen();
		dbclose=new DBClose();
	}
	
	
	// -- Method
	
	public int insert(BbsDTO dto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append("INSERT INTO tb_bbs(bbsno,wname,subject,content,passwd,grpno,ip) ");
			sql.append(" VALUES(bbsno_seq.nextval,?,?,?,?,(SELECT NVL(MAX(bbsno),0)+1 FROM tb_bbs),?) ");

			/*
		INSERT INTO tb_bbs(bbsno,wname,subject,content,passwd,grpno,ip) 
		VALUES(bbsno_seq.nextval,'김용택','달이 떴다고 전화를 주시다니요','달이 떴다고 전화를 주시다니요  이 밤 너무 신나고 근사해요  (후략)','1234',( 
			SELECT nvl(MAX(bbsno),0)+1 FROM tb_bbs 
			),'127.0.0.1') 
		;
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

	} // insert() end
	

	public ArrayList<BbsDTO> list() {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = null;
		ArrayList<BbsDTO> list = null;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip");
			sql.append(" FROM tb_bbs");
			sql.append(" ORDER BY bbsno DESC");

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
					dto.setGrpno(rs.getInt("grpno"));
					dto.setIp(rs.getString("ip"));
					dto.setRegdt(rs.getString("regdt"));
					list.add(dto);

				} while (rs.next());
			}

		} catch (Exception e) {
			System.out.println("*Error* 자료 조회를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return list;

	} // list() end
	
	

	public BbsDTO read(int bbsno) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = null;
		BbsDTO dto = null;

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
				dto.setGrpno(rs.getInt("grpno"));
				dto.setRegdt(rs.getString("regdt"));
				dto.setIp(rs.getString("readcnt"));
				dto.setIp(rs.getString("ansnum"));
				dto.setIp(rs.getString("ip"));

			}

		} catch (Exception e) {
			System.out.println("*Error* 상세 보기를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return dto;

	} // read() end
	
	
	
}
