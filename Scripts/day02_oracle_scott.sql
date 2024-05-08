-- CONNECTION: url=jdbc:mysql://localhost:3306/









-- New script in localhost.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//localhost:1521/XE
-- workspace : C:\workspace\multi\03_db
-- Date: 2024. 5. 7.오전 10:01:26




--DB는 저장할 대상을 선정하고
--대상에 어떤 속성(컬럼, 항목)들이 정의해야한다.
--
--대상 == OBJECT == 객체, 개체 == ENTITY(엔터티, 엔티티)
--
--쇼핑몰을 만들 때 저장할 대상 3가지 : 회원, 게시판, 물건
--==> 저장할 대상(엔티티, 개체) 
--==> 개체는 "테이블"로 만들게 된다.!!
--==> 관계성: 회원이 물건을 사다.!(저장할 필요)
--                 관계성 "테이블"로 만들게 된다.!!


--CREATE TABLE MEMBER -- 이미 있어서 그냥 안만듬 
--   (	
--  ID VARCHAR2(10), 
--	PW VARCHAR2(10), 
--	NAME VARCHAR2(10), 
--	TEL VARCHAR2(10)
--   ) 

CREATE TABLE BBS
(	
	NO NUMBER(38,0),
	TITLE VARCHAR2(100),
	CONTENT VARCHAR2(100),
	WRITER VARCHAR2(100)
);

CREATE TABLE PRODUCT(
	id  NUMBER(38,0),
	name varchar2(200), 
	content varchar2(200), 
	price varchar2(200), 
	company varchar2(200), 
	img varchar2(200)
);

-- DML(Data Manupulation Language)
-- INSERT, UPDATE, DELETE, SELECT
-- : 데이터 조작 언어, 테이블에 값을 삽입하거나, 수정하거나,
--   삭제하거나, 조회하는 언어


--INSERT : 새로운행을 추가하는 구문이다. 
--         테이블의 행의 갯수가 증가한다. 

-- 테이블에 모든 컬럼에 대해 값을 INSERT
-- INSERT INTO 테이블명  VALUES(데이터, 데이터,,,,...)

-- 테이블에 일부컬럼에대해 INSERT
 -- INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명,....)  VALUES(데이터, 데이터,데이터,,,...)

-- INSERT 연습 
--  ID VARCHAR2(10), 
--	PW VARCHAR2(10), 
--	NAME VARCHAR2(10), 
--	TEL VARCHAR2(10)


--INSERT INTO MEMBER  VALUES('100','100', 'park','011','1111' ); --: ORA-00913: too many values

INSERT INTO MEMBER (ID, PW, NAME)  VALUES('100','100', 'park');-- 넣고자 하는 컬럼 순서 중요 

--INSERT INTO MEMBER (ID, PW, NAME, COMPANY )  VALUES('100','100', 'park','LG'); --]: 정의되지않는 컬럼에 넣고자 할떄 에러 ORA-00904: "COMPANY": invalid 
INSERT INTO MEMBER 
	(ID, PW, NAME, TEL) 
VALUES
	('', '', ''); --값을 모두 정의하지 않으면 에러  ORA-00947: not enough values

SELECT * FROM "MEMBER" ;
COMMIT;



/*@ DQL(Data Query Language)
데이터를 검색 추출하기 위해 사용하는 언어 
DQL은 DML에 속한언어이기도 하다. 
데이터조회한 결과를 Result set(행들의 집합)이라고 한다.
->0개이상의 행이 포함될수 있고 , 특정기준에 의해 정렬될수 있다. 
*/
/*
@SELECT 기본 작성법
1. SELECT 컬럼명 FROM 테이블명;
2. SELECT 컬럼명 FROM 테이블명 WHERE 조건;

SELECT : 조회하고자하는 컬럼명을 기술, 여러개로 기술하고하하면, (쉼표)로 구분, 
        모든컬럼조회시 * 를 사용
FROM : 조회 대상 컬럼이 포함된 테이블 명을 기술 
WHERE: 행을 선택하는 조건을 기술 
       여러개의 제한조건을 포함할수있고 각 제한조건은 논리연산자로 연결, 제한조건에 만족하는 행들만 
       RESULT SET 에 포함됨
  
*/


