package net.bbs2;

import java.sql.Timestamp;

public class BoardDTO {

	// -- Variable
	private int num;
	private String writer, subject, email, content, passwd;
	private Timestamp reg_date;
	private int readcount;
	private String ip;
	private int ref, re_step, re_level;
	
	private int cnt;	// 답글(댓글)수 확인
	
	// -- Constructor

	public BoardDTO() {
		;
	}

	public BoardDTO(int num, String writer, String subject, String email, String content, String passwd, Timestamp reg_date,
			int readcount, String ip, int ref, int re_step, int re_level) {
		this.num = num;
		this.writer = writer;
		this.subject = subject;
		this.email = email;
		this.content = content;
		this.passwd = passwd;
		this.reg_date = reg_date;
		this.readcount = readcount;
		this.ip = ip;
		this.ref = ref;
		this.re_step = re_step;
		this.re_level = re_level;
	}

	
	// -- Getter&Setter

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getRe_step() {
		return re_step;
	}

	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}

	public int getRe_level() {
		return re_level;
	}

	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	


	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}


}
