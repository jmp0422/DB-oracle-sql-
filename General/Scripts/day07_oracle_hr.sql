-- New script in localhost 4.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//localhost:1521/XE
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 5. 14.
-- Time: 오후 1:01:52

--VIEW (뷰)
--SELECT 쿼리문을 저장한 객체이다
--실질적인 데이터를 저장하고 있지않음
--테이블을 사용하는 것과 동일하게 사용할수있다.
--매번 자주 사용하는 쿼리문을 정의 해 두고 싶을때 뷰를 생성
--VIEW 를 한번 만들어두고 마치 테이블처럼 사용한다고 생각!
--CREATE [OR REPLACE] VIEW 뷰이름 AS 서브쿼리

CREATE OR REPLACE VIEW V_EMP
(사번, 이름, 부서)
AS
SELECT employee_id, FIRST_name || ' '|| last_name name, Department_id
FROM EMPLOYEES;

SELECT * FROM V_EMP;
DROP VIEW V_EMP;
-- 사번 , 이름 , 직급명, 부서명 , 근무지역(시티명)을 조회하고, 
--그결과를 V_RESULT_EMP 라는 뷰를 생성해서 저장하세요
SELECT * FROM V_RESULT_EMP;

CREATE OR REPLACE VIEW V_RESULT_EMP
AS
SELECT A.employee_id, FIRST_name || ' '|| last_name name, B.JOB_TITLE,C.DEPARTMENT_NAME, D.CITY
FROM EMPLOYEES A
LEFT JOIN JOBS B ON A.JOB_ID = B.JOB_ID
LEFT JOIN DEPARTMENTS C ON A.DEPARTMENT_ID = C.DEPARTMENT_ID
LEFT JOIN LOCATIONS D ON C.LOCATION_ID = D.LOCATION_ID;

SELECT * FROM SYS.USER_VIEWS;

UPDATE EMPLOYEES
SET FIRST_NAME = 'LISA'
WHERE EMPLOYEE_ID = '205';

CREATE OR REPLACE VIEW V_EMP_JOB
(사번, 이름 , 직급명, 근무년수)
AS
SELECT 
    A.EMPLOYEE_ID
    , FIRST_NAME ||' ' || LAST_NAME EMP_NAME
    , B.JOB_TITLE
    ,EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM A.HIRE_DATE)
FROM EMPLOYEES A    
LEFT JOIN JOBS B ON A.JOB_ID = B.JOB_ID ;

SELECT * FROM V_EMP_JOB;

CREATE OR REPLACE VIEW V_JOBS
AS
SELECT 
    JOB_ID
    , JOB_TITLE
FROM JOBS;
SELECT * FROM JOBS;
SELECT * FROM V_JOBS;

-- 생성된 뷰를 이용해서 DML(INSERT, UPDATE, DELETE)사용가능
-- 뷰를 통해 변경하게되면 실제 데이터가 담겨있는 베이스 테이블에도 적용된다.
-- 뷰에 INSERT
INSERT INTO V_JOBS
    (JOB_ID, JOB_TITLE)
VALUES
    ('MULTI','MULTI');
   
   -- 뷰에 UPDATE
UPDATE V_JOBS
SET JOB_TITLE = 'YouTuber'
WHERE JOB_ID = 'MULTI';


-- 뷰에 DELETE
DELETE FROM V_JOBS WHERE JOB_ID = 'MULTI';

-- DML 명령어로 조작이 불가능한 경우
-- 1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
-- 2. 뷰에 포함되지 않은 컬럼 중에,
--    베이스가 되는 테이블 컬럼이 NOT NULL 제약조건이 지정된 경우
-- 3. 산술표현식으로 정의된 경우
-- 4. JOIN을 이용해 여러 테이블을 연결한 경우
-- 5. DISTINCT 포함한 경우
-- 6. 그룹함수나 GROUP BY 절을 포함한 경우

CREATE OR REPLACE VIEW V_GROUPDEPT
AS
SELECT 
    DEPARTMENT_ID,
    SUM(SALARY)합계,
    AVG(SALARY)평균
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;


SELECT * FROM V_GROUPDEPT;

INSERT INTO V_GROUPDEPT--SQL 오류: ORA-01733: virtual column not allowed here
    (DEPARTMENT_ID, 합계, 평균)
VALUES
    ('999',6000000,400000);
    
--ORA-01732 : 데이터 조작 작업이이 뷰에서 유효하지 않습니다    
UPDATE V_GROUPDEPT
SET DEPARTMENT_ID = 'D10'
WHERE DEPARTMENT_ID = 'D1';--SQL 오류: ORA-01732: data manipulation operation not legal on this view


DELETE FROM V_GROUPDEPT WHERE DEPARTMENT_ID = 'D1';--SQL 오류: ORA-01732: data manipulation operation not legal on this view