SELECT * FROM MEMBER;


SELECT *
FROM "MEMBER" 
WHERE ID = '100';

-- MEMBER 의 ID 조회 
SELECT ID FROM MEMBER;


-- ID 100 의 ID 와 pw 조회 
SELECT ID, PW
FROM "MEMBER" 
WHERE ID = '100';

--AS + 별칭을 기술 
SELECT ID AS 아이디 , NAME FROM MEMBER WHERE ID > 200;


--리터럴 : 임의로 지정한 문자열을 SELECT 절에 사용하면 테이블에 존재하는 데이터 처럼 사용 할수 있다.
-- 모든 행에 반복 표시된다

SELECT 
	ID,
	NAME,
	'원' 단위
FROM MEMBER;

-- 조회시 없으면 아무것도 출력안됨. 
SELECT ID, PW
FROM "MEMBER" 
WHERE ID = 'PAR';


-- 연결연산자를 이용해서 여러컬럼을 하나의 컬럼인것 처럼 연결할수 있다 (||)
-- 컬럼과 컬럼을 연결 

SELECT ID||':'||NAME VAL FROM MEMBER;

SELECT 
    ID||' 의 이름은 '|| NAME||' 입니다.' VAL
FROM MEMBER;



INSERT INTO MEMBER VALUES ('100','1234','PARK','011');

INSERT INTO MEMBER VALUES ('200','1234','PARK','011');

INSERT INTO MEMBER VALUES ('300','1111','APPLE','011');

COMMIT;
-- 연산자 우선순위 
--1. 산술연산자
--2. 연결연산자
--3. 비교연산자
--4. IS NULL / IS NOT NULL / LIKE / NOT LIKE / IN / NOT IN
--5. BETWEEN AND / NOT BETWEEN AND
--6. NOT(논리연자)
--7. AND
--8. OR
SELECT * FROM MEMBER WHERE ID = '200' AND TEL = '011';

SELECT * FROM MEMBER WHERE (ID = '300' OR TEL = '011') AND PW ='1234'; --AND 가 우선순위가 더높다 
SELECT * FROM MEMBER WHERE  ID = '300' OR TEL = '011' AND PW ='1234';

SELECT * FROM MEMBER ORDER BY ID; -- 오름차순 (ORDER BY  디폴트 ASC - 오름차순)

SELECT * FROM MEMBER ORDER BY ID DESC; -- 내림차순


SELECT PW, NAME, ID FROM MEMBER ORDER BY 2 , ID ASC; -- 오름차순 PW (기준 컬럼의 순서대로 1부터 시작 )




--UPDATE : 테이블에 기록된 컬럼의 값을 수정하는 구문이다 
--         테이블의 전체행의 갯수는 변화가 없다. 


-- UPDATE 테이블명 SET 컬럼명 = 바꿀값, 컬럼명 = 바꿀값, ...
-- [WHERE 컬럼명 비교연산자 비교값 ] 

UPDATE MEMBER SET NAME = 'KIM' WHERE ID = '100';

UPDATE MEMBER SET NAME = 'YANG' WHERE ID = '200';

UPDATE MEMBER SET NAME = 'LEE' WHERE ID = '300';
  
SELECT * FROM MEMBER   
WHERE ID = '100';


COMMIT;

UPDATE MEMBER 
SET 
	PW = '8887', TEL = '9999' 
WHERE ID = '100';

ROLLBACK;


--DELETE : 테이블의 행을 삭제하는 구문이다 , 행의 갯수가 줄어듬
--DELETE FROM 테이블명 WHERE 조건설정
-- 만약 WHERE 에 조건을 설정하지않으면 모든 행이 삭제 


SELECT * 
FROM MEMBER WHERE ID = '100';

DELETE FROM MEMBER WHERE ID = '100';

DELETE FROM MEMBER WHERE TEL = '011';
ROLLBACK;


-- TRUNCATE : 테이블의 전체행을 삭제할시 사용된다
--            DELETE  보다 수행속도 빠르다
--            ROLLBACK 을 통해 복구 할수 없다.

SELECT * FROM MEMBER;
COMMIT;
DELETE FROM MEMBER;
ROLLBACK;

TRUNCATE TABLE MEMBER;
ROLLBACK;



