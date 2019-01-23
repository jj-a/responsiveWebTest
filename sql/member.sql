-- member.sql


-- member 테이블 조회
SELECT * FROM MEMBER
ORDER BY id
;

 
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


   -- 회원 등급
      . A*: 관리자 그룹
      . B*: 중간 관리자 그룹
      . C*: 우수 사용자 그룹
      . D*: 일반 사용자 그룹
      . E*: 비회원. guest 그룹
      . F*: 탈퇴한 회원 그룹
      . X*: 잠긴 계정, 일시 사용 정지
      
      

-- 회원가입
INSERT INTO member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate)
VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, 'D1', sysdate)
;

INSERT INTO member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate)
VALUES('soldesk', '12341234', '솔데스크', '010-1234-5678', 'soldesk@naver.com', '05123', '서울시 종로구 관철동', '코아빌딩 5층', 'A02', 'D1', sysdate)
;


-- 아이디 중복확인
SELECT COUNT(id) cnt FROM member
WHERE id='soldesk'
;

-- 이메일 중복확인
SELECT COUNT(email) cnt FROM member
WHERE email='soldesk@naver.com'
;


-- 로그인 검사
SELECT mlevel FROM member 
WHERE id=? AND passwd=?
AND mlevel IN('A1','B1','C1','D1')
;

SELECT mlevel FROM member 
WHERE id='test2' AND passwd='testtest@'
AND mlevel IN('A1','B1','C1','D1')
;



-- ** 로그인 실패 사유 분기 로직 **

--MemberDTO dto= 사용자가 입력한 id, passwd

-- 1) id정보 executeQuery
SELECT id, passwd, mlevel FROM member 
WHERE id=(dto.id)
;
-- rs.next=null이면 : 아이디 없음 (return 4)
-- rs.next 있으면 : rs에서 passwd 가져옴 (next->)

-- 2) if passwd 확인
if(dto.passwd == rs.getString("passwd"))
-- true: 비밀번호 일치 (next->)
-- false: 비밀번호 틀림 (return 2)

-- 3) if mlevel 확인 (switch?)
if(rs.getString("mlevel") == {"A1","B1","C1","D1"})
-- true: 회원등급 정상 = 로그인 성공 (return 1)
else if(rs.getString("mlevel") == {"X1"})
-- true: 사용중지 회원 = 로그인 실패 (return 3)
-- false: 게스트, 탈퇴 회원 = 로그인 실패 (return 4)

-- 4) return값에 따른 메시지
-- 1: 로그인되었습니다.
-- 2: 비밀번호가 틀렸습니다.
-- 3: 일시적으로 사용정지된 계정입니다. 관리자에게 문의바랍니다.
-- 4: 아이디가 없습니다.



