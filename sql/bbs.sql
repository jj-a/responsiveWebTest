-- bbs.sql
-- 답변형 게시판


-- 테이블 조회
SELECT * FROM tb_bbs
;


---------- 생성 ----------

-- 테이블 생성
create table tb_bbs(
  bbsno    number(5)       not null -- 일련번호 -99999~99999
 ,wname    varchar2(20)    not null -- 작성자
 ,subject  varchar2(100)   not null -- 글제목
 ,content  varchar2(2000)  not null -- 글내용
 ,passwd   varchar2(10)    not null -- 글비밀번호
 ,readcnt  number(5)       default 0 not null -- 글조회수
 ,regdt    date            default  sysdate -- 글작성일
 ,grpno    number(5)       not null  -- 글 그룹번호
 ,indent   number(5)       default 0 -- 들여쓰기
 ,ansnum   number(5)       default 0 -- 글순서
 ,ip       varchar2(15)    not null -- 글 IP
 ,primary key(bbsno)                --bbsno 기본키 
)
;

-- 시퀀스 생성
CREATE SEQENCE bbsno_seq
;

------------------------

-- 새글쓰기
bbsno: MAX(bbsno)+1
wname, subject, content, passwd: 사용자 입력
default 값: readcnt, regdt, indent, ansnum
grpno: MAX(bbsno)+1
ip: request 내부객체에서 사용자 PC의 IP 정보를 가져옴



-- 행 추가
-- 일련번호(seq), 작성자, 글제목, 글내용, 비밀번호, 그룹번호, IP
INSERT INTO tb_bbs(bbsno,wname,subject,content,passwd,grpno,ip)
VALUES(bbsno_seq.nextval,'김용택','달이 떴다고 전화를 주시다니요','달이 떴다고 전화를 주시다니요  이 밤 너무 신나고 근사해요  (후략)','1234',(
	SELECT nvl(MAX(bbsno),0)+1 FROM tb_bbs
	),'127.0.0.1')
;



---------- 삭제 ----------

--시퀀스 삭제 (**주의**)
DROP SEQUENCE bbsno_seq
;

-- 테이블 삭제 (**주의**)
DROP TABLE tb_bbs
;

------------------------