-- 제약조건 걸어보기 
-- 테이블 생성하면서 제약조건걸기 
CREATE TABLE MEMBER2
   (	
   	ID NUMBER(10) PRIMARY KEY , -- 컬럼레벨
	PW VARCHAR2(10), 
	NAME VARCHAR2(10), 
	TEL VARCHAR2(10)
   );
  

CREATE TABLE BBS2
(	NO NUMBER(10), 
	TITLE VARCHAR2(100), 
	CONTENT VARCHAR2(100), 
	WRITER NUMBER(10), 
	 CONSTRAINT BBS_PK2 PRIMARY KEY (NO), -- 테이블레벨 
	 CONSTRAINT FK_MEMBER2 FOREIGN KEY (WRITER)
	 REFERENCES MEMBER2(ID)
); 


-- 만들어진 테이블에 제약조건걸기 
CREATE TABLE BBS3
(	NO NUMBER(10),
	TITLE VARCHAR2(100), 
	CONTENT VARCHAR2(100), 
	WRITER NUMBER(10)
);

--PK제약조건 추가 
ALTER TABLE BBS3
ADD CONSTRAINT BBS3_PK 
PRIMARY KEY (NO);


--FK제약조건 추가
ALTER TABLE BBS3 
ADD CONSTRAINT FK_MEMBER3 
FOREIGN KEY (WRITER) REFERENCES MEMBER2(ID);




--제약조건 
-- 테이블작성시 각 컬럼에 대해 값 기록에 대한 제약조건을 설정할수 있다. 
-- 데이터 무결성 보장을 목적으로함 
-- 입력 / 수정 하는 데이터에 문제가 없는지 자동으로 검사하는 목적
-- PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY






--NOT NULL : 해당 컬럼에 반드시 값을 기록해야하는경우 사용
--           삽입/ 수정시 NULL 값을 허용하지 않도록 '컬럼레벨에서 제한 '

/*--------------------------------------------------------------------    
-- 아무런 제약 조건이 설정되지않은경우 NULL 값이 문제없이 삽입 됨,
-- ex) 제약조건 없으면 회원가입시 정보를 입력 하지않아도 가입이 처리 됨..
--------------------------------------------------------------------  */    


-- UNIQUE  제약조건 : 컬럼에 입력값에대한 중복을 제한하는 제약조건  
--                   컬럼레벨, 테이블레벨에서 설정가능

/*-----------------------------------------------------------------------
--	※ 실제 데이터 확인히 중복된 값이 들어가도 처리가 됨
--	ex) 회원 가입시 중복된 아이디가 가입되면 회원들을 구분할수 없게 됨

--	 ※ 2개의 데이터를 삽입시 UNIQUE 제약 조건이 발생함
	UNIQUE 제약조건이 설정된 컬럼에는 중복 값은 넣을 수 없게 됨

	※ UNIQUE 제약 조건이 설정되었다 하더라도 NULL값으로 넣게 되면
	중복 처리가 되어 버림 
	이때 해결 방법은 UNIQUE 제약조건과 NOT NULL 제약 조건을 같이 주면 됨
------------------------------------------------------------------------*/    

--CHECK제약조건  : 컬럼에 기록되는 값에 조건을 설정할수있음
--CHECK(컬럼명 비교연산자 비교값 )
-- 주의 : 비교값은 리터럴만 사용 할수있음 , 변하는 값이나 함수는 사용 못함. (자동 NOT NULL  규칙이 적용됨)
--  GENDER VARCHAR2(10) CHECK(GENDER IN ('남','여')),



--PRIMARY KEY(기본키) 제약조건 
-- : 테이블에서 한행의 정보를 찾기위해 사용할 컬럼을 의미
-- 테이블에 대한 식별자 역할을 한다. 
-- NOT NULL+ UNIQUE제약조건의 의미
-- 한 테이블당 한개만 설정
-- 컬럼 레벨, 테이블 레벨 둘다 설정 가능함
-- 한개 컬럼에 설정할수 있고, 여러개 컬럼 묶어서(복합키) 설정 할수 있음 

