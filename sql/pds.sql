-- pds.sql


-- 테이블명 : tb_pds

CREATE TABLE tb_pds (
  pdsno       NUMBER         NOT NULL
  ,wname      VARCHAR2(100)  NOT NULL
  ,subject    VARCHAR2(250)  NOT NULL
  ,regdate    DATE           NOT NULL
  ,passwd     VARCHAR2(15)   NOT NULL
  ,readcnt    NUMBER         DEFAULT 0
  ,filename   VARCHAR2(250)  NOT NULL	--파일명
  ,filesize   NUMBER         DEFAULT 0	--파일크기
  ,PRIMARY KEY(pdsno)
);


-- 행추가
pdsno = MAX(일련번호)+1
wname, subject, passwd = 사용자 입력
filename, filesize = 첨부파일 관련 정보
regdate = SYSDATE

INSERT INTO tb_pds(pdsno, wname, subject, passwd, filename, filesize, regdate)
VALUES((SELECT NVL(MAX(pdsno),0)+1 FROM tb_pds), ?, ?, ?, ?, 0, SYSDATE)
;

INSERT INTO tb_pds(pdsno, wname, subject, passwd, filename, filesize, regdate)
VALUES((SELECT NVL(MAX(pdsno),0)+1 FROM tb_pds), 
	'작성자', '제목', '비밀번호', '파일명.txt', 0, SYSDATE)
;

-- 조회
SELECT pdsno, wname, subject, regdate, passwd, readcnt, filename, filesize 
FROM tb_pds
ORDER BY pdsno DESC
;

