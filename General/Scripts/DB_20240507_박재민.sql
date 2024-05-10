-- New script in localhost.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//localhost:1521/XE
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 5. 9.
-- Time: 오후 9:15:04

CREATE TABLE MEMBER_TEST (
    USER_ID VARCHAR2(100) NOT NULL,  --중복안되고 NULL값안됨
    USER_PWD VARCHAR2(100) NOT NULL, --NULL값안됨
    PNO VARCHAR2(100) NOT NULL,  --중복안되고 NULL값안됨
    GENDER VARCHAR2(100) ,
    PHONE VARCHAR2(100) ,
    ADDRESS VARCHAR2(100) ,
    STATUS VARCHAR2(100) NOT NULL, --NULL값안됨
    CONSTRAINT unique_user_id UNIQUE (USER_ID), --중복안되게하는 제약조건
    CONSTRAINT unique_pno UNIQUE (PNO) --중복안되게하는 제약조건
);
 INSERT INTO MEMBER_TEST VALUES('1','1','001100-11','M','010122','','N');
 --INSERT INTO MEMBER_TEST VALUES('1','1','001100-11','M','010122','','N'); --중복된값으로 에러
INSERT INTO MEMBER_TEST VALUES('2','2','000400-21','F','010151','','Y');
INSERT INTO MEMBER_TEST VALUES('3','3','980422-11','M','011591','서울시','N');
 SELECT * FROM MEMBER_TEST;
 
-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

CREATE TABLE MOVIE (
    ID VARCHAR2(100) NOT NULL,  -- NULL값안됨
    TITLE VARCHAR2(100) NOT NULL, 
    CONTENT VARCHAR2(100) NOT NULL,  
    ACTOR VARCHAR2(100) NOT NULL
);
INSERT INTO MOVIE VALUES('m1','블랙아담','액션','드웨인존슨');
INSERT INTO MOVIE VALUES('m2','리멤버','드라마','남주혁');
INSERT INTO MOVIE VALUES('m3','자백','스릴러','소지섭');

SELECT * FROM MOVIE;
SELECT * FROM MOVIE WHERE ID='m1';
UPDATE MOVIE SET CONTENT='스릴러' WHERE ID = 'm1';
SELECT * FROM MOVIE WHERE ID='m1';
DELETE FROM MOVIE WHERE ID='m1';
SELECT * FROM MOVIE WHERE ID='m1';

-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

CREATE TABLE PLACE (
    ID VARCHAR2(100) NOT NULL,  -- NULL값안됨
    NAME VARCHAR2(100) NOT NULL, 
    ADDR VARCHAR2(100) NOT NULL,  
    TEL VARCHAR2(100) NOT NULL
);

SELECT * FROM PLACE;

INSERT INTO PLACE VALUES('p1','cgv','강남구 삼성동','02-555');
INSERT INTO PLACE VALUES('p2','megabox','강남구 역삼동','02-666');
INSERT INTO PLACE VALUES('p3','lotte','강남구 대치동','02-777');

SELECT * FROM PLACE WHERE NAME='cgv';
UPDATE PLACE SET TEL='02-888' WHERE ID = 'p3';
SELECT * FROM PLACE WHERE ID='p3';
DELETE FROM PLACE WHERE ID='p3';
DELETE FROM MOVIE;
DELETE FROM PLACE;

DROP TABLE MOVIE;
DROP TABLE PLACE;