--> VARCHAR2, CHAR의 차이 
--> VARCHAR2(100) : VAR(변하다, VARIABLE) + CHAR(문자)
-->           2글자이면 2글자들어갈 만큼만 저장공간을 사용
-->           100글자이면 100글자들어갈 만큼 저장공간을 저장 
--> CHAR(100) : 저장공간이 고정, 주민번호, 전화번호, 우편번호, 사번 

CREATE TABLE MEMBER4 
(	ID VARCHAR2(100) PRIMARY KEY, -- 컬럼레벨 에서 지정
	PW VARCHAR2(100) NOT NULL, 
	NAME VARCHAR2(100) NOT NULL, 
	TEL VARCHAR2(100)
--	CONSTRAINT CK_GENDER CHECK(GENDER IN ('남','여')),

);




-- FOREIGN KEY(외부키 / 외래키) 제약조건 : 
-- 참조(REFERENCES)된 다른 테이블에서 제공하는 값만 사용할 수 있음
-- 참조 무결성을 위배하지 않게 하기 위해 사용
-- FOREIGN KEY제약조건에 의해서 
-- 테이블간의 관계(RELATIONSHIP)가 형성됨--> JOIN이 가능해짐 
-- 제공되는 값 외에는 NULL을 사용할 수 있음

-- 컬럼레벨일 경우
-- 컬럼명 자료형(크기) [CONSTRAINT 이름] REFERENCES 참조할테이블명 [(참조할컬럼)] [삭제룰]

-- 테이블 레벨일 경우
-- [CONSTRAINT 이름] FOREIGN KEY (적용할컬럼명) REFERENCES 참조할테이블명 [(참조할컬럼)] [삭제룰]


-- 참조할 테이블의 참조할 컬럼명이 생략되면
-- PRIMARY KEY로 설정된 컬럼이 자동 참조할 컬럼이 됨
-- 참조될 수 있는 컬럼은 PRIMARY KEY 컬럼과,
-- UNIQUE 지정된 컬럼만 외래키로 사용할 수 있음

--PPT129 참고 만들어보기 
CREATE TABLE BBS4
(
  NO NUMBER, 
  TITLE VARCHAR2(100), 
  CONTENT VARCHAR2(100), 
  WRITER VARCHAR2(100), 
  CONSTRAINT PK_BBS4 PRIMARY KEY (NO),
  CONSTRAINT FK_BBS_WRITER4 FOREIGN KEY (WRITER) REFERENCES MEMBER4(ID)
 );


--REPLY4 
--ID - PK
--ORIID  NOTNULL
--CONTENT
--WRITER NOTNULL
--
--
--MEMBER4 ID
--BBT4 NO
CREATE TABLE REPLY4 
   (	ID NUMBER primary key, 
		ORIID NUMBER NOT NULL , -- 게시판 번호 
		CONTENT VARCHAR2(100), 
		WRITER VARCHAR2(100) NOT NULL ,
	 CONSTRAINT FK_REPLY_WRITER FOREIGN KEY (WRITER) REFERENCES MEMBER4(ID),
	 CONSTRAINT FK_REPLY_ORIID FOREIGN KEY (ORIID) REFERENCES BBS4(NO)
) ;




CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE
VALUES(10, '일반회원');

INSERT INTO USER_GRADE
VALUES(20, '우수회원');

INSERT INTO USER_GRADE
VALUES(30, '특별회원');

SELECT * FROM USER_GRADE;

SELECT * FROM USER_FOREIGNKEY;


CREATE TABLE USER_FOREIGNKEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_GRADE_CODE FOREIGN KEY (GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE)
);


INSERT INTO USER_FOREIGNKEY
    (USER_NO, USER_ID , USER_PWD , USER_NAME , GENDER , PHONE , EMAIL , GRADE_CODE)
    VALUES
    (1, 'user01', 'pass01', '유재석', '남', '010-1234-5678', 'yu@naver.or.kr' ,10);
INSERT INTO USER_FOREIGNKEY
    (USER_NO, USER_ID , USER_PWD , USER_NAME , GENDER , PHONE , EMAIL , GRADE_CODE)
    VALUES
    (2, 'user02', 'pass02', '유재석', '남', '010-1234-5678', 'yu@naver.or.kr' ,10);
   
