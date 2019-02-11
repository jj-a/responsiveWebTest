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




-- 글목록 (bbsList.jsp / list()함수)
SELECT bbsno, wname, subject, readcnt, indent, regdt
FROM tb_bbs
ORDER BY grpno DESC, ansnum ASC
;

-- 상세보기 (bbsRead.jsp / read()함수)
SELECT bbsno, wname, subject, content, readcnt, grpno, ip, regdt
FROM tb_bbs
WHERE bbsno=?
;


-- 조회수 증가 (incrementCnt() 함수)
UPDATE tb_bbs
SET readcnt=readcnt+1
WHERE bbsno=?
;

-- 답변쓰기
1) 부모글 정보 가져오기 (select)
SELECT grpno, indent, ansnum
FROM tb_bbs
WHERE bbsno=?

2) 글순서 재조정 (update)
UPDATE tb_bbs
SET ansnum=ansnum+1
WHERE grpno=? AND ansnum>=?
;

-- 일련번호(seq), 작성자, 글제목, 글내용, 비밀번호, 그룹번호, IP
INSERT INTO tb_bbs(bbsno,wname,subject,content,passwd,grpno,indent,ansnum,ip)
VALUES(bbsno_seq.nextval,?,?,?,?,(SELECT nvl(MAX(bbsno),0)+1 FROM tb_bbs)),?,?,?)
;



-- 수정
-- 비밀번호가 일치하면 수정하고자 하는 글을 가져와서 수정폼에 출력 후 작성자,제목,내용,비밀번호 수정

-- 1) bbsUpdate.jsp
-- 비밀번호 입력폼 작성

-- 2) bbsUpdateForm.jsp
-- 비밀번호와 글번호가 일치하는 글을  DB가져오기
SELECT wname, subject, content, passwd 
FROM tb_bbs 
WHERE passwd=? AND bbsno=?
;

--3) 해당 정보를 수정폼에 출력

-- 4) bbsUpdateProc.jsp
-- 사용자가 다시 입력한 내용을 DB에서 수정
UPDATE tb_bbs 
SET wname, subject, content, passwd, ip=? 
WHERE bbsno=?
;


-- 검색
-- 제목에 무궁화 단어가 있는 레코드 검색
SELECT * 
FROM tb_bbs
WHERE subject LIKE '%무궁화%'
;


-- 페이징
-- rownum 활용

-- 1)
SELECT bbsno, subject, grpno, ansnum 
FROM tb_bbs 
ORDER BY grpno DESC, ansnum ASC
;

--2) ROWNUM 추가
SELECT ROWNUM, tb.bbsno, tb.subject, tb.grpno, tb.ansnum FROM(
	SELECT bbsno, subject, grpno, ansnum 
	FROM tb_bbs 
	ORDER BY grpno DESC, ansnum ASC
) TB
;

--3) 조건 추가
SELECT ROWNUM, bbsno, subject, grpno, ansnum FROM(
	SELECT bbsno, subject, grpno, ansnum 
	FROM tb_bbs 
	ORDER BY grpno DESC, ansnum ASC
)
WHERE ROWNUM>=1 AND ROWNUM<=5
;

-- 4) 중간 자료도 검색되도록 수정
SELECT rnum, bbsno, subject, grpno, ansnum FROM(
	SELECT ROWNUM rnum, bbsno, subject, grpno, ansnum FROM(
		SELECT bbsno, subject, grpno, ansnum 
		FROM tb_bbs 
		ORDER BY grpno DESC, ansnum ASC
	)
)
WHERE rnum>=6 AND rnum<=10
;

-- 5) (최종) 페이징 + 검색
SELECT rnum, bbsno, subject, grpno, ansnum FROM( 
	SELECT ROWNUM rnum, bbsno, subject, grpno, ansnum FROM( 
		SELECT bbsno, subject, grpno, ansnum FROM tb_bbs 
		WHERE wname LIKE '%테스트%' 
		ORDER BY grpno DESC, ansnum ASC 
	) 
) 
WHERE rnum>=1 AND rnum<=5 
;

---- 페이징 로직 (설계 참고용)

for(int i=1;i<=MAX(rnum);i+=5){	
		SELECT rnum, bbsno, subject, grpno, ansnum FROM( 
			SELECT ROWNUM rnum, bbsno, subject, grpno, ansnum FROM( 
				SELECT bbsno, subject, grpno, ansnum FROM tb_bbs 
				WHERE wname LIKE '%테스트%' 
				ORDER BY grpno DESC, ansnum ASC 
			) 
		) 
		WHERE rnum>=i AND rnum<=i+5 
}




-- 댓글수

SELECT grpno, indent, ansnum
FROM tb_bbs
WHERE bbsno=39
;


-- grpno가 동일한 레코드를 그룹화하고 갯수구하기

SELECT COUNT(*) AS cnt
FROM tb_bbs
WHERE grpno=39 AND indent>0
;


