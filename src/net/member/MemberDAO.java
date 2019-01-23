package net.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import net.utility.DBClose;
import net.utility.DBOpen;


public class MemberDAO {

	// -- Object

	private DBOpen dbopen = null;
	private DBClose dbclose = null;

	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;

	// -- Constructor

	public MemberDAO() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}

	// -- Method
	//////////////////////////////////////////////

	public int duplecateID(String id) {

		int cnt = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("SELECT COUNT(id) cnt FROM member ");
			sql.append("WHERE id=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				cnt = rs.getInt("cnt");
			} else {
				throw new Exception("rs.next()가 제대로 동작하지 않습니다. " + "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 아이디 중복 조회를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return cnt;
	} // duplecateID() end

	public int duplecateMail(String email) {

		int cnt = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("SELECT COUNT(email) cnt FROM member ");
			sql.append("WHERE email=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				cnt = rs.getInt("cnt");
			} else {
				throw new Exception("rs.next()가 제대로 동작하지 않습니다. " + "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 아이디 중복 조회를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return cnt;
	} // duplecateID() end

	public int join(MemberDTO dto) {

		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append("INSERT INTO member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate) ");
			sql.append("VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, 'D1', sysdate) ");

			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			pstmt.setString(3, dto.getMname());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getZipcode());
			pstmt.setString(7, dto.getAddress1());
			pstmt.setString(8, dto.getAddress2());
			pstmt.setString(9, dto.getJob());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 추가를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // join() end

	
	
	public String login(MemberDTO dto) {
		
		String mlevel=null;
		
		try {

			con = dbopen.getConnection();

			sql = new StringBuilder();
			sql.append("SELECT mlevel FROM member ");
			sql.append("WHERE id=? AND passwd=? AND mlevel IN('A1','B1','C1','D1') ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				mlevel=rs.getString("mlevel");
			} else {
				throw new Exception("회원이 아니거나 회원등급이 적절하지 않거나 아이디/비밀번호 오류입니다.");
			}

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return mlevel;

	} // login() end

	/*		// 작성중
	
	public String login(MemberDTO dto) {
		
		String mlevel=null;
		
		try {

			con = dbopen.getConnection();
			sql = new StringBuilder();
			
			sql.append("SELECT mlevel FROM member ");
			sql.append("WHERE id=? AND passwd=? AND mlevel IN('A1','B1','C1','D1') ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				mlevel=rs.getString("mlevel");
			} else {
				throw new Exception("회원이 아니거나 회원등급이 적절하지 않거나 아이디/비밀번호 오류입니다.");
			}

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return mlevel;

	} // login() end
	
	*/
	
	
}