INSERT INTO USER_FOREIGNKEY
    (USER_NO, USER_ID , USER_PWD , USER_NAME , GENDER , PHONE , EMAIL , GRADE_CODE)
    VALUES
    (3, 'user03', 'pass03', '유재석', '남', '010-1234-5678', 'yu@naver.or.kr' ,NULL);
   
INSERT INTO USER_FOREIGNKEY
    (USER_NO, USER_ID , USER_PWD , USER_NAME , GENDER , PHONE , EMAIL , GRADE_CODE)
    VALUES
    (4, 'user04', 'pass04', '유재석', '남', '010-1234-5678', 'yu@naver.or.kr' ,50);-- ORA-02291: integrity constraint (SCOTT.FK_GRADE_CODE) violated - parent key not found
 INSERT INTO USER_FOREIGNKEY
    (USER_NO, USER_ID , USER_PWD , USER_NAME , GENDER , PHONE , EMAIL , GRADE_CODE)
    VALUES
    (5, 'user05', 'pass05', '유재석', '남', '010-1234-5678', 'yu@naver.or.kr' ,30);
 COMMIT;
 


SELECT *
FROM USER_FOREIGNKEY A
NATURAL LEFT JOIN  USER_GRADE B;




-- 삭제 옵션
--: 부모테이블의 데이터 삭제시 자식 테이블의 데이터를 어떤식으로 처리할지에 대한 내용 설정

SELECT 
	*
FROM USER_GRADE 
WHERE GRADE_CODE = 10;


DELETE 
FROM USER_GRADE 
WHERE GRADE_CODE = 10; --ORA-02292: integrity constraint (SCOTT.FK_GRADE_CODE) violated - child record found


DELETE 
FROM USER_GRADE 
WHERE GRADE_CODE = 20;

COMMIT;

-- ON DELETE RESTRICTED 기본적으로 지정되어있음

 SELECT 
    UC.TABLE_NAME
    , UCC.COLUMN_NAME
    , UC.CONSTRAINT_NAME
    , UC.CONSTRAINT_TYPE
FROM SYS.USER_CONSTRAINTS UC
JOIN SYS.USER_CONS_COLUMNS UCC ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
WHERE UCC.CONSTRAINT_NAME = 'FK_GRADE_CODE';

SELECT
*
FROM SYS.USER_CONSTRAINTS;



-- ON DELETE SET NULL : 부모키 삭제시 자식키를 NULL로  변경 하는 옵션

