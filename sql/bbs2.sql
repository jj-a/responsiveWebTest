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






