/* VIEW 옵션
    
    [상세 표현식]
    CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW 뷰명
    AS SUBQUERY
    [WITH CHECK OPTION]
    [WITH READ ONLY];
    
    1) OR REPLACE 옵션 : 기존에 동일한 뷰가 있을경우 덮어쓰고, 존재하지 않으면 새로이 생성시켜주는
    2) FORCE/NOFORCE 옵션
       FORCE : 서브쿼리에 기술된 테이블이 존재하지 않는 테이블이여도 뷰가 생성
       NOFORCE : 서브쿼리에 기술된 테이블이 존재해야만 뷰가 생성 (생략시 기본값)
    3) WITH CHECK OPTION 옵션 : 서브쿼리에 기술된 조건에 부합하지 않은 값으로 수정하는 경우 오류 발생
    4) WITH READ ONLY 옵션 : 뷰에 대해 조회만 가능 (DML 수행 불가)
*/

-- FORCE : 서브쿼리에 기술된 테이블이 존재하지 않는 테이블이여도 뷰가 생성-- 일반적으로 잘사용되지않음
--> 경고: 컴파일오류와 함께 뷰가 생성되었습니다. 
CREATE OR REPLACE FORCE VIEW V_EMP
AS
SELECT 
    TCODE,
    TNAME,
    TCONTENT
FROM TT;

SELECT
    *
FROM V_EMP;

CREATE TABLE TT(--> TT 테이블을 생성하면 VIEW 조회가 가능해진다
    TCODE NUMBER,
    TNAME VARCHAR2(10),
    TCONTENT VARCHAR2(20)
    );
    
DROP TABLE TT;

-- NOFORCE : 서브쿼리에 기술된 테이블이 존재해야만 뷰가 생성 (생략시 기본값)
CREATE OR REPLACE /*NOFORCE*/ VIEW V_EMP2
AS
SELECT 
    TCODE,
    TNAME,
    TCONTENT
FROM TT;


-- WITH CHECK OPTION 옵션 : 서브쿼리에 기술된 조건에 부합하지 않은 값으로 수정하는 경우 오류 발생
CREATE OR REPLACE VIEW VW_EMP2
AS
SELECT * 
FROM EMPLOYEES
WHERE SALARY >= 10000;

SELECT * FROM VW_EMP2;

--100 번 사원의 급여를 1000원으로 변경 --> 서브쿼리 조건에 부합하지 않아도 잘변경됨
UPDATE VW_EMP2
SET SALARY =1000
WHERE EMPLOYEE_ID =100;
ROLLBACK;

CREATE OR REPLACE VIEW VW_EMP2
AS
SELECT * 
FROM EMPLOYEES
WHERE SALARY >= 10000
WITH CHECK OPTION;

UPDATE VW_EMP2
SET SALARY = 10000
WHERE EMPLOYEE_ID = 101;

UPDATE VW_EMP2
SET SALARY =100000
WHERE EMPLOYEE_ID =201;

SELECT * FROM VW_EMP2

--WITH READ ONLY 옵션 : 뷰에 대해 조회만 가능 (DML 수행 불가)
CREATE OR REPLACE VIEW V_DEPT
AS
SELECT * FROM DEPARTMENTS
WITH READ ONLY;

SELECT * FROM V_DEPT;
DELETE FROM V_DEPT;--SQL 오류: ORA-42399: cannot perform a DML operation on a read-only VIEW

-- 트리거(TRIGGER)
--> 데이터베이스가 미리 정해놓은 조건을 만족하거나 어떠한 동작이 수행되면
--자동적으로 수행되는 객체를 의미
--	- 트리거의 사전적 의미 : 연쇄 반응
--> 트리거는 테이블이나 뷰가 INSERT, UPDATE, DELETE등의 DML문에 의해 데이터가 입력,수정,삭제
--될 경우 자동으로 실행 됨 


-- 트리거의 실행 시점
--> 트리거 실행 시점을 이벤트 전(BEFORE)이나 이벤트 후(AFTER)로 지정하여 설정

-- 트리거의 이벤트
--> 트리거의 이벤트는 사용자가 어떤 DML(INSERT, UPDATE, DELETE)문을 실행했을 때 트리거를
--발생시킬 것인지를 결정

-- 트리거의 몸체
--> 트리거의 몸체는 해당 타이밍에 해당 이벤트가 발생했을 때 실행될 기본 로직이
--포함되는 부분으로 BEGIN ~ END에 안에 작성함

-- 트리거의 유형
--> 트리거의 유형은 FOR EACH ROW에 의해 문장 레벨 트리거와 행 레벨 트리거로 나뉨
--> FOR EACH ROW가 생략되면 "문장 레벨 트리거"
--> FOR EACH ROW가 정의되면 "행 레벨 트리거"
--> 문장 레벨 트리거는 어떤 사용자가 트리거가 설정되어 있는 테이블에 대해
--DML(INSERT, UPDATE, DELETE)문을 실행시킬 때 트리거를 단 한번 발생 시킴
--> 행 레벨 트리거는 DML(INSERT,UPDATE,DELETE)에 의해서 여러 개의 행이 변경된다면
--각 행이 변경될때마다 트리거를 발생시키는 방법
--	(만약 5개의 행이 변경되면 5번의 트리거가 발생함)