CREATE TABLE USER_GRADE2(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2
VALUES(10, '일반');

INSERT INTO USER_GRADE2
VALUES(20, '골드');

INSERT INTO USER_GRADE2
VALUES(30, '사파이어');


CREATE TABLE USER_FOREIGNKEY2(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_GRADE_CODE2 FOREIGN KEY (GRADE_CODE) REFERENCES USER_GRADE2(GRADE_CODE) ON DELETE SET NULL
 );
INSERT INTO USER_FOREIGNKEY2
    (USER_NO, USER_ID , USER_PWD , USER_NAME , GENDER , PHONE , EMAIL , GRADE_CODE)
    VALUES
    (1, 'user01', 'pass01', '유재석', '남', '010-1234-5678', 'yu@naver.or.kr' ,10);
INSERT INTO USER_FOREIGNKEY2
    (USER_NO, USER_ID , USER_PWD , USER_NAME , GENDER , PHONE , EMAIL , GRADE_CODE)
    VALUES
    (2, 'user02', 'pass02', '유재석', '남', '010-1234-5678', 'yu@naver.or.kr' ,10);
   
INSERT INTO USER_FOREIGNKEY2
    (USER_NO, USER_ID , USER_PWD , USER_NAME , GENDER , PHONE , EMAIL , GRADE_CODE)
    VALUES
    (3, 'user03', 'pass03', '유재석', '남', '010-1234-5678', 'yu@naver.or.kr' ,NULL);
INSERT INTO USER_FOREIGNKEY2
    (USER_NO, USER_ID , USER_PWD , USER_NAME , GENDER , PHONE , EMAIL , GRADE_CODE)
    VALUES
    (5, 'user05', 'pass05', '유재석', '남', '010-1234-5678', 'yu@naver.or.kr' ,30);
 COMMIT;
 


DELETE 
FROM USER_GRADE2 
WHERE GRADE_CODE = 10;

SELECT * FROM USER_GRADE2;
SELECT * FROM USER_FOREIGNKEY2 ;



-- ON DELETE CASCADE : 부모키 삭제시 자식키를 가진 행도 함께 삭제 

CREATE TABLE USER_GRADE3(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE3
VALUES(10, '일반');

INSERT INTO USER_GRADE3
VALUES(20, '골드');

INSERT INTO USER_GRADE3
VALUES(30, '사파이어');


CREATE TABLE USER_FOREIGNKEY3(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_GRADE_CODE3 FOREIGN KEY (GRADE_CODE) REFERENCES USER_GRADE3(GRADE_CODE)  ON DELETE CASCADE

);


INSERT INTO USER_FOREIGNKEY3
    (USER_NO, USER_ID , USER_PWD , USER_NAME , GENDER , PHONE , EMAIL , GRADE_CODE)
    VALUES
    (1, 'user01', 'pass01', '유재석', '남', '010-1234-5678', 'yu@naver.or.kr' ,10);
INSERT INTO USER_FOREIGNKEY3
    (USER_NO, USER_ID , USER_PWD , USER_NAME , GENDER , PHONE , EMAIL , GRADE_CODE)
    VALUES
    (2, 'user02', 'pass02', '유재석', '남', '010-1234-5678', 'yu@naver.or.kr' ,10);
   
INSERT INTO USER_FOREIGNKEY3
    (USER_NO, USER_ID , USER_PWD , USER_NAME , GENDER , PHONE , EMAIL , GRADE_CODE)
    VALUES
    (3, 'user03', 'pass03', '유재석', '남', '010-1234-5678', 'yu@naver.or.kr' ,NULL);
INSERT INTO USER_FOREIGNKEY3
    (USER_NO, USER_ID , USER_PWD , USER_NAME , GENDER , PHONE , EMAIL , GRADE_CODE)
    VALUES
    (5, 'user05', 'pass05', '유재석', '남', '010-1234-5678', 'yu@naver.or.kr' ,30);
 COMMIT;
 


DELETE 
FROM USER_GRADE3 
WHERE GRADE_CODE = 10;
COMMIT;
SELECT * FROM USER_GRADE3;
SELECT * FROM USER_FOREIGNKEY3 ;



-- 서브쿼리를 이용한 테이블 생성(컬럼명 , 데이터 타입 , 값이 복사되고 , 제약조건은 NOT NULL 만 복사됨)

INSERT INTO MEMBER4  VALUES('200','100', 'park','011' );
COMMIT;


SELECT * FROM MEMBER4 ;



CREATE TABLE MEMBER5
AS SELECT * FROM MEMBER4;

SELECT * FROM MEMBER5 ;

SELECT * 
FROM MEMBER4 
WHERE 1=1
AND ID = 100
AND PW = 100;

DROP TABLE MEMBER5;
-- 구조만 복사하고싶을때 
CREATE TABLE MEMBER5
AS SELECT * FROM MEMBER4 WHERE 1=0;

SELECT * FROM MEMBER5 ;



--
--ALTER : 객체를 수정하는 구문
--ALTER TABLE 테이블명 수정내용;
--컬럼추가/삭제/변경,제약조건 추가/삭제/변경
--테이블명면경, 제약조건이름변경
-----------------------------------------------  


--컬럼추가

--제약조건 추가 
-- ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명)
-- ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명) REFERENCES 테이블명 (컬럼명)
-- ALTER TABLE 테이블명 ADD UNIQUE(컬럼명)
-- ALTER TABLE 테이블명 ADD CHECK(컬럼명 비교연산자 비교값)
-- ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL


ALTER TABLE MEMBER5 ADD PRIMARY KEY(ID);
ALTER TABLE MEMBER5 MODIFY NAME NULL; -- 이미 NOT NULL 이면 NULL 로 변경




CREATE TABLE TEST11(
	ID VARCHAR2(100) PRIMARY KEY,
	NAME VARCHAR2(100) UNIQUE
);
INSERT INTO TEST11 VALUES('123', '123');
INSERT INTO TEST11 VALUES('111', '111');

