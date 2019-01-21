-- member.sql


-- member 테이블 조회
SELECT * FROM member;

 
-- 회원테이블 생성
CREATE TABLE member (
    id       VARCHAR(10)  NOT NULL, -- 아이디, 중복 안됨, 레코드를 구분하는 컬럼 
    passwd   VARCHAR(10)  NOT NULL, -- 패스워드
    mname    VARCHAR(20)  NOT NULL, -- 성명
    tel      VARCHAR(14)  NULL,     -- 전화번호
    email    VARCHAR(50)  NOT NULL  UNIQUE, -- 전자우편 주소, 중복 안됨
    zipcode  VARCHAR(7)   NULL,     -- 우편번호, 101-101
    address1 VARCHAR(255) NULL,     -- 주소 1
    address2 VARCHAR(255) NULL,     -- 주소 2(나머지주소)
    job      VARCHAR(20)  NOT NULL, -- 직업
    mlevel   CHAR(2)      NOT NULL, -- 회원 등급, A1, B1, C1, D1, E1, F1
    mdate    DATE         NOT NULL, -- 가입일    
    PRIMARY KEY (id)
);

-- 추가 테스트
INSERT INTO member(id, passwd, mname, tel, email, zipcode, address1,address2, job, mlevel, mdate)
VALUES('user1', '1234', '홍길동', '123-1234', '11@daum.net', '123-123','서울시 관악구 신림동', '코아빌딩5층' ,'회사원','D1', sysdate);

