package net.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	} // duplecateID() end ////////////////////////////////////////////

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
	} // duplecateID() end ////////////////////////////////////////////

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

	} // join() end ////////////////////////////////////////////

	public String login(MemberDTO dto) {

		String mlevel = null;

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
				mlevel = rs.getString("mlevel");
			} else {
				throw new Exception("회원이 아니거나 회원등급이 적절하지 않거나 아이디/비밀번호 오류입니다.");
			}

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return mlevel;

	} // login() end ////////////////////////////////////////////

	/*
	 * // 작성중
	 * 
	 * public String login(MemberDTO dto) {
	 * 
	 * String mlevel=null;
	 * 
	 * try {
	 * 
	 * con = dbopen.getConnection(); sql = new StringBuilder();
	 * 
	 * sql.append("SELECT mlevel FROM member "); sql.append("WHERE id=? AND passwd=? AND mlevel IN('A1','B1','C1','D1') ");
	 * 
	 * pstmt = con.prepareStatement(sql.toString()); pstmt.setString(1, dto.getId()); pstmt.setString(2, dto.getPasswd()); rs =
	 * pstmt.executeQuery();
	 * 
	 * if (rs.next()) { mlevel=rs.getString("mlevel"); } else { throw new Exception("회원이 아니거나 회원등급이 적절하지 않거나 아이디/비밀번호 오류입니다."); }
	 * 
	 * } catch (Exception e) { System.out.println(e); } finally { dbclose.close(con, pstmt, rs); }
	 * 
	 * return mlevel;
	 * 
	 * } // login() end ////////////////////////////////////////////
	 * 
	 */

	public int recordCount() { // 회원수 카운트

		int cnt = 0;

		try {

			con = dbopen.getConnection();

			sql = new StringBuilder();
			sql.append("SELECT COUNT(id) AS cnt FROM member ");

			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}

		} catch (Exception e) {
			System.out.println("*Error* 알 수 없는 오류 : " + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return cnt;

	} // recordCount() end ////////////////////////////////////////////

	public synchronized ArrayList<MemberDTO> list(String col) {

		ArrayList<MemberDTO> list = null;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("SELECT id, passwd, mname, tel, email, mdate, mlevel ");
			sql.append("FROM member ");

			// 정렬 설정 (ID/이름/가입일 순)
			if (col.equals("") || col.equals("id")) {
				sql.append("ORDER BY id ASC ");
			} else if (col.equals("mname")) {
				sql.append("ORDER BY mname ASC ");
			} else if (col.equals("mdate")) {
				sql.append("ORDER BY mdate DESC ");
			}

			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList<>();
				do {

					MemberDTO dto = new MemberDTO();
					dto.setId(rs.getString("id"));
					dto.setPasswd(rs.getString("passwd"));
					dto.setMname(rs.getString("mname"));
					dto.setTel(rs.getString("tel"));
					dto.setEmail(rs.getString("email"));
					dto.setMdate(rs.getString("mdate"));
					dto.setMlevel(rs.getString("mlevel"));
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

	
	
	public int levelChange(String id, String mlevel) {

		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("UPDATE member ");
			sql.append("SET mlevel=? ");
			sql.append("WHERE id=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, mlevel);
			pstmt.setString(2, id);

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 수정을 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // levelChange() end ////////////////////////////////////////////

	
	
	public int delete(String id) {

		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("DELETE FROM member ");
			sql.append("WHERE id=? AND mlevel IN('F1','X1') ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 삭제를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // delete() end ////////////////////////////////////////////

	
	
	public MemberDTO modify(String id) {

		MemberDTO dto = new MemberDTO();

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("SELECT id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate ");
			sql.append("FROM member ");
			sql.append("WHERE id=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setMname(rs.getString("mname"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setJob(rs.getString("job"));
				dto.setMdate(rs.getString("mdate"));

			} else {
				throw new Exception("rs.next()가 제대로 동작하지 않습니다. " + "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 자료 조회를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return dto;

	} // modify() end ////////////////////////////////////////////
	
	

	public int modifyProc(MemberDTO dto) {

		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("UPDATE member ");
			sql.append("SET passwd=?, mname=?, tel=?, email=?, zipcode=?, address1=?, address2=?, job=? ");
			sql.append("WHERE id=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getPasswd());
			pstmt.setString(2, dto.getMname());
			pstmt.setString(3, dto.getTel());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getZipcode());
			pstmt.setString(6, dto.getAddress1());
			pstmt.setString(7, dto.getAddress2());
			pstmt.setString(8, dto.getJob());
			pstmt.setString(9, dto.getId());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 수정을 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // modifyProc() end ////////////////////////////////////////////

	
	
}