-- 내껄로 수정중
-- 답글(indent>0)도 체크되도록 작성
SELECT COUNT(tb.grpno) AS cnt 
FROM tb_bbs AS TB JOIN (
	SELECT * 
	FROM tb_bbs 
) PNO
ON tb.grpno=pno.grpno 
;

SELECT grpno, COUNT(indent) AS cnt 
FROM tb_bbs BB JOIN (SELECT * FROM tb_bbs) TB 
ON bb.bbsno 
GROUP BY GRPNO;


SELECT COUNT(tb.grpno) AS cnt 
FROM tb_bbs AS TB JOIN (
	SELECT grpno, indent, ansnum 
	FROM tb_bbs 
	WHERE bbsno=39 
) PNO
ON tb.grpno=pno.grpno 
WHERE grpno=39 AND indent>0
;



-- 전체조회
SELECT * FROM tb_bbs
ORDER BY grpno DESC, indent ASC
;


SELECT grpno, COUNT(grpno) AS cnt
FROM TB_BBS
GROUP BY grpno
;

SELECT grpno, COUNT(grpno)-1 AS cnt
FROM TB_BBS
GROUP BY grpno
;



-- 최종 답글수
-- indent=0인 새글만 체크됨
SELECT bbsno, subject, content, cnt, readcnt, regdt, ip FROM (
	SELECT grpno, COUNT(grpno)-1 AS cnt
	FROM tb_bbs 
	GROUP BY grpno
)BB JOIN tb_bbs TB
ON BB.grpno=TB.grpno 
WHERE TB.indent=0
ORDER BY TB.grpno DESC 
;




--★★★★★★★★★★★★★★★★

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

--★★★★★★★★★★★★★★★★

-- 검색할 시


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
		WHERE TB.indent=0 AND TB.subject LIKE '%테%'
		ORDER BY TB.grpno DESC 
	)
)
WHERE rnum>=2 AND rnum<=5
;

-- 댓글목록에서 검색	// %테%=4 나오게
SELECT COUNT(*) AS cnt FROM tb_bbs 
WHERE indent=0 AND subject LIKE '%테%' 
;






---------- 삭제 ----------

--시퀀스 삭제 (**주의**)
DROP SEQUENCE bbsno_seq
;

-- 테이블 삭제 (**주의**)
DROP TABLE tb_bbs
;

------------------------








-- bbs.sql
-- 답변형 게시판
 
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
);

-- 새글쓰기
bbsno : max(bbsno)+1
wname, subject, content, passwd : 사용자입력
default 값 : readcnt, regdt, indent, ansnum
grpno : max(bbsno)+1
ip : request내부객체에서 사용자PC의 IP정보를 가져옴

-- 행추가 테스트
insert into tb_bbs(bbsno, wname, subject, content, passwd, grpno, ip)
values(
       (select nvl(max(bbsno),0)+1 from tb_bbs)
      ,'손흥민'
      ,'오필승코리아'
      ,'무궁화 꽃이 피었습니다'
      ,'1234'
      ,(select nvl(max(bbsno),0)+1 from tb_bbs)
      ,'127.0.0.1'
);

-- 목록
select * from tb_bbs order by grpno desc, ansnum asc;


-- 글목록(bbsList.jsp / list()함수)
select bbsno, wname, subject, readcnt, indent, regdt
from tb_bbs
order by grpno desc, ansnum asc;


-- 상세보기(bbsRead.jsp / read()함수)
select bbsno, wname, subject, content, readcnt, grpno, ip, regdt
from tb_bbs
where bbsno = ?;


-- 조회수 증가
update tb_bbs
set readcnt = readcnt + 1
where bbsno = ?;

-- 답변쓰기
1) 부모글 정보 가져오기 (select문)
select grpno, indent, ansnum
from tb_bbs
where bbsno=?

2) 글순서 재조정 (update문)
update tb_bbs
set ansnum = ansnum+1
where grpno=1 and ansnum>=3

3) 답변글 추가 (insert문)
insert into tb_bbs(bbsno,wname,subject,content,passwd,ip,grpno,indent,ansnum)
values()


-- 삭제
delete from tb_bbs
where passwd = ? and bbsno = ?;


-- 수정
-- 비밀번호가 일치하면 수정하고자 하는 글을 가져와서
-- 수정폼에 출력하고
-- 작성자, 제목, 내용, 비밀번호를 수정한다

1) bbsUpdate.jsp
   비밀번호 입력폼 작성

2) bbsUpdateForm.jsp
   비밀번호와 글번호가 일치하는 글을 DB 가져오기
   select wname, subject, content, passwd
   from tb_bbs
   where passwd = ? and bbsno = ?

3) 2)의 정보를 수정폼에 출력

4) bbsUpdateProc.jsp
   사용자가 다시 입력한 내용을 DB에서 수정하기
   update tb_bbs
   set wname=?, subject=?, content=?, passwd=?,ip=?
   where bbsno=?
   수정이 완료되면 목록페이지 이동

-- 검색
-- 제목에 무궁화 단어가 있는 레코드 검색
select *
from tb_bbs
where subject like '%무궁화%';
   
   
-- 페이징
-- rownum(줄번호) 활용

