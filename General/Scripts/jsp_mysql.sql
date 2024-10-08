-- New script in localhost 2.
-- Connection Type: dev 
-- Url: jdbc:mysql://localhost:3306/
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 5. 23.
-- Time: 오전 9:45:49

USE scott;

DROP TABLE MEMBER ;
CREATE TABLE member(
	no INT AUTO_INCREMENT PRIMARY KEY,
	id varchar(10) UNIQUE,
	pw varchar(10),
	name varchar(10),
	tel varchar(10),
	create_date timestamp DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO MEMBER
VALUES(NULL,'m01', '1', '리사', '010',NOW());
INSERT INTO MEMBER
VALUES(NULL,'2', '2', '주혁', '010',NOW());
INSERT INTO MEMBER
VALUES(NULL,'3', '3', '3', '010',NOW());
INSERT INTO MEMBER
VALUES(NULL,'4', '4', '4', '010',NOW());
INSERT INTO MEMBER
VALUES(NULL,'5', '5', '5', '010',NOW());
COMMIT;

SELECT * FROM MEMBER;
SELECT * FROM board;
SELECT * FROM category;
DROP TABLE board;
DROP TABLE category;


ALTER TABLE Member
MODIFY COLUMN pw VARCHAR(100);

CREATE TABLE CATEGORY(

  C_CODE INT PRIMARY KEY,
  C_NAME VARCHAR(30) CHECK(C_NAME IN('공통', '운동', '등산', '게임', '낚시', '요리', '기타'))  
);


INSERT INTO CATEGORY (C_CODE, C_NAME) VALUES(10, '공통');
INSERT INTO CATEGORY (C_CODE, C_NAME) VALUES(20, '운동');
INSERT INTO CATEGORY (C_CODE, C_NAME) VALUES(30, '요리');
INSERT INTO CATEGORY (C_CODE, C_NAME) VALUES(70, '기타');

COMMIT;
SELECT * FROM CATEGORY;
DROP TABLE BOARD CASCADE;
CREATE TABLE BOARD (
  NO INT PRIMARY KEY AUTO_INCREMENT,
  CATEGORY_CODE INT,
  TITLE VARCHAR(100),
  CONTENT TEXT NOT NULL,
  WRITER varchar(10) NOT NULL,
  COUNT INT DEFAULT 0 NOT NULL,
  CREATED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
  MODIFIED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  STATUS CHAR(1) DEFAULT 'Y',
  FOREIGN KEY (CATEGORY_CODE) REFERENCES CATEGORY(C_CODE),
  FOREIGN KEY (WRITER) REFERENCES MEMBER(ID)
);
INSERT INTO BOARD 
( CATEGORY_CODE, TITLE, CONTENT, WRITER) 
VALUES( 10, '게시글 1 ', '게시글1 CONTENT 입니다 ', 'm01');

INSERT INTO BOARD 
( CATEGORY_CODE, TITLE, CONTENT, WRITER) 
VALUES( 10, '게시글 2 ', '게시글2 CONTENT 입니다 ', 'm01');
INSERT INTO BOARD 
( CATEGORY_CODE, TITLE, CONTENT, WRITER) 
VALUES( 10, '게시글 3 ', '게시글3 CONTENT 입니다 ', '2');
INSERT INTO BOARD 
( CATEGORY_CODE, TITLE, CONTENT, WRITER) 
VALUES( 10, '게시글 4 ', '게시글4 CONTENT 입니다 ', '2');
INSERT INTO BOARD 
( CATEGORY_CODE, TITLE, CONTENT, WRITER) 
VALUES( 10, '게시글 5 ', '게시글5 CONTENT 입니다 ', '3');

SELECT * FROM board;
SELECT * FROM BOARD;
SELECT * FROM company;

DROP TABLE COMPANY;
CREATE TABLE COMPANY (
	ID VARCHAR(200) PRIMARY KEY,
	NAME VARCHAR(200),
	ADDR VARCHAR(200),
	TEL INT(11)
);

INSERT INTO COMPANY VALUES ('c100', 'GOOD', 'SEOUL', 011);

INSERT INTO COMPANY VALUES ('c200', 'JOA', 'BUSAN', 012);

INSERT INTO COMPANY VALUES ('c300', 'MARIA', 'ULSAN', 013);

INSERT INTO COMPANY VALUES ('c400', 'MY', 'KWANGJU', 014);

COMMIT;

DROP TABLE product;
CREATE TABLE PRODUCT (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(100),
    CONTENT VARCHAR(500),
    PRICE INT,
    COMPANY_ID VARCHAR(200) NOT NULL,
    IMG VARCHAR(255),
    CREATED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
    CREATED_PERSON VARCHAR (100),
  	MODIFIED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	MODIFIED_PERSON VARCHAR (100),
  	STATUS CHAR(1) DEFAULT 'Y',
  	FOREIGN KEY (COMPANY_ID) REFERENCES COMPANY(ID)

);
INSERT INTO product VALUES (1,'1', '1',1, 'c100', NULL,null,'1',NULL, '1','Y');
DROP TABLE attachment ;
-- 첨부파일 테이블 생성
CREATE TABLE ATTACHMENT (
  ATTACHMENT_NO INT PRIMARY KEY AUTO_INCREMENT,
  REF_PRODUCT_NO INT NOT NULL,
  ORIGINAL_NAME VARCHAR(255) NOT NULL,
  SAVED_NAME VARCHAR(255) NOT NULL,
  SAVE_PATH VARCHAR(1000) NOT NULL,
  THUMBNAIL_PATH VARCHAR(255),
  STATUS VARCHAR(1) DEFAULT 'Y',
  CREATED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
  CREATED_PERSON VARCHAR (100),
  MODIFIED_DATE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  MODIFIED_PERSON VARCHAR (100),
  FOREIGN KEY (REF_PRODUCT_NO) REFERENCES PRODUCT(ID)  
);

SELECT * FROM attachment ;
SELECT * FROM product ;
SELECT * FROM book ;



CREATE TABLE `book` (
`id` int NOT NULL AUTO_INCREMENT,
`name` varchar(256) DEFAULT NULL,
`url` varchar(256) DEFAULT NULL,
`img` varchar(256) DEFAULT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


insert into book values
(null, 'naver', 'http://www.naver.com', 'naver.png');

insert into book values
(null, 'daum', 'http://www.daum.net', 'daum.png');

insert into book values
(null, 'google', 'http://www.google.com', 'google.png');

COMMIT;

create table movie
(
movie_id int auto_increment primary key,
title varchar(100) not null,
img varchar(100) null,
genre varchar(100) not null,
runningTime varchar(100) null,
link varchar(300) not null
);

SELECT * FROM  movie ;
select * FROM board;
select * FROM bbs2;
select * FROM sign;
select * FROM member;
select * FROM reply;
DROP TABLE sign;

SELECT *
FROM sign
WHERE name = "12" AND birth = "12";

insert INTO sign values
(null, '박재민1', '9804221', null);

create table sign
(
sign_id int auto_increment primary key,
name varchar(100) not null,
birth varchar(100) not null,
img varchar(100) null
);

 CREATE TABLE REPLY (
    ID int auto_increment primary key,
    ORIID int,
    CONTENT VARCHAR(500),
    WRITER VARCHAR (10) NOT NULL,
     FOREIGN KEY (ORIID) REFERENCES BOARD(NO),
     FOREIGN KEY (WRITER) REFERENCES MEMBER(ID)
);  
SELECT * FROM reply;
CREATE TABLE mymap (
    location VARCHAR(100),
    lat VARCHAR (100),
    lon VARCHAR (100)
);   

insert into mymap values 
 ('coex', 37.512,127.0592);
 
insert into mymap values 
 ('tower', 37.512,127.1027);
 
COMMIT;
SELECT * from weather;
CREATE TABLE weather (
    ID int auto_increment primary key,
    lat varchar(100),
    lon varchar(100),
    weather varchar(100),
    wind varchar(100),
    feels varchar(100),
    cloud varchar(100)
     
     
);  
COMMIT;
SELECT * from member;