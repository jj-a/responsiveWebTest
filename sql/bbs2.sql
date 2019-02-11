-- bbs.sql
-- 답변형 게시판
 
-- 테이블 생성
create table board(
  num          number         NOT NULL,
  writer       varchar2(20)   NOT NULL,
  email        varchar2(30),
  subject      varchar2(50)   NOT NULL,
  content      varchar2(2000) NOT NULL,
  passwd       varchar2(10)   NOT NULL,
  reg_date     date           NOT NULL,
  readcount    number         default 0,
  ref          number         NOT NULL,  -- 그룹번호
  re_step      number         NOT NULL,  -- 글순서
  re_level     number         NOT NULL,  -- 들여쓰기
  ip           varchar2(20)   NOT NULL,
  PRIMARY KEY(num)  
);


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



