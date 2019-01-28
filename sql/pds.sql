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