1)
select bbsno, subject, grpno, ansnum
from tb_bbs
order by grpno desc, ansnum asc;

2) rownum 추가  -- 줄번호까지 정렬됨
select bbsno, subject, grpno, ansnum, rownum
from tb_bbs
order by grpno desc, ansnum asc;

3) 1)의 SQL문 셀프조인
select AA.bbsno, AA.subject, AA.grpno, AA.ansnum, rownum
from (
      select bbsno, subject, grpno, ansnum
      from tb_bbs
      order by grpno desc, ansnum asc
     ) AA;

4) alias 생략가능
select bbsno, subject, grpno, ansnum, rownum
from (
      select bbsno, subject, grpno, ansnum
      from tb_bbs
      order by grpno desc, ansnum asc
     );

5) 줄번호 1~3 검색(1 페이지)
select bbsno, subject, grpno, ansnum, rownum
from (
      select bbsno, subject, grpno, ansnum
      from tb_bbs
      order by grpno desc, ansnum asc
     )
where rownum >= 1 and rownum <= 3;


6) 줄번호 4~6 검색(2 페이지) -> 검색안됨
select bbsno, subject, grpno, ansnum, rownum
from (
      select bbsno, subject, grpno, ansnum
      from tb_bbs
      order by grpno desc, ansnum asc
     )
where rownum >= 4 and rownum <= 6;   


7) 줄번호 4~6 검색(2 페이지)
select bbsno, subject, grpno, ansnum, rnum
from (
      select bbsno, subject, grpno, ansnum, rownum as rnum
      from (
            select bbsno, subject, grpno, ansnum
            from tb_bbs
            order by grpno desc, ansnum asc
           ) AA
     )BB     
where rnum >= 4 and rnum <= 6;     
     
     
8) alias 생략가능
select bbsno, subject, grpno, ansnum, rnum
from (
      select bbsno, subject, grpno, ansnum, rownum as rnum
      from (
            select bbsno, subject, grpno, ansnum
            from tb_bbs
            order by grpno desc, ansnum asc
           ) 
     )     
where rnum >= 4 and rnum <= 6; 


9) 페이징 + 검색
   제목에 '솔데스크' 검색해서 2페이지 출력
select bbsno, subject, grpno, ansnum, rnum
from (
      select bbsno, subject, grpno, ansnum, rownum as rnum
      from (
            select bbsno, subject, grpno, ansnum
            from tb_bbs
            where subject like '%솔데스크%'
            order by grpno desc, ansnum asc
           ) 
     )     
where rnum >= 4 and rnum <= 6;    
----------------------------------------------
-- [댓글 갯수 구하기]
-- 출력결과
부모글제목  답변갯수  조회수 작성자 작성일
안녕하세요  (1)  
김연아      (2)

--1)
select subject, grpno, indent, ansnum
from tb_bbs
order by grpno desc;

--2) grpno가 동일한 레코드를 그룹화하고
--   갯수를 구하시오
select grpno, count(grpno) as cnt
from tb_bbs
group by grpno;

--3) 2)에서 나온 갯수는 부모글+자식글 이므로
--   갯수에서 -1을 한다
select grpno, count(grpno)-1 as cnt
from tb_bbs
group by grpno;

-- 4) 3)의 논리적테이블에 셀프조인해서
--    최초 부모글 제목 가져오기
select BB.bbsno, BB.subject, AA.grpno, AA.cnt
from (
      select grpno, count(grpno)-1 as cnt
      from tb_bbs
      group by grpno
     ) AA join tb_bbs BB
on AA.grpno = BB.grpno
where BB.indent = 0 --최초 부모글
order by grpno DESC


-- 5) bbsComment.jsp
--    댓글갯수를 담기 위해
--    BbsDTO클래스에 private int comment 추가하고, 각 getter, setter함수 추가
    
select bbsno, subject, wname, readcnt, regdt, grpno, cnt, rnum
from (
      select bbsno, subject, wname, readcnt, regdt, grpno, cnt, rownum as rnum
      from(
           select BB.bbsno, BB.subject, BB.wname, BB.readcnt, BB.regdt, AA.grpno, AA.cnt
           from (
                 select grpno, count(grpno)-1 as cnt
                 from tb_bbs
                 group by grpno
                ) AA join tb_bbs BB
          on AA.grpno = BB.grpno
          where BB.indent = 0
          order by grpno DESC
     )
)
where rnum>=6 and rnum<=10



select bbsno, subject, wname, readcnt, regdt, grpno, cnt, rnum
from (
      select bbsno, subject, wname, readcnt, regdt, grpno, cnt, rownum as rnum
      from(
           select BB.bbsno, BB.subject, BB.wname, BB.readcnt, BB.regdt, AA.grpno, AA.cnt
           from (
                 select grpno, count(grpno)-1 as cnt
                 from tb_bbs
                 group by grpno
                ) AA join tb_bbs BB
          on AA.grpno = BB.grpno
          where BB.indent = 0
          and subject like '%오%'
          order by grpno DESC
     )
)
where rnum>=2 and rnum<=3






