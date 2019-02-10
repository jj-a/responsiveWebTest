package net.notice;

import net.utility.DBOpen;
import net.utility.DBClose;

import java.sql.*;
import java.util.ArrayList;

public class NoticeDAO {

	// -- Object

	private DBOpen dbopen = null;
	private DBClose dbclose = null;

	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;

	
	// -- Constructor

	public NoticeDAO() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}

	
	// -- Method
	//////////////////////////////////////////////

	
	public int insert(NoticeDTO dto) {
		
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append("INSERT INTO tb_notice(noticeno, subject, content) ");
			sql.append("VALUES((SELECT NVL(MAX(noticeno),0)+1 FROM tb_notice), ?, ?) ");

			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 추가를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // insert() end ////////////////////////////////////////////

	
	
	public synchronized ArrayList<NoticeDTO> list() {
		
		ArrayList<NoticeDTO> list = null;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			
			sql.append("SELECT noticeno, subject, content, regdt ");
			sql.append("FROM tb_notice ");
			sql.append("ORDER BY noticeno DESC ");

			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				list = new ArrayList<>();
				do {

					NoticeDTO dto = new NoticeDTO(); // 한줄 저장
					dto.setNoticeno(rs.getInt("noticeno"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setContent(rs.getString("regdt"));
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

	
	
	public synchronized ArrayList<NoticeDTO> list(String col, String word) {
		
		ArrayList<NoticeDTO> list = null;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			
			sql.append("SELECT noticeno, subject, content, regdt ");
			sql.append("FROM tb_notice ");

			if (word.length() >= 1) { // 검색어 유무 확인
				String search = "";
				if (col.equals("subject"))
					search += "WHERE subject LIKE '%" + word + "%' ";
				else if (col.equals("content"))
					search += "WHERE content LIKE '%" + word + "%' ";
				else if (col.equals("subj_cont"))
					search += "WHERE subject LIKE '%" + word + "%' OR content LIKE '%" + word + "%' ";
				sql.append(search);
			}

			sql.append("ORDER BY noticeno DESC ");

			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<>();
				do {

					NoticeDTO dto = new NoticeDTO(); // 한줄 저장
					dto.setNoticeno(rs.getInt("noticeno"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setRegdt(rs.getString("regdt"));
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

	} // list(col,word) end ////////////////////////////////////////////

	
	
	public ArrayList<NoticeDTO> list(String col, String word, int nowPage, int recordPerPage) {
		
		ArrayList<NoticeDTO> list = null;

		// 10: 페이지당 출력할 레코드 갯수
		int startRow = ((nowPage - 1) * recordPerPage) + 1; // (0 * 10) + 1 = 1, 11, 21
		int endRow = nowPage * recordPerPage; // 1 * 10 = 10, 20, 30

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			word = word.trim(); // 문자열 좌우 공백 제거

			if (word.length() == 0) { // 검색을 안하는 경우
				sql.append("SELECT  noticeno, subject, content, regdt, rnum ");
				sql.append("FROM ( ");
				sql.append("SELECT noticeno, subject, content, regdt, rownum as rnum ");
				sql.append("FROM ( ");
				sql.append("SELECT noticeno, subject, content, regdt ");
				sql.append("FROM tb_notice ");
				sql.append("ORDER BY noticeno DESC ");
				sql.append(") ");
				sql.append(") ");
				sql.append("WHERE rnum >= " + startRow + " AND rnum <= " + endRow+" ");

				pstmt = con.prepareStatement(sql.toString());

			} else { // 검색을 하는 경우
				sql.append("SELECT  noticeno, subject, content, regdt, rnum ");
				sql.append("FROM (");
				sql.append("SELECT  noticeno, subject, content, regdt, rownum as rnum ");
				sql.append("FROM ( ");
				sql.append("SELECT  noticeno, subject, content, regdt ");
				sql.append("FROM tb_notice ");

				//검색
				if (word.length() >= 1) {
					String search = " WHERE " + col + " LIKE '%" + word + "%' ";
					sql.append(search);
				}

				sql.append("ORDER BY noticeno DESC ");
				sql.append(") ");
				sql.append(") ");
				sql.append("WHERE rnum >= " + startRow + " AND rnum <= " + endRow + " ");

				pstmt = con.prepareStatement(sql.toString());

			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<NoticeDTO>();
				NoticeDTO dto = null; //레코드 1개보관
				do {
					dto = new NoticeDTO();
					dto.setNoticeno(rs.getInt("noticeno"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setRegdt(rs.getString("regdt"));
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

	} // list(col,word,nowPage,recordPerPage) end ////////////////////////////////////////////
	
	
	
	public int count(String col, String word) {
		// 글수 확인 (전체글수/검색글수)

		int cnt = 0;

		try {
			con = dbopen.getConnection();

			sql = new StringBuilder();
			sql.append("SELECT COUNT(*) AS cnt ");
			sql.append("FROM tb_notice ");

			if (word.length() >= 1) { // 검색어 유무 확인
				String search = "";
				if (col.equals("subject"))
					search += "WHERE subject LIKE '%" + word + "%' ";
				else if (col.equals("content"))
					search += "WHERE content LIKE '%" + word + "%' ";
				else if (col.equals("subj_cont"))
					search += "WHERE subject LIKE '%" + word + "%' OR content LIKE '%" + word + "%' ";
				//search+="AND indent=0 ";	//	*** Comment.jsp에서 답글 숨기기 조건 --list에서는 안보이게
				sql.append(search);
			}

			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				cnt = rs.getInt("cnt");
			} else {
				throw new Exception("rs.next()가 제대로 동작하지 않습니다. " + "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 글수 카운트를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return cnt;
	} // count() end ////////////////////////////////////////////

	
	
	public String ipConvent(String ip) {
		// IP리스트 / 아이피리스트

		String iplist[] = { "127.0.0.1", "172.16.10.253", "172.16.10.100", "172.16.10.6", "172.16.10.8", "172.16.10.16",
				"172.16.10.22", "172.16.10.3", "172.16.10.10", "172.16.10.20" };
		String name[] = { "Admin", "Mobile", "강사님", "장민수", "누리누리", "계석준", "나기범", "이경화", "임소연", "박찬석" };
		String ipname = ip;

		for (int i = 0; i < iplist.length; i++) {
			if (ip.equals(iplist[i])) {
				ipname = name[i];
				break;
			}
		}

		return ipname;

	} // ipConvent() end ////////////////////////////////////////////

	
	
	public void ipCheck(String ip) { // ip 확인 (방문자 확인, 방문수 체크용)
		System.out.print("방문자 IP Check중... ");
		System.out.println("IP: " + ip);

	} // ipConvent() end ////////////////////////////////////////////

	
	
	public String ipCheck(String ip, String page) {
		System.out.println("IP: " + ip + " / 방문 페이지: " + page);
		return ip;
	} // ipConvent() end ////////////////////////////////////////////

	
	
	public NoticeDTO read(int noticeno) {
		
		NoticeDTO dto = null;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append("SELECT noticeno, subject, content, regdt ");
			sql.append("FROM tb_notice ");
			sql.append("WHERE noticeno=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, noticeno);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new NoticeDTO();
				dto.setNoticeno(rs.getInt("noticeno"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setRegdt(rs.getString("regdt"));

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

	
	
	public NoticeDTO update(NoticeDTO dto) {

		try {
			
			con = dbopen.getConnection();
			sql = new StringBuilder();
			
			sql.append("SELECT noticeno, subject, content, regdt ");
			sql.append("FROM tb_notice ");
			sql.append("WHERE noticeno=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getNoticeno());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new NoticeDTO();
				dto.setNoticeno(rs.getInt("noticeno"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setRegdt(rs.getString("regdt"));
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

	
	
	public int updateProc(NoticeDTO dto) {

		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append("UPDATE tb_notice ");
			sql.append("SET subject=?, content=?, regdt=sysdate ");
			sql.append("WHERE noticeno=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNoticeno());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 수정을 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;
	} // updateProc() end ////////////////////////////////////////////

	
	
	public int delete(NoticeDTO dto) {
		
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append("DELETE FROM tb_notice ");
			sql.append("WHERE noticeno=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getNoticeno());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 삭제를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // delete() end ////////////////////////////////////////////
	
	

	public int delete(String selectNoticeno[]) {
		// 관리자페이지에서 글 삭제 (다중삭제)

		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			
			// Query 작성
			String sqlstr="";
			sqlstr+="DELETE FROM tb_notice ";
			sqlstr+="WHERE noticeno IN(";
			sqlstr+=selectNoticeno[0];
			for(int i=1;i<selectNoticeno.length;i++) {
				sqlstr=sqlstr+", "+selectNoticeno[i];	// checkbox에서 받은 값 꺼내오기
			}
			sqlstr+=") ";
			
			sql.append(sqlstr);
			
			pstmt = con.prepareStatement(sql.toString());
			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 삭제를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // delete() end ////////////////////////////////////////////
	


	public int adjustOrder(String selectNoticeno[]) {
		// 관리자페이지에서 글 순서 조정

		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			
			// Query 작성
			String sqlstr="";
			sqlstr+="DELETE FROM tb_notice ";
			sqlstr+="WHERE noticeno IN(";
			sqlstr+=selectNoticeno[0];
			for(int i=1;i<selectNoticeno.length;i++) {
				sqlstr=sqlstr+", "+selectNoticeno[i];	// checkbox에서 받은 값 꺼내오기
			}
			sqlstr+=") ";
			
			sql.append(sqlstr);
			
			pstmt = con.prepareStatement(sql.toString());
			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 삭제를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // adjustOrder() end ////////////////////////////////////////////
	

	

}