CREATE TABLE TEST22(
	ID VARCHAR2(100),
	NAME VARCHAR2(100),
	TEST_ID VARCHAR2(100) REFERENCES "SCOTT"."TEST11" (ID)
);
INSERT INTO TEST22 VALUES('111', '111', '122'); --SQL ERROR [2291] [23000]: ORA-02291: INTEGRITY CONSTRAINT (SCOTT.SYS_C007414) VIOLATED - PARENT KEY NOT FOUND
INSERT INTO TEST22 VALUES('111', '111', '123');

COMMIT;
SELECT * FROM TEST22;
-- 컬럼추가
-- ALTER TABLE 테이블명  ADD (컬럼명  데이터타입)
ALTER TABLE TEST22  ADD ADDR  VARCHAR2(100);

-- -- 컬럼자료형 수정 - 
-- 컬럼의 크기 줄이는 경우 
-- 변경하려는 크기를 초과하는 값이 없을 때 만 수정할수 있다. 
-- ALTER TABLE 테이블명  MODIFY (컬럼명  데이터타입)
ALTER TABLE TEST22  MODIFY ADDR  VARCHAR2(200);

-- 컬럼이름변경
ALTER TABLE TEST22
RENAME COLUMN  ADDR TO ADDR2;

-- 컬럼생성시 DEFAULT 값 지정
ALTER TABLE TEST22  
ADD(LOC VARCHAR2(20) DEFAULT '한국');



-- 컬럼에 제약조건 추가 
ALTER TABLE TEST22
ADD CONSTRAINT PK_TEST22_ID PRIMARY KEY (ID);

ALTER TABLE TEST22
ADD CONSTRAINT UN_TEST22_NAME  UNIQUE (NAME );


ALTER TABLE TEST22
MODIFY LOC CONSTRAINT NN_LOC  NOT NULL;



-- 제약조건 1개 삭제시 
ALTER TABLE TEST22
DROP CONSTRAINT PK_TEST22_ID;

-- 제약조건 여러개 삭제시  --NOT NULL 제약조건 삭제시 MODIFY사용
ALTER TABLE TEST22
DROP CONSTRAINT PK_TEST22_ID 
DROP CONSTRAINT UN_TEST22_NAME;

ALTER TABLE TEST22 MODIFY LOC CONSTRAINT NN_LOC NULL;

-- 컬럼삭제

-- 컬럼삭제 : DROP COLUMN 삭제할 컬럼명
-- 데이터가 기록되어있어도 삭제됨
-- 삭제된 컬럼은 복구 불가능 
-- 테이블에는 최소 한개의 컬럼이 존재해야함 : 모든 컬럼 삭제 불가능 
-- 컬럼 삭제시 참조하고있는 컬럼이 있다면 삭제할수 없다 
-- ALTER TABLE 테이블명  DROP  COLUMN   컬럼명;


ALTER TABLE TEST22  DROP COLUMN ADDR2 ;
ALTER TABLE TEST22  DROP COLUMN TEST_ID ; 
--제약조건도 함께 컬럼 삭제
ALTER TABLE TEST22  
DROP COLUMN TEST_ID CASCADE CONSTRAINT;

-- CASCADE CONSTRAINT : 제약조건 까지 함께 삭제
DROP TABLE TEST11 CASCADE CONSTRAINT; 
DROP TABLE TEST22;




/*
@ 3개의 데이터 딕셔너리 뷰 (Data Dictionary View)


1. DBA_XXXX : 데이터 베이스 관리자만 접근이 가능한 객체 등의 정보 조회
	(DBA는 모든 접근이 가능하므로 결국 디비에 있는 모든 객체에 대한 조회가 됨) 

2. ALL_XXXX : 자신의 계정이 소유하거나 권한을 부여받은 객체 등에 관한 정보 조회

3. USER_XXXX : 자신의 계정이 소유한 객체 등에 관한 정보 조회

*/
SELECT  * FROM USER_TABLES; --테이블의정보
SELECT * FROM USER_TAB_COLUMNS; --테이블내컬럼정보
SELECT * FROM USER_VIEWS;--뷰정보
SELECT * FROM USER_CONSTRAINTS;--테이블의 제약조건 검색
SELECT * FROM USER_CONS_COLUMNS;--컬럼의 제약조건 검색