-- 트리거의 조건
--> 트리거의 조건은 행 레벨 트리거에서만 설정할 수 있으며 트리거 이벤트에 정의된
--테이블에 이벤트가 발생할 때보다 구체적인 데이터 검색 조건을 부여할 때 사용됨

SELECT * FROM ALL_TRIGGERS;
SELECT * FROM USER_TRIGGERS;

  SELECT * 
  FROM EMPLOYEES 
   WHERE EMPLOYEE_ID = 100;
  
   SELECT * FROM JOB_HISTORY WHERE EMPLOYEE_ID = 100;
   
UPDATE EMPLOYEES SET 
  JOB_ID = 'FI_MGR'
WHERE EMPLOYEE_ID = 100;

--단순 메세지를 출력하는 트리거 작성(문장트리거)
-- 사원 테이블에 새로운데이터가 들어오면 신입사원이 입사하였습니다 를 출력하기


CREATE OR REPLACE TRIGGER TRG_01 AFTER
    INSERT ON EMPLOYEES
BEGIN 
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다. ');
END;
--#Ctrl + Shift + O 키를 입력하면 Output 창을 표시
INSERT INTO EMPLOYEES
(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
VALUES(996, '강', '송', 'gd', '010', '20210101', 'FI_MGR', 100000, 0, 100, 10);



-- 제품이 입고될때마다 상품재고 테이블의 수치를 관리자가 수동으로 관리하면 불편함
-- 이때 트리거를 이용하여 재고가 입출고시 자동으로 입력되도록 해보자

-- 제품테이블 생성
CREATE TABLE PRODUCT(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(30),
    BRAND VARCHAR2(30),
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0
);
-- 제춤입출고 테이블생성
CREATE TABLE PRO_DETAIL(
    DCODE NUMBER PRIMARY KEY,
    PCODE NUMBER,
    PDATE DATE,
    AMOUNT NUMBER,
    STATUS VARCHAR2(10) CHECK(STATUS IN ('입고', '출고')),
    FOREIGN KEY(PCODE) REFERENCES PRODUCT(PCODE)

);
--SEQUENCE생성
CREATE SEQUENCE SEQ_PCODE;
CREATE SEQUENCE SEQ_DCODE;

SELECT * FROM PRODUCT;
SELECT * FROM PRO_DETAIL;

INSERT INTO PRODUCT
VALUES (SEQ_PCODE.NEXTVAL,  '울트라', 'SS' , 900000 , DEFAULT);

INSERT INTO PRODUCT
VALUES (SEQ_PCODE.NEXTVAL,  '아이폰', 'AP' , 900000 , DEFAULT);

INSERT INTO PRODUCT
VALUES (SEQ_PCODE.NEXTVAL,  '샤오미', 'SOM' , 900000 , DEFAULT);


-- 바인드 변수 2가지 
-- FOR EACH ROW를 사용해야함 
-- :NEW - 새로입력된 ( INSERT, UPDATE)데이터
-- :OLD - 기존데이터  ---------------------------이전에 job history에는 old 값이들어감

CREATE OR REPLACE TRIGGER TRG_02 AFTER
    INSERT ON PRO_DETAIL
    FOR EACH ROW
BEGIN
    IF :NEW.STATUS ='입고'
    THEN 
        UPDATE PRODUCT
        SET STOCK = STOCK + :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE;
    END IF;
    
    IF :NEW.STATUS ='출고'
    THEN 
        UPDATE PRODUCT
        SET STOCK = STOCK - :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE;
    END IF;
END;

INSERT INTO PRO_DETAIL VALUES( SEQ_DCODE.NEXTVAL, 1, SYSDATE , 5 ,'입고');
INSERT INTO PRO_DETAIL VALUES( SEQ_DCODE.NEXTVAL, 2, SYSDATE , 10 ,'입고');
INSERT INTO PRO_DETAIL VALUES( SEQ_DCODE.NEXTVAL, 3, SYSDATE , 20 ,'입고');

INSERT INTO PRO_DETAIL VALUES( SEQ_DCODE.NEXTVAL, 1, SYSDATE , 1 ,'출고');
INSERT INTO PRO_DETAIL VALUES( SEQ_DCODE.NEXTVAL, 2, SYSDATE , 5 ,'출고');
INSERT INTO PRO_DETAIL VALUES( SEQ_DCODE.NEXTVAL, 3, SYSDATE , 13 ,'출고');

SELECT * FROM PRODUCT;
SELECT * FROM PRO_DETAIL;