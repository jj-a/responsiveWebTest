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
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		*/
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append("INSERT INTO tb_bbs(bbsno,wname,subject,content,passwd,grpno,ip) ");
			sql.append("VALUES((SELECT NVL(MAX(bbsno),0)+1 FROM tb_bbs),?,?,?,?,(SELECT NVL(MAX(bbsno),0)+1 FROM tb_bbs),?) ");

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
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = null;
		*/
		ArrayList<BbsDTO> list = null;
		
		/*
		 * SELECT bbsno, wname, subject, readcnt, indent, regdt 
		 * FROM tb_bbs 
		 * ORDER BY grpno DESC, ansnum ASC ;
		 */

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("SELECT bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip ");
			sql.append("FROM tb_bbs ");
			sql.append("ORDER BY grpno DESC,indent ASC, ansnum ASC ");

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
	
	

	public synchronized  ArrayList<BbsDTO> list(String col, String word) { 
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = null;
		*/
		ArrayList<BbsDTO> list = null;
		
		/*
		 * SELECT bbsno, wname, subject, readcnt, indent, regdt 
		 * FROM tb_bbs 
		 * ORDER BY grpno DESC, ansnum ASC ;
		 */

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("SELECT bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip ");
			sql.append("FROM tb_bbs ");

			if(word.length()>=1) {	// 검색어 유무 확인
				String search="";
				if(col.equals("wname")) search+="WHERE wname LIKE '%"+word+"%' ";
				else if(col.equals("subject")) search+="WHERE subject LIKE '%"+word+"%' ";
				else if(col.equals("content")) search+="WHERE content LIKE '%"+word+"%' ";
				else if(col.equals("subj_cont")) search+="WHERE subject LIKE '%"+word+"%' OR content LIKE '%"+word+"%' ";
				sql.append(search);
			}

			sql.append("ORDER BY grpno DESC,indent ASC, ansnum ASC ");
			
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

	
	
	public ArrayList<BbsDTO> list(String col, String word, int nowPage, int recordPerPage) {
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		*/
		ArrayList<BbsDTO> list = null;

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
				sql.append(" SELECT  bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip, rnum");
				sql.append(" FROM(");
				sql.append("      SELECT  bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip, rownum as rnum");
				sql.append("      FROM (");
				sql.append("           SELECT  bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip");
				sql.append("           FROM tb_bbs ");
				//sql.append("           WHERE indent=0 ");	//	*** Comment.jsp에서 답글 숨기기 조건 --list에서는 안보이게
				sql.append("           ORDER BY grpno DESC, ansnum ASC");
				sql.append("      )");
				sql.append(" )     ");
				sql.append(" WHERE rnum >= " + startRow + " AND rnum <= " + endRow);

				pstmt = con.prepareStatement(sql.toString());

			} else { // 검색을 하는 경우
				sql.append("SELECT  bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip, rnum ");
				sql.append("FROM(");
				sql.append("SELECT  bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip, rownum as rnum ");
				sql.append("FROM ( ");
				sql.append("SELECT  bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip ");
				sql.append("FROM tb_bbs ");

				//검색
				if (word.length() >= 1) {
					String search = " WHERE " + col + " LIKE '%" + word + "%' ";
					sql.append(search);
					//sql.append("AND indent=0 ");	//	*** Comment.jsp에서 답글 숨기기 조건 --list에서는 안보이게
				}

				sql.append("ORDER BY grpno DESC, ansnum ASC ");
				sql.append(") ");
				sql.append(") ");
				sql.append("WHERE rnum >= " + startRow + " AND rnum <= " + endRow+" ");

				pstmt = con.prepareStatement(sql.toString());

			}

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				list = new ArrayList<BbsDTO>();
				BbsDTO dto = null; //레코드 1개보관
				do {
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

	
	
	public ArrayList<BbsDTO> cmtlist(String col, String word, int nowPage, int recordPerPage) {
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		*/
		ArrayList<BbsDTO> list = null;

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
		SELECT rnum, bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip
		FROM (
			-- rownum 번호 매기기
			SELECT bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip, rownum AS rnum
			FROM (
				-- CNT_TB & tb_bbs 원본 join: 새글만 select
				SELECT TB.*, CNT_TB.cnt FROM (
					-- CNT_TB: grpno별로 답글 count
					SELECT grpno, COUNT(grpno)-1 AS cnt FROM tb_bbs 
					GROUP BY grpno
				)CNT_TB  JOIN  tb_bbs TB
				ON CNT_TB.grpno=TB.grpno 
				WHERE TB.indent=0
				ORDER BY TB.grpno DESC 
			)
		)
		WHERE rnum>=6 AND rnum<=10
		;
			 */
			
			word = word.trim(); // 문자열 좌우 공백 제거

			if (word.length() == 0) { // 검색을 안하는 경우
				//-- rownum 순으로 페이징
				sql.append(" SELECT  rnum, bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip, cnt ");
				sql.append(" FROM( ");
				//-- rownum 번호 매기기
				sql.append("SELECT  bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip, cnt, rownum AS rnum ");
				sql.append("FROM ( ");
				//-- CNT_TB & tb_bbs 원본 join: 새글만 select
				sql.append("SELECT TB.*, CNT_TB.cnt FROM ( ");
				//-- CNT_TB: grpno별로 답글 count
				sql.append("SELECT grpno, COUNT(grpno)-1 AS cnt FROM tb_bbs ");
				sql.append("GROUP BY grpno ");
				sql.append(")CNT_TB  JOIN  tb_bbs TB ");
				sql.append("ON CNT_TB.grpno=TB.grpno ");
				sql.append("WHERE TB.indent=0 ");
				sql.append("ORDER BY TB.grpno DESC ");
				sql.append(") ");
				sql.append(" ) ");
				sql.append(" WHERE rnum >= " + startRow + " AND rnum <= " + endRow+" ");

				pstmt = con.prepareStatement(sql.toString());

			} else { // 검색을 하는 경우
				//-- rownum 순으로 페이징
				sql.append(" SELECT  rnum, bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip, cnt ");
				sql.append(" FROM( ");
				//-- rownum 번호 매기기
				sql.append("SELECT  bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip, cnt, rownum AS rnum ");
				sql.append("FROM ( ");
				//-- CNT_TB & tb_bbs 원본 join: 새글만 select
				sql.append("SELECT TB.*, CNT_TB.cnt FROM ( ");
				//-- CNT_TB: grpno별로 답글 count
				sql.append("SELECT grpno, COUNT(grpno)-1 AS cnt FROM tb_bbs ");
				sql.append("GROUP BY grpno ");
				sql.append(")CNT_TB  JOIN  tb_bbs TB ");
				sql.append("ON CNT_TB.grpno=TB.grpno ");
				sql.append("WHERE TB.indent=0 ");

				//검색
				if (word.length() >= 1) {
					sql.append(" AND " + col + " LIKE '%" + word + "%' ");
				}

				sql.append("ORDER BY TB.grpno DESC ");
				sql.append(") ");
				sql.append(") ");
				sql.append("WHERE rnum >= " + startRow + " AND rnum <= " + endRow+" ");

				pstmt = con.prepareStatement(sql.toString());

			}

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				list = new ArrayList<BbsDTO>();
				BbsDTO dto = null; //레코드 1개보관
				do {
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
			sql.append("FROM tb_bbs ");
			
			if(word.length()>=1) {	// 검색어 유무 확인
				String search="";
				if(col.equals("wname")) search+="WHERE wname LIKE '%"+word+"%' ";
				else if(col.equals("subject")) search+="WHERE subject LIKE '%"+word+"%' ";
				else if(col.equals("content")) search+="WHERE content LIKE '%"+word+"%' ";
				else if(col.equals("subj_cont")) search+="WHERE subject LIKE '%"+word+"%' OR content LIKE '%"+word+"%' ";
				//search+="AND indent=0 ";	//	*** Comment.jsp에서 답글 숨기기 조건 --list에서는 안보이게
				sql.append(search);
				System.out.println("검색: 검색어가 있습니다.");
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
			sql.append("FROM tb_bbs ");
			sql.append("WHERE indent=0 ");
			
			
			if(word.length()>=1) {	// 검색어 유무 확인
				String search="";
				if(col.equals("wname")) search+="AND wname LIKE '%"+word+"%' ";
				else if(col.equals("subject")) search+="AND subject LIKE '%"+word+"%' ";
				else if(col.equals("content")) search+="AND content LIKE '%"+word+"%' ";
				else if(col.equals("subj_cont")) search+="AND subject LIKE '%"+word+"%' OR content LIKE '%"+word+"%' ";
				//search+="AND indent=0 ";	//	*** Comment.jsp에서 답글 숨기기 조건 --list에서는 안보이게
				sql.append(search);
				System.out.println("검색: 검색어가 있습니다.");
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
		
		String iplist[]= {"127.0.0.1", "172.16.10.253", "172.16.10.100", "172.16.10.6", "172.16.10.8", "172.16.10.16", "172.16.10.22", "172.16.10.3", "172.16.10.10", "172.16.10.20"};
		String name[]= {"Admin", "Mobile", "강사님", "장민수", "누리누리", "계석준", "나기범", "이경화", "임소연", "박찬석"};
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

	
	public BbsDTO read(int bbsno) {
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = null;
		*/
		BbsDTO dto = null;

		/*
		 * SELECT bbsno, wname, subject, content, readcnt, grpno, ip, regdt 
		 * FROM tb_bbs 
		 * WHERE bbsno=?
		 */

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			
			sql.append("SELECT bbsno, wname, subject, content, passwd, readcnt, regdt, grpno, indent, ansnum, ip ");
			sql.append("FROM tb_bbs ");
			sql.append("WHERE bbsno=? ");

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
	
	
	
	public int replyCnt(int bbsno) {	// 답글수 계산
		/*
		StringBuilder sql = null;
		*/
		int cnt = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			// 답글수 계산 (하는중)

			// 1) 현재 게시글의 grpno, indent, ansnum 불러오기
			int grpno = 0, indent = 0, ansnum = 0;
			sql.append("SELECT grpno, indent, ansnum ");
			sql.append("FROM tb_bbs ");
			sql.append("WHERE bbsno=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				grpno = rs.getInt("grpno");
				indent = rs.getInt("indent");
				ansnum = rs.getInt("ansnum");

			} else {
				System.out.println("Error1 : 값이 없거나 오류");
			}

			// 2) 같은 그룹 게시물 중 indent가 높은 글만 select
			sql.delete(0, sql.length());
			sql.append("SELECT COUNT(*) AS cnt  ");
			sql.append("FROM tb_bbs ");
			sql.append("WHERE grpno=? AND indent>? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, indent);

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
	
	
	
	public int incrementCnt(int bbsno) {
		// readcnt(조회수) 증가
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		*/
		int res = 0;

		/*
		 * UPDATE tb_bbs 
		 * SET readcnt=readcnt+1 
		 * WHERE bbsno=?
		 */

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("UPDATE tb_bbs ");
			sql.append("SET readcnt=readcnt+1 ");
			sql.append("WHERE bbsno=? ");

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

				System.out.println("전달값 확인: "+"grpno="+grpno+" indent="+indent+" ansnum="+ansnum);
				
			}
			else {
				 throw new Exception("rs.next()가 제대로 동작하지 않습니다. "
				 		+ "Check: Query가 제대로 들어갔는지, next()가 중복 사용된건 아닌지 확인해주세요.");
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
			sql.append("VALUES((SELECT nvl(MAX(bbsno),0)+1 FROM tb_bbs),?,?,?,?,?,?,?,?) ");

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
	
	
	public BbsDTO update(BbsDTO dto) {
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
			sql.append("SELECT bbsno, wname, subject, content, passwd, ip, regdt ");
			sql.append("FROM tb_bbs ");
			sql.append("WHERE bbsno=?AND passwd=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getBbsno());
			pstmt.setString(2, dto.getPasswd());
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
	

	public int updateProc(BbsDTO dto) {
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		*/
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("UPDATE tb_bbs ");
			sql.append("SET wname=?, subject=?, content=?, passwd=?, ip=?, regdt=sysdate ");
			sql.append("WHERE bbsno=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getIp());
			pstmt.setInt(6, dto.getBbsno());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 수정을 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;
	} // updateProc() end ////////////////////////////////////////////


	
	public int delete(BbsDTO dto) {
		/*
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		*/
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append("DELETE FROM tb_bbs ");
			sql.append("WHERE bbsno=?AND passwd=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getBbsno());
			pstmt.setString(2, dto.getPasswd());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("*Error* 행 삭제를 실패했습니다. \n" + e);
		} finally {
			dbclose.close(con, pstmt);
		}

		return res;

	} // delete() end ////////////////////////////////////////////

	
	
}
