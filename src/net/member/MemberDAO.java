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
			sql.append("SET mname=?, tel=?, email=?, zipcode=?, address1=?, address2=?, job=? ");
			if(dto.getPasswd()==null) {	// passwd 수정할 시
				sql.append(", passwd=? ");
			}
			sql.append("WHERE id=? ");

			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getMname());
			pstmt.setString(2, dto.getTel());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getZipcode());
			pstmt.setString(5, dto.getAddress1());
			pstmt.setString(6, dto.getAddress2());
			pstmt.setString(7, dto.getJob());
			if(dto.getPasswd()==null) {	// passwd 수정할 시
				pstmt.setString(8, dto.getPasswd());
				pstmt.setString(9, dto.getId());
			}
			else{	// 수정안할 시
				pstmt.setString(8, dto.getId());
			}

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 수정을 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // modifyProc() end ////////////////////////////////////////////
	
	
	public MemberDTO findID(MemberDTO dto) {
		
		MemberDTO member=null;

		try {

			con = dbopen.getConnection();

			sql = new StringBuilder();
			sql.append("SELECT id FROM member ");
			sql.append("WHERE mname=? AND tel=? AND email=? AND mlevel IN('A1','B1','C1','D1', 'X1') ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getMname());
			pstmt.setString(2, dto.getTel());
			pstmt.setString(3, dto.getEmail());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member=new MemberDTO();
				member.setId(rs.getString("id"));
			} else {
				throw new Exception("회원이 아니거나 회원등급이 적절하지 않습니다.");
			}

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return member;

	} // findID() end ////////////////////////////////////////////
	
	
	
	public MemberDTO findPW(MemberDTO dto) {

		MemberDTO member=null;
		int res = 0;
		String temppasswd="";

		try {

			temppasswd=randomPW();

			con = dbopen.getConnection();
			sql = new StringBuilder();
			
			sql.append("UPDATE member ");
			sql.append("SET passwd=? ");
			sql.append("WHERE id=? AND mname=? AND tel=? AND email=? AND mlevel IN('A1','B1','C1','D1','X1') ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, temppasswd);
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getMname());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getEmail());
			
			System.out.println("입력값 검사: "+dto.toString());
			
			res = pstmt.executeUpdate();

			if (res!=0) {
				member=new MemberDTO();
				member.setPasswd(temppasswd);
				System.out.println("비밀번호 변경 후:  "+member.toString());
			} else {
				System.out.println("입력된 회원정보가 일치하지 않습니다.");
			}

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return member;

	} // findID() end ////////////////////////////////////////////

	
	private String randomPW() {
	// 랜덤 비밀번호 (10자리) 생성
        int index = 0;  
        
        // charset 규정에 맞게 바꾸기
        char[] charSet = new char[] {  
                '0','1','2','3','4','5','6','7','8','9'  
                ,'A','B','C','D','E','F','G','H','I','J','K','L','M'  
                ,'N','O','P','Q','R','S','T','U','V','W','X','Y','Z'  
                ,'a','b','c','d','e','f','g','h','i','j','k','l','m'  
                ,'n','o','p','q','r','s','t','u','v','w','x','y','z'};  
          
        StringBuffer sb = new StringBuffer();  
        for (int i=0; i<10; i++) {  
            index=(int)(charSet.length * Math.random());  
            sb.append(charSet[index]);  
        }  
          
        return sb.toString();  
	} // randomPW() end ////////////////////////////////////////////
	
	
}
