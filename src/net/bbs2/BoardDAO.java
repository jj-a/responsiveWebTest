package net.bbs2;

import net.utility.DBOpen;
import net.utility.DBClose;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;	// 지우기
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class BoardDAO {
	
	// -- Object
	
	private DBOpen dbopen = null;
	private DBClose dbclose = null;

	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;

	
	// -- Constructor
	
	public BoardDAO() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}
	
	
	// -- Method
	//////////////////////////////////////////////
	
	
	 //DBCP방식의 오라클 연결
	  private Connection getConnection() throws Exception{
	    Context initCtx=new InitialContext();
	    DataSource ds  =(DataSource)initCtx.lookup("java:comp/env/jdbc/oracle");
	    return ds.getConnection();
	  } // getConnection() end

	
	public int insert(BoardDTO dto) {
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		*/
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append("INSERT INTO board(num,writer,subject,content,passwd,ref,ip) ");
			sql.append("VALUES((SELECT NVL(MAX(num),0)+1 FROM board),?,?,?,?,(SELECT NVL(MAX(num),0)+1 FROM board),?) ");

			/*
			 * INSERT INTO board(num,writer,subject,content,passwd,ref,ip) VALUES(num_seq.nextval,'김용택','달이 떴다고 전화를
			 * 주시다니요','달이 떴다고 전화를 주시다니요 이 밤 너무 신나고 근사해요 (후략)','1234',( SELECT nvl(MAX(num),0)+1 FROM board ),'127.0.0.1') ;
			 */

			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getWriter());
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

	
	public synchronized  ArrayList<BoardDTO> list() { 
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = null;
		*/
		ArrayList<BoardDTO> list = null;
		
		/*
		 * SELECT num, writer, subject, readcount, re_level, reg_date 
		 * FROM board 
		 * ORDER BY ref DESC, re_step ASC ;
		 */

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("SELECT num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip ");
			sql.append("FROM board ");
			sql.append("ORDER BY ref DESC,re_level ASC, re_step ASC ");

			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList<>();
				do {

					BoardDTO dto = new BoardDTO(); // 한줄 저장
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setPasswd(rs.getString("passwd"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setReg_date(rs.getTimestamp("reg_date"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_level(rs.getInt("re_level"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setIp(rs.getString("ip"));
					list.add(dto);

				} while (rs.next());
			}
			else {
				 throw new Exception("rs.next()가 제대로 동작하지 않습니다. "
				 		+ "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 자료 조회를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return list;

	} // list() end ////////////////////////////////////////////
	
	

	public synchronized  ArrayList<BoardDTO> list(String col, String word) { 
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = null;
		*/
		ArrayList<BoardDTO> list = null;
		
		/*
		 * SELECT num, writer, subject, readcount, re_level, reg_date 
		 * FROM board 
		 * ORDER BY ref DESC, re_step ASC ;
		 */

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("SELECT num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip ");
			sql.append("FROM board ");

			if(word.length()>=1) {	// 검색어 유무 확인
				String search="";
				if(col.equals("writer")) search+="WHERE writer LIKE '%"+word+"%' ";
				else if(col.equals("subject")) search+="WHERE subject LIKE '%"+word+"%' ";
				else if(col.equals("content")) search+="WHERE content LIKE '%"+word+"%' ";
				else if(col.equals("subj_cont")) search+="WHERE subject LIKE '%"+word+"%' OR content LIKE '%"+word+"%' ";
				sql.append(search);
			}

			sql.append("ORDER BY ref DESC,re_level ASC, re_step ASC ");
			
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				list = new ArrayList<>();
				do {

					BoardDTO dto = new BoardDTO(); // 한줄 저장
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setPasswd(rs.getString("passwd"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setReg_date(rs.getTimestamp("reg_date"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_level(rs.getInt("re_level"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setIp(rs.getString("ip"));
					list.add(dto);

				} while (rs.next());
			}
			else {
				 throw new Exception("rs.next()가 제대로 동작하지 않습니다. "
				 		+ "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 자료 조회를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return list;

	} // list(col,word) end ////////////////////////////////////////////

	
	
	public ArrayList<BoardDTO> list(String col, String word, int nowPage, int recordPerPage) {
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		*/
		ArrayList<BoardDTO> list = null;

		// 10: 페이지당 출력할 레코드 갯수
		int startRow = ((nowPage - 1) * recordPerPage) + 1; // (0 * 10) + 1 = 1, 11, 21
		int endRow = nowPage * recordPerPage; // 1 * 10 = 10, 20, 30

		/*
		 * 1 page: WHERE r >= 1 AND r <= 10; 2 page: WHERE r >= 11 AND r <= 20; 3 page: WHERE r >= 21 AND r <= 30;
		 */

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			word = word.trim(); // 문자열 좌우 공백 제거

			if (word.length() == 0) { // 검색을 안하는 경우
				sql.append(" SELECT  num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip, rnum");
				sql.append(" FROM(");
				sql.append("      SELECT  num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip, rownum as rnum");
				sql.append("      FROM (");
				sql.append("           SELECT  num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip");
				sql.append("           FROM board ");
				//sql.append("           WHERE re_level=0 ");	//	*** Comment.jsp에서 답글 숨기기 조건 --list에서는 안보이게
				sql.append("           ORDER BY ref DESC, re_step ASC");
				sql.append("      )");
				sql.append(" )     ");
				sql.append(" WHERE rnum >= " + startRow + " AND rnum <= " + endRow);

				pstmt = con.prepareStatement(sql.toString());

			} else { // 검색을 하는 경우
				sql.append("SELECT  num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip, rnum ");
				sql.append("FROM(");
				sql.append("SELECT  num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip, rownum as rnum ");
				sql.append("FROM ( ");
				sql.append("SELECT  num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip ");
				sql.append("FROM board ");

				//검색
				if (word.length() >= 1) {
					String search = " WHERE " + col + " LIKE '%" + word + "%' ";
					sql.append(search);
					//sql.append("AND re_level=0 ");	//	*** Comment.jsp에서 답글 숨기기 조건 --list에서는 안보이게
				}

				sql.append("ORDER BY ref DESC, re_step ASC ");
				sql.append(") ");
				sql.append(") ");
				sql.append("WHERE rnum >= " + startRow + " AND rnum <= " + endRow+" ");

				pstmt = con.prepareStatement(sql.toString());

			}

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				list = new ArrayList<BoardDTO>();
				BoardDTO dto = null; //레코드 1개보관
				do {
					dto = new BoardDTO();
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setPasswd(rs.getString("passwd"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setReg_date(rs.getTimestamp("reg_date"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_level(rs.getInt("re_level"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setIp(rs.getString("ip"));
					list.add(dto);
				} while (rs.next());
			}
			else {
				 throw new Exception("rs.next()가 제대로 동작하지 않습니다. "
				 		+ "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 자료 조회를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return list;

	} // list(col,word,nowPage,recordPerPage) end ////////////////////////////////////////////

	
	
	public ArrayList<BoardDTO> cmtlist(String col, String word, int nowPage, int recordPerPage) {
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		*/
		ArrayList<BoardDTO> list = null;

		// 10: 페이지당 출력할 레코드 갯수
		int startRow = ((nowPage - 1) * recordPerPage) + 1; // (0 * 10) + 1 = 1, 11, 21
		int endRow = nowPage * recordPerPage; // 1 * 10 = 10, 20, 30

		/*
		 * 1 page: WHERE r >= 1 AND r <= 10; 2 page: WHERE r >= 11 AND r <= 20; 3 page: WHERE r >= 21 AND r <= 30;
		 */

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			
			/*

		-- rownum 순으로 페이징
		SELECT rnum, num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip
		FROM (
			-- rownum 번호 매기기
			SELECT num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip, rownum AS rnum
			FROM (
				-- CNT_TB & board 원본 join: 새글만 select
				SELECT TB.*, CNT_TB.cnt FROM (
					-- CNT_TB: ref별로 답글 count
					SELECT ref, COUNT(ref)-1 AS cnt FROM board 
					GROUP BY ref
				)CNT_TB  JOIN  board TB
				ON CNT_TB.ref=TB.ref 
				WHERE TB.re_level=0
				ORDER BY TB.ref DESC 
			)
		)
		WHERE rnum>=6 AND rnum<=10
		;
			 */
			
			word = word.trim(); // 문자열 좌우 공백 제거

			if (word.length() == 0) { // 검색을 안하는 경우
				//-- rownum 순으로 페이징
				sql.append(" SELECT  rnum, num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip, cnt ");
				sql.append(" FROM( ");
				//-- rownum 번호 매기기
				sql.append("SELECT  num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip, cnt, rownum AS rnum ");
				sql.append("FROM ( ");
				//-- CNT_TB & board 원본 join: 새글만 select
				sql.append("SELECT TB.*, CNT_TB.cnt FROM ( ");
				//-- CNT_TB: ref별로 답글 count
				sql.append("SELECT ref, COUNT(ref)-1 AS cnt FROM board ");
				sql.append("GROUP BY ref ");
				sql.append(")CNT_TB  JOIN  board TB ");
				sql.append("ON CNT_TB.ref=TB.ref ");
				sql.append("WHERE TB.re_level=0 ");
				sql.append("ORDER BY TB.ref DESC ");
				sql.append(") ");
				sql.append(" ) ");
				sql.append(" WHERE rnum >= " + startRow + " AND rnum <= " + endRow+" ");

				pstmt = con.prepareStatement(sql.toString());

			} else { // 검색을 하는 경우
				//-- rownum 순으로 페이징
				sql.append(" SELECT  rnum, num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip, cnt ");
				sql.append(" FROM( ");
				//-- rownum 번호 매기기
				sql.append("SELECT  num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip, cnt, rownum AS rnum ");
				sql.append("FROM ( ");
				//-- CNT_TB & board 원본 join: 새글만 select
				sql.append("SELECT TB.*, CNT_TB.cnt FROM ( ");
				//-- CNT_TB: ref별로 답글 count
				sql.append("SELECT ref, COUNT(ref)-1 AS cnt FROM board ");
				sql.append("GROUP BY ref ");
				sql.append(")CNT_TB  JOIN  board TB ");
				sql.append("ON CNT_TB.ref=TB.ref ");
				sql.append("WHERE TB.re_level=0 ");

				//검색
				if (word.length() >= 1) {
					sql.append(" AND " + col + " LIKE '%" + word + "%' ");
				}

				sql.append("ORDER BY TB.ref DESC ");
				sql.append(") ");
				sql.append(") ");
				sql.append("WHERE rnum >= " + startRow + " AND rnum <= " + endRow+" ");

				pstmt = con.prepareStatement(sql.toString());

			}

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				list = new ArrayList<BoardDTO>();
				BoardDTO dto = null; //레코드 1개보관
				do {
					dto = new BoardDTO();
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setPasswd(rs.getString("passwd"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setReg_date(rs.getTimestamp("reg_date"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_level(rs.getInt("re_level"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setIp(rs.getString("ip"));
					dto.setCnt(rs.getInt("cnt"));	// 답글수(댓글수)
					list.add(dto);
				} while (rs.next());
			}
			else {
				 throw new Exception("rs.next()가 제대로 동작하지 않습니다. "
				 		+ "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 자료 조회를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return list;

	} // cmtlist(col,word,nowPage,recordPerPage) end ////////////////////////////////////////////
	
	
	
	public int count(String col, String word) {
		// 글수 확인 (전체글수/검색글수)
		
		int cnt=0;
		
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append("SELECT COUNT(*) AS cnt ");
			sql.append("FROM board ");
			
			if(word.length()>=1) {	// 검색어 유무 확인
				String search="";
				if(col.equals("writer")) search+="WHERE writer LIKE '%"+word+"%' ";
				else if(col.equals("subject")) search+="WHERE subject LIKE '%"+word+"%' ";
				else if(col.equals("content")) search+="WHERE content LIKE '%"+word+"%' ";
				else if(col.equals("subj_cont")) search+="WHERE subject LIKE '%"+word+"%' OR content LIKE '%"+word+"%' ";
				//search+="AND re_level=0 ";	//	*** Comment.jsp에서 답글 숨기기 조건 --list에서는 안보이게
				sql.append(search);
			}
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				cnt=rs.getInt("cnt");
			}else {
				 throw new Exception("rs.next()가 제대로 동작하지 않습니다. "
					 		+ "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}
			
		}catch(Exception e) {
			System.out.println("*Error* 글수 카운트를 실패했습니다. \n" + e);
		}finally {
			dbclose.close(con, pstmt, rs);
		}
		
		return cnt;
	} // count() end ////////////////////////////////////////////
	

	
	
	
	public int cmtcount(String col, String word) {
		// 글수 확인 (전체글수/검색글수)
		
		int cnt=0;
		
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append("SELECT COUNT(*) AS cnt ");
			sql.append("FROM board ");
			sql.append("WHERE re_level=0 ");
			
			
			if(word.length()>=1) {	// 검색어 유무 확인
				String search="";
				if(col.equals("writer")) search+="AND writer LIKE '%"+word+"%' ";
				else if(col.equals("subject")) search+="AND subject LIKE '%"+word+"%' ";
				else if(col.equals("content")) search+="AND content LIKE '%"+word+"%' ";
				else if(col.equals("subj_cont")) search+="AND subject LIKE '%"+word+"%' OR content LIKE '%"+word+"%' ";
				//search+="AND re_level=0 ";	//	*** Comment.jsp에서 답글 숨기기 조건 --list에서는 안보이게
				sql.append(search);
			}
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				cnt=rs.getInt("cnt");
			}else {
				 throw new Exception("rs.next()가 제대로 동작하지 않습니다. "
					 		+ "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}
			
		}catch(Exception e) {
			System.out.println("*Error* 글수 카운트를 실패했습니다. \n" + e);
		}finally {
			dbclose.close(con, pstmt, rs);
		}
		
		return cnt;
	} // cmtcount() end ////////////////////////////////////////////
	
	
	
	public String ipConvent(String ip) {
		// IP리스트 / 아이피리스트
		
		String iplist[]= {"127.0.0.1", "0:0:0:0:0:0:0:1", "172.16.10.253", "172.16.10.100", "172.16.10.6", "172.16.10.8", "172.16.10.16", "172.16.10.22", "172.16.10.3", "172.16.10.10", "172.16.10.20"};
		String name[]= {"Admin", "Admin", "Mobile", "강사님", "장민수", "누리누리", "계석준", "나기범", "이경화", "임소연", "박찬석"};
		String ipname=ip;
		
		for(int i=0;i<iplist.length;i++) {
			if(ip.equals(iplist[i])) {
				ipname=name[i];
				break;
			}
		}
		
		return ipname;
		
	} // ipConvent() end ////////////////////////////////////////////
	
	
	public void ipCheck(String ip) {		// ip 확인 (방문자 확인, 방문수 체크용)
		System.out.print("방문자 IP Check중... ");
		System.out.println("IP: "+ip);
		
	} // ipConvent() end ////////////////////////////////////////////

	
	public String ipCheck(String ip, String page) {
		System.out.println("IP: "+ip+" / 방문 페이지: "+page);
		return ip;
	} // ipConvent() end ////////////////////////////////////////////

	
	public BoardDTO read(int num) {
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = null;
		*/
		BoardDTO dto = null;

		/*
		 * SELECT num, writer, subject, content, readcount, ref, ip, reg_date 
		 * FROM board 
		 * WHERE num=?
		 */

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			
			sql.append("SELECT num, writer, subject, content, passwd, readcount, reg_date, ref, re_level, re_step, ip ");
			sql.append("FROM board ");
			sql.append("WHERE num=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_level(rs.getInt("re_level"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setIp(rs.getString("ip"));

			}
			else {
				 throw new Exception("rs.next()가 제대로 동작하지 않습니다. "
				 		+ "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 상세 보기를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return dto;

	} // read() end ////////////////////////////////////////////
	
	
	
	public int replyCnt(int num) {	// 답글수 계산
		/*
		StringBuilder sql = null;
		*/
		int cnt = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			// 답글수 계산 (하는중)

			// 1) 현재 게시글의 ref, re_level, re_step 불러오기
			int ref = 0, re_level = 0, re_step = 0;
			sql.append("SELECT ref, re_level, re_step ");
			sql.append("FROM board ");
			sql.append("WHERE num=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				ref = rs.getInt("ref");
				re_level = rs.getInt("re_level");
				re_step = rs.getInt("re_step");

			} else {
				System.out.println("Error1 : 값이 없거나 오류");
			}

			// 2) 같은 그룹 게시물 중 re_level가 높은 글만 select
			sql.delete(0, sql.length());
			sql.append("SELECT COUNT(*) AS cnt  ");
			sql.append("FROM board ");
			sql.append("WHERE ref=? AND re_level>? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				cnt = rs.getInt("cnt");
			} else {
				System.out.println("Error2 : 값이 없거나 오류");
			}

			sql.delete(0, sql.length());
			// 여기까지 답글수 계산

		} catch (Exception e) {
			System.out.println("*Error* 답글수 확인을 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return cnt;

	} // replyCnt() end ////////////////////////////////////////////
	
	
	
	public int incrementCnt(int num) {
		// readcount(조회수) 증가
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		*/
		int res = 0;

		/*
		 * UPDATE board 
		 * SET readcount=readcount+1 
		 * WHERE num=?
		 */

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("UPDATE board ");
			sql.append("SET readcount=readcount+1 ");
			sql.append("WHERE num=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, num);
			
			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 조회수 증가에 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}
		
		return res;

	} //incrementCnt() end ////////////////////////////////////////////
	
	
	public int reply(BoardDTO dto) { 
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

			
			// 1) 부모글 정보 가져오기 (ref, re_level, re_step)
			
			int ref=0, re_level=0, re_step=0;
			sql.append("SELECT ref, re_level, re_step ");
			sql.append("FROM board ");
			sql.append("WHERE num=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getNum());
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				ref=rs.getInt("ref");
				re_level=rs.getInt("re_level")+1;
				re_step=rs.getInt("re_step")+1;

				System.out.println("전달값 확인: "+"ref="+ref+" re_level="+re_level+" re_step="+re_step);
				
			}
			else {
				 throw new Exception("rs.next()가 제대로 동작하지 않습니다. "
				 		+ "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}
			
			// 2) 글순서 재조정
			
			sql.delete(0,sql.length());	// 이전에 사용한 sql문 삭제
			sql.append("UPDATE board ");
			sql.append("SET re_step=re_step+1 ");
			sql.append("WHERE ref=? AND re_step>=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_step);
			
			pstmt.executeUpdate();
			
			
			// 3) 답변글 추가

			sql.delete(0,sql.length());	// 이전에 사용한 sql문 삭제
			sql.append("INSERT INTO board(num,writer,subject,content,passwd,ip,ref,re_level,re_step) ");
			sql.append("VALUES((SELECT nvl(MAX(num),0)+1 FROM board),?,?,?,?,?,?,?,?) ");

			/*
			 * INSERT INTO board(num,writer,subject,content,passwd,ref,re_level,re_step,ip)
			 * VALUES(num_seq.nextval,?,?,?,?,(SELECT nvl(MAX(num),0)+1 FROM board)),?,?,?) ;
			 */

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getIp());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, re_level);
			pstmt.setInt(8, re_step);
			
			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 추가를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return res;
		
	} // reply() end ////////////////////////////////////////////
	
	
	public BoardDTO update(BoardDTO dto) {
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = null;
		*/
		//BbsDTO dto = null;

		try {

			con = dbopen.getConnection();

			sql = new StringBuilder();
			sql.append("SELECT num, writer, subject, content, passwd, ip, reg_date ");
			sql.append("FROM board ");
			sql.append("WHERE num=?AND passwd=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getPasswd());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setIp(rs.getString("ip"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
			}
			else {
				 dto=null;
				 throw new Exception("rs.next()가 제대로 동작하지 않습니다. "
				 		+ "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 수정할 자료가 존재하지 않거나 비밀번호 오류입니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return dto;

	} // update() end ////////////////////////////////////////////
	

	public int updateProc(BoardDTO dto) {
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		*/
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("UPDATE board ");
			sql.append("SET writer=?, subject=?, content=?, passwd=?, ip=?, reg_date=sysdate ");
			sql.append("WHERE num=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getIp());
			pstmt.setInt(6, dto.getNum());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 수정을 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;
	} // updateProc() end ////////////////////////////////////////////


	
	public int delete(BoardDTO dto) {
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		*/
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("DELETE FROM board ");
			sql.append("WHERE num=?AND passwd=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getPasswd());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 삭제를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // delete() end ////////////////////////////////////////////


	
	public int delete(String selectNum[]) {
		// 관리자페이지에서 글 삭제 (다중삭제)

		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			
			// Query 작성
			String sqlstr="";
			sqlstr+="DELETE FROM board ";
			sqlstr+="WHERE num IN(";
			sqlstr+=selectNum[0];
			for(int i=1;i<selectNum.length;i++) {
				sqlstr=sqlstr+", "+selectNum[i];	// checkbox에서 받은 값 꺼내오기
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

	
	
	///////////////////////// BoardDAO 전용 메소드
	

	
	public int insertArticle(BoardDTO article) throws Exception{
		// 글 추가
		
		int num=article.getNum();
		int ref=article.getRef();
		int re_step=article.getRe_step();
		int re_level=article.getRe_level();
		int number=0;
		int res=0;

		try {
			con = dbopen.getConnection();	//DBOpen
			//con=this.getConnection();	//DBCP
			sql = new StringBuilder();

			pstmt = con.prepareStatement("SELECT MAX(num) FROM board ");

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				number=rs.getInt(1)+1;
			}else {
				number=1;
			}
			
			// 답변 쓰기 시 글순서 재조정
			if(num!=0) {
				
				sql.delete(0,sql.length());
				sql.append("UPDATE board SET re_step=re_step+1 ");
				sql.append("WHERE ref=? AND re_step>? ");
				
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				
				re_step++;
				re_level++;
				
			}else {
				ref=number;
				re_step=0;
				re_level=0;
			}// if(글순서조정) end
			
			
			sql.delete(0, sql.length());
			sql.append("INSERT INTO board(num, writer, email, subject, content, passwd, reg_date, ref, re_step, re_level, ip) ");
			sql.append("VALUES((SELECT NVL(MAX(num),0)+1 FROM board), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");

			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1,article.getWriter());
			pstmt.setString(2,article.getEmail());
			pstmt.setString(3,article.getSubject());
			pstmt.setString(4,article.getContent());
			pstmt.setString(5,article.getPasswd());
			pstmt.setTimestamp(6,article.getReg_date());
			pstmt.setInt(7,ref);
			pstmt.setInt(8,re_step);
			pstmt.setInt(9,re_level);
			pstmt.setString(10,article.getIp());
			
			res=pstmt.executeUpdate();
			

		} catch (Exception e) {
			System.out.println("*Error* 행 추가를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}
		
		return res;

	}  // insertArticle() end ////////////////////////////////////////////
	
	
	
	public int getArticleCount() throws Exception {
		
		int x=0;
		
		try {
			con=dbopen.getConnection();
			//con=this.getConnetcion();
			pstmt=con.prepareStatement("SELECT count(*) FROM board");
			rs=pstmt.executeQuery();
			
			if(rs.next()) x=rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {}
		} // try~catch~finally end
		
		return x;
		
	} // getArticleCount() end ////////////////////////////////////////////
	
	
	
	public List<BoardDTO> getArticles(int start, int end) throws Exception {
		// 목록 보기
		
		List<BoardDTO> articleList=null;
		sql=new StringBuilder();
		
		sql.append("SELECT AA.* ");
		sql.append("FROM( ");
		sql.append("SELECT ROWNUM AS rnum, BB.* ");
		sql.append("FROM( ");
		sql.append("SELECT num, writer, email, subject, content, passwd, reg_date, readcount, ref, re_step, re_level, ip ");
		sql.append("FROM board ORDER BY ref DESC, re_step ASC ");
		sql.append(") BB ");
		sql.append(") AA ");
		sql.append("WHERE AA.rnum>=? AND AA.rnum<=? ");

		try {
			con = dbopen.getConnection();
			//con=this.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setInt(1,start);
			pstmt.setInt(2,end);
			
			rs = pstmt.executeQuery();
			
			
			if (rs.next()) {
				articleList = new ArrayList<>(end);
				
				do {
					BoardDTO article = new BoardDTO(); // 한줄 저장
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setContent(rs.getString("content"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setIp(rs.getString("ip"));
					articleList.add(article);

				} while (rs.next());
			}
			else {
				 throw new Exception("rs.next()가 제대로 동작하지 않습니다. "
				 		+ "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 자료 조회를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}
		
		return articleList;
		
	} // getArticles() end ////////////////////////////////////////////
	
	
	
	public BoardDTO getArticle(int num) throws Exception {
		// 상세보기
		
		BoardDTO article=null;
		
		try {
			con = dbopen.getConnection();
			//con=this.getConnection();
			sql=new StringBuilder();
			
			sql.append("UPDATE board SET readcount=readcount+1 ");
			sql.append("WHERE num=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
			
			sql.delete(0,sql.length());
			sql.append("SELECT num, writer, email, subject, content, passwd, reg_date, readcount, ref, re_step, re_level, ip ");
			sql.append("FROM board WHERE num=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1,num);
			rs=pstmt.executeQuery();
			
			if (rs.next()) {
				article=new BoardDTO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setIp(rs.getString("ip"));
			}
			else {
				 throw new Exception("rs.next()가 제대로 동작하지 않습니다. "
				 		+ "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 자료 조회를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}
		
		return article;
		
	} // getArticle() end ////////////////////////////////////////////

	
	
	public BoardDTO loadArticle(BoardDTO dto) {

		try {

			con = dbopen.getConnection();

			sql = new StringBuilder();
			sql.append("SELECT num, writer, email, subject, content, passwd, reg_date, ip ");
			sql.append("FROM board ");
			sql.append("WHERE num=?AND passwd=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getPasswd());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setEmail(rs.getString("email"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setIp(rs.getString("ip"));
			}
			else {
				 dto=null;
				 throw new Exception("rs.next()가 제대로 동작하지 않습니다. "
				 		+ "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
			}

		} catch (Exception e) {
			System.out.println("*Error* 수정할 자료가 존재하지 않거나 비밀번호 오류입니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return dto;

	} // loadArticle() end ////////////////////////////////////////////
	

	
	public int updateArticle(BoardDTO dto) {
		
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("UPDATE board ");
			sql.append("SET writer=?, email=?, subject=?, content=?, passwd=?, reg_date=?, ip=? ");
			sql.append("WHERE num=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getPasswd());
			pstmt.setTimestamp(6, dto.getReg_date());
			pstmt.setString(7, dto.getIp());
			pstmt.setInt(8, dto.getNum());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 수정을 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;
		
	} // updateArticle() end ////////////////////////////////////////////



	public int deleteArticle(BoardDTO dto) {
		
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("DELETE FROM board ");
			sql.append("WHERE num=?AND passwd=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getPasswd());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 삭제를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // deleteArticle() end ////////////////////////////////////////////

	
	
}
