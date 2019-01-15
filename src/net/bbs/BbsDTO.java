package net.bbs;

public class BbsDTO {

	// -- Variable
	private int bbsno;
	private String wname, subject, content, passwd;
	private int readcnt;
	private String regdt;
	private int grpno, indent, ansnum;
	private String ip;

	
	// -- Constructor

	public BbsDTO() {
		;
	}

	public BbsDTO(String wname, String subject, String content, String passwd) {

		/*
		bbsno: MAX(bbsno)+1
		wname, subject, content, passwd: 사용자 입력
		default 값: readcnt, regdt, indent, ansnum
		grpno: MAX(bbsno)+1
		ip: request 내부객체에서 사용자 PC의 IP 정보를 가져옴
		 */
		
		this.bbsno = bbsno;	// max값 전달받아서 +1 값 저장
		this.grpno = grpno;		// max값 전달받아서 +1 값 저장
		
		this.wname = wname;
		this.subject = subject;
		this.content = content;
		this.passwd = passwd;
		
		this.readcnt = 0;		// default
		this.regdt = "";		// default
		this.indent = 0;		// default
		this.ansnum = 0;		// default

	}
	

	// -- Getter&Setter

	public int getBbsno() {
		return bbsno;
	}

	public void setBbsno(int bbsno) {
		this.bbsno = bbsno;
	}

	public String getWname() {
		return wname;
	}

	public void setWname(String wname) {
		this.wname = wname;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
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

	public int getReadcnt() {
		return readcnt;
	}

	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}

	public String getRegdt() {
		return regdt;
	}

	public void setRegdt(String regdt) {
		this.regdt = regdt;
	}

	public int getGrpno() {
		return grpno;
	}

	public void setGrpno(int grpno) {
		this.grpno = grpno;
	}

	public int getIndent() {
		return indent;
	}

	public void setIndent(int indent) {
		this.indent = indent;
	}

	public int getAnsnum() {
		return ansnum;
	}

	public void setAnsnum(int ansnum) {
		this.ansnum = ansnum;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	
	@Override
	public String toString() {
		return "BbsDTO [bbsno=" + bbsno + ", wname=" + wname + ", subject=" + subject + ", content=" + content + ", passwd="
				+ passwd + ", readcnt=" + readcnt + ", regdt=" + regdt + ", grpno=" + grpno + ", indent=" + indent + ", ansnum="
				+ ansnum + ", ip=" + ip + "]";
	}
	

}
