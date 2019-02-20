-- notice.sql

-- 테이블 생성
CREATE TABLE tb_notice(
     noticeno   number           not null  -- 일련번호
    ,subject    varchar2(255)    not null  -- 제목
    ,content    varchar2(4000)   not null  -- 내용
    ,regdt      date    default  sysdate   -- 작성일
    ,primary key(noticeno)                 -- noticeno 기본키 
);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
-- 추가
INSERT INTO tb_notice(noticeno, subject, content)
VALUES((SELECT NVL(MAX(noticeno),0)+1 FROM tb_notice), ?, ?)
;

INSERT INTO tb_notice(noticeno, subject, content)
VALUES((SELECT NVL(MAX(noticeno),0)+1 FROM tb_notice), '공지사항', '공지사항 테스트')
;

-- 조회
SELECT noticeno, subject, content, regdt
FROM tb_notice
ORDER BY noticeno DESC
;

-- 수정
UPDATE tb_notice
SET subject=? AND content=? AND regdt=SYSDATE
WHERE noticeno=?
;

-- 삭제
DELETE FROM tb_notice
WHERE noticeno=?
;

