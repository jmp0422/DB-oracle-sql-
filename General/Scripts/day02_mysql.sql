-- CONNECTION: url=jdbc:oracle:thin:@//localhost:1521/XE




-- New script in localhost_M_ROOT.
-- Connection Type: dev 
-- Url: jdbc:mysql://localhost:3306/
-- workspace : C:\workspace\multi\03_db
-- Date: 2024. 5. 7.오후 2:28:37


-- mysql


-- DB(DataBase)란?
-- -> 한 조직에 필요한 정보를 여러 응용 시스템에서 공용할 수 있도록 논리적으로
-- 연관된 데이터를 모으고, 중복되는 데이터를 최소화하여 구조적으로 통합/저장해 놓은 것

-- Data란?
-- -> 어떠한 자료 혹은 실제 값을 의미함-흩어져있는 어떤자료
--	- 에베레스트의 높이 : 8848m (8848 미터 라는 데이터)

-- 정보란?
-- -> 데이터를 기반으로 하여 의미를 부여한 것-우리가 찾고자하는것 
--	 - 에베레스트는 세계에서 가장 높은 산 (가장 높은 산이라는 정보)

-- DBMS?
-- 데이터베이스에서 데이터를 추출, 조작, 정의, 제어 등을 할 수 있게 해주는 데이터베이스 전용 관리 프로그램
-- 데이터 독립화(데이터저장소를 변경하거나 데이터베이스 크기를 변경하더라도 기존 프로그램에 영향이 없어야한다)
-- 데이터 중복 최소화(데이터가 여러개 중복되어 저장되는것 방지 - 하나의 테이블에 저장하고 공유하여 중복을 최소화 )
-- 데이터 무결성 보장(데이터가 어떤경로로 들어오든 데이터에 오류가 있으면 안됨 - 제약조건을 두어 반드시 들어가야 하는 데이터 , 중복되면 안되는 데이터등을 관리 )



-- 스키마(schema)는 데이터베이스에서 데이터의 구조, 조직, 그리고 관계를 정의하는 틀 또는 청사진을 의미 
-- 데이터베이스 스키마는 데이터가 어떻게 저장될지, 데이터 간에 어떤 관계가 있는지, 데이터에 어떤 제약 조건이 적용되는지 등을 명시
-- 스키마는 데이터베이스를 설계할 때 논리적 구조를 제공


-- 오라클에서의 스키마
-- 오라클에서 "스키마"는 데이터베이스 사용자에게 소속된 객체(테이블, 뷰, 인덱스, 스토어드 프로시저 등)의 집합을 의미
-- 오라클에서 스키마를 생성한다는 것은 사실상 사용자를 생성하는 것이며 해당 사용자에게 소속된 데이터베이스 객체를 관리하는 것
-- 오라클 데이터베이스는 여러 스키마를 포함할 수 있으며, 각 스키마는 고유한 사용자에 의해 소유되고 관리됨



-- MySQL에서의 데이터베이스
-- MySQL에서 "데이터베이스"는 스키마와 거의 동일한 개념으로 사용됨 .
-- MySQL에서 데이터베이스를 생성하면, 그 데이터베이스 내에 테이블, 뷰, 인덱스 등을 생성할 수 있는 논리적 컨테이너로 취급하며, 각 데이터베이스는 서로 독립적인 객체 집합을 가짐.
-- MySQL에서는 사용자와 데이터베이스가 명시적으로 연결되지 않습니다. 대신, 사용자에게 특정 데이터베이스에 대한 접근 권한을 부여할 수 있습니다.

-- 차이점
-- 오라클에서는 "스키마"가 사용자와 직접 연결되어 사용자별로 데이터베이스 객체를 관리하는 개념. 
-- 반면, MySQL에서는 "데이터베이스"가 이러한 역할을 하며, 사용자는 별도로 권한을 부여받아 여러 데이터베이스에 접근할 수 있다. 

-- 구조적 차이: 오라클에서는 데이터베이스 내부에 여러 스키마(사용자)가 존재할 수 있으며, 각 스키마는 자신의 객체를 가짐
--          MySQL에서는 각 데이터베이스가 독립적인 객체 집합을 가지며, 사용자는 권한에 따라 하나 이상의 데이터베이스에 접근가능함
-- 관리 방식: 오라클에서는 스키마(사용자) 생성 시 데이터베이스 객체에 대한 권리가 함께 부여되고 
--          MySQL에서는 데이터베이스를 생성한 후, 별도로 사용자에게 해당 데이터베이스에 대한 접근 권한을 설정해야함
SHOW DATABASES;


SELECT * FROM mysql.user;


SHOW GRANTS;




-- 데이터 베이스 생성 
-- CREATE DATABASE DB명 ;
CREATE DATABASE scott;

-- 'localhost' 대신 '%' 을 사용할 경우 외부에서도 접속 가능
-- CREATE USER '사용자아이디'@'접속허용IP' IDENTIFIED BY '비밀번호';
-- GRANT ALL PRIVILEGES ON 권한허용DB명.* TO '사용자아이디' @ '접속허용IP';

-- CREATE USER 'scott'@'localhost' IDENTIFIED BY 'tiger';
CREATE USER scott@'%' IDENTIFIED BY 'tiger'; -- 외부에서 접속가능하다 

-- 모든 DATABASE 및 모든 TABLE에 대한 접근 허용
-- GRANT ALL PRIVILEGES ON *.* TO '사용자아이디'@'접속허용IP';
GRANT ALL PRIVILEGES ON scott.* TO 'scott'@'%';

-- 사용자에게 모든 데이터베이스, 모든 테이블에 대한 권한을 주면서 유저가 생성
-- GRANT ALL PRIVILEGES ON *.* '사용자아이디'@'접속허용IP' IDENTIFIED BY '비밀번호';
GRANT ALL PRIVILEGES ON *.* TO 'scott'@'%';


CREATE USER hr@'%' IDENTIFIED BY 'hr'; 
GRANT ALL PRIVILEGES ON *.* TO 'hr'@'%';


-- 권한삭제
-- 사용자는 필요한데 권한을 삭제하고 싶은 경우
-- 기본형식 (사용자 삭제아닙니다) --
-- REVOKE ALL ON DB명.테이블명 FROM 사용자아이디;

-- 사용자의 모든권한 삭제 --
-- REVOKE ALL ON *.* FROM 사용자아이디;
REVOKE ALL ON *.* FROM 'hr'@'%';


SHOW GRANTS;
-- -- 해당 사용자의 권한이 조회됨 --
-- SHOW GRANTS FOR 사용자아이디@접속허용IP
SHOW GRANTS FOR 'hr'@'%'; -- GRANT USAGE ON *.* TO `hr`@`%`   사용자가 접속할수있는권한


-- 유저 삭제
-- 사용자 아이디 삭제 --
-- DROP USER '사용자아이디';
DROP USER 'hr'@'%';
-- DROP USER 'hr'@'localhost';-- 특정호스트 삭제 



use scott;

CREATE TABLE BONUS

(

ENAME VARCHAR(10),

JOB VARCHAR(9),

SAL INT(11),

COMM INT(11)

);
-- mysql 8.0.17 버전부터 int 타입에 길이 설정하는 건 더 이상 지원하지 않기로 하고 향후 버전부터는 제거될 기능 중 하나라서 경고
-- Integer display width is deprecated and will be removed in a future release.

CREATE TABLE DEPT
(
DEPTNO INT,
DNAME VARCHAR(14),
LOC VARCHAR(13)
);



CREATE TABLE EMP
(
EMPNO INT,
ENAME VARCHAR(10),
JOB VARCHAR(9),
MGR INT,
HIREDATE DATE,
SAL INT,
COMM DECIMAL(7,2),
DEPTNO INT
);




CREATE TABLE SALGRADE
(
GRADE INT,
LOSAL  INT,
HISAL  INT
);



ALTER TABLE DEPT ADD (
CONSTRAINT PK_DEPT
PRIMARY KEY
(DEPTNO));

 

ALTER TABLE EMP ADD (
CONSTRAINT PK_EMP
PRIMARY KEY
(EMPNO));

 
ALTER TABLE EMP ADD (
CONSTRAINT FK_DEPTNO
FOREIGN KEY (DEPTNO)
REFERENCES DEPT (DEPTNO));






-- -----------------------------

USE scott;

CREATE TABLE member(
	id int PRIMARY KEY,
	pw varchar(10),
	name varchar(10),
	tel varchar(10),
	create_date timestamp

);


SELECT * FROM MEMBER;


