-- New script in localhost 3.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//localhost:1521/XE
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 5. 10.
-- Time: 오전 11:11:40

--@SET SPERATION(집합연산)
-- 두개이상의 테이블에서 조인을 사용하지않고 연관된 데이터를 조회하는 방법
-- 여러개의 질의 결과를 연결하여 하나로 결합하는 방식 
-- 각테이블의 조회결과를 하나의 테이블에 합쳐서 반환함 

-- 조건 : SELECT 절의 "컬럼수가 동일"해야함
--       SELECT 절의 동일 위채에 존재하는 "컬럼의 데이터 타입이 상호호환"가능해야함.

-- UNION, UNION ALL, INTERSECT, MINUS

-- UNION : 여러개의 쿼리결과를 하나로 합치는 연산자이다. 
--         중복된 영역의 제외하여 하나로 합친다.
-- UNION ALL : 중복값도 다 하나로합침
-- INTERSECT : 교집합
-- MINUS : 차집합
SELECT
	EMPNO,
	ENAME,
	DEPTNO,
	SAL
FROM EMP WHERE DEPTNO ='10'  --6명
--UNION --12명(중복제거) // UNION ALL때는 14명 그대로 나옴
--INTERSECT --2명이나옴(중복되었던 사람)
MINUS --4명(중복이었던사람 제거)
SELECT
	EMPNO,
	ENAME,
	DEPTNO,
	SAL
FROM EMP WHERE SAL > 1500; --8명

SELECT 
    DEPTNO
    , JOB
    , MGR
    , FLOOR(AVG(SAL))
FROM EMP
GROUP BY  DEPTNO, JOB, MGR
UNION ALL
SELECT 
    DEPTNO
    , '' JOB
    , MGR
    , FLOOR(AVG(SAL))
FROM EMP
GROUP BY  DEPTNO, MGR;

------------------------------------------------------------------------
--집계함수 

--ROLLUP 함수 : 그룹별로 중간 집계 처리를 하는 함수 
--GROUP BY 절에서만 사용 
--CUBE 함수 : 그룹별 산출한 결과를 집계하는 함수이다. 

-- 그룹별로 묶여진 값에 중간집계와 총집계를 구할때 사용
-- 그룹별로 계산된 값에대한 총집계가 자동으로 추가된다. 
-- 인자로 전달한 그룹중에서 가장 먼저 지정한 그룹(컬럼)별 합계와 총합계

SELECT * FROM EMP;
SELECT JOB,SUM(SAL) FROM EMP GROUP BY ROLLUP(JOB);

SELECT 
    JOB
    , SUM(SAL) 
FROM  EMP
GROUP BY CUBE(JOB)
ORDER BY 1;

SELECT
    DEPTNO
    , JOB
    ,SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1;

--GROUPING  함수 : ROLLUP이나 CUBE 에 의한 산출물이 
-- 인자로 전달받은 컬럼집합의 산출물이면 0
-- 아니면 1을 반환하는 함수
SELECT 
    DEPTNO
    ,JOB
    ,SUM(SAL)
    ,CASE
        WHEN GROUPING(DEPTNO) = 0 AND GROUPING(JOB) = 1 THEN '부서별합계'
        WHEN GROUPING(DEPTNO) = 1 AND GROUPING(JOB) = 0 THEN '직급별합계'
        WHEN GROUPING(DEPTNO) = 0 AND GROUPING(JOB) = 0 THEN '그룹별합계'
        ELSE '총합계'
    END 구분
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1;

/*@ 조인문(JOIN)
-> 여러테이블의 레코드를 조합하여 하나의 열로 표현한것, 하나로 합쳐서 결과를 조회한다. 
-> 두 개 이상의 테이블에서 연관성을 가지고있는 데이터 들을 따로 분류하여 새로운 가상의 테이블을 이용하여 출력
   서로다른 테이블에서 각각 공통값을 이용함으로써 필드를 조합함
   즉, 관계형 데이터베이스에서 SQL 문을 이용한 테이블간 "관계"를 맺는 방법
   
* JOIN 시 컬럼이 같을 경우와 다를 경우 2가지 방법이있다.
- ORACLE 전용구문
- ANSI 표준구문
(ANSI( 미국 국립 표준 협회 => 산업표준을 재정하는 단체 ) 에서 지정한 DBMS 에 상관없이 공통으로 사용하는 표준 SQL)
*/
--오라클 전용구문 
-- FROM 절에 ','  로 구분하여 합치게될 테이블명을 기술하고 
-- WHERE 절에 합치기위해 사용할 컬럼명을 명시한다.
-- JOIN: 왜 하는가? 검색을 하고 싶은데 항목들이 여러개의 테이블에 흩어져있는 경우
--      테이블을 모아서(합해서) 검색
-- 2개의 테이블의 공통된 값들만 조인해서 검색
---- INNER JOIN: 테이블간 공통된 값만 추출
---- EMP테이블과 DEPT테이블을 조인하세요.
---- 하나의 컬럼이상이 동일한 컬럼이 있어야 함.
---- EMPNO, ENAME, JOB, DEPTNO, LOC 컬럼 검색
---- 조인조건: DEPTNO


SELECT * FROM EMP;
SELECT * FROM DEPT;

--오라클 전용구문
SELECT * FROM EMP A ,DEPT B
WHERE A.DEPTNO = B.DEPTNO;

--ANSI 표준구문
--연결에 사용할 컬럼명이 같은경우에 USING(컬럼명)을 사용함
SELECT EMPNO,ENAME,JOB,DEPTNO,LOC 
FROM EMP 
JOIN DEPT USING(DEPTNO);

-- 연결에 사용할 컬럼명이 다를경우 ON(컬럼명) 을사용
SELECT EMPNO,ENAME,JOB,A.DEPTNO,LOC 
FROM EMP A
JOIN DEPT B ON(A.DEPTNO = B.DEPTNO);

--조인은 기본이 EQUAL JOIN(등가조인) 이다(=EQU JOIN)
--연결이 되는 컬럼의 값이 일치하는 행들만 조인됨(일치하는 값이 없는 경우는 조인에서 제외되어 출력)

--JOIN 기본은 INNER JOIN(=JOIN) & EQU JOIN

--OUTER JOIN : 두테이블의 지정하는 컬럼값이 일치하지 않는 행도 조인에 포함을 시킴

--1. LEFT OUTER JOIN (= LEFT JOIN) : 합치기에 사용된 두테이블중에서 왼편에 기술된 테이블의 행을 기준으로 하여 JOIN

--2. RIGHT OUTER JOIN (= RIGHT JOIN) : 합치기에 사용된 두테이블중에서 오른편에 기술된 테이블의 행을 기준으로 하여 JOIN

--3. FULL OUTER JOIN (= FULL JOIN): 합치기에 사용된 두테이블이 가진 모든행을 결과에 포함하여 JOIN
-- LEFT/RIGHT OUTER JOIN

--1. LEFT OUTER JOIN
--ANSI
SELECT * FROM EMP;
SELECT * FROM EMP A LEFT JOIN DEPT B ON (A.DEPTNO = B.DEPTNO);

--1. LEFT OUTER JOIN
--오라클 전용구문
SELECT * FROM EMP A, DEPT B 
WHERE A.DEPTNO = B.DEPTNO(+);

--2. RIGHT OUTER JOIN
--ANSI
SELECT *
FROM EMP A
RIGHT JOIN DEPT B ON (A.DEPTNO = B.DEPTNO);

--오라클 전용구문
SELECT *
FROM EMP A, DEPT B
WHERE A.DEPTNO(+) = B.DEPTNO;

 -- 오라클 전용구문
-- 오라클 전용구문으로는 FULL OUTER JOIN 을 할수 없다 -- 에러 

--SELECT
--    ENAME
--    , DNAME
--FROM EMP A
--    ,DEPT B
--WHERE A.DEPTNO(+) = B.DEPTNO(+);


--CROSS JOIN : 카테이션 곱이라고도 한다. 
--             조인이 되는 테이블의 각행들이 모두 매핑된 데이터가 검색되는 방법 (곱집합)

SELECT
  *
FROM EMP A; -- 21

SELECT * FROM DEPT B;  --4

SELECT
    ENAME, DNAME 
FROM EMP A
CROSS JOIN DEPT B; --84



-- 오라클 전용구문 
SELECT 
      ENAME, DNAME 
FROM EMP, DEPT;



SELECT * FROM MEMBER;
SELECT * FROM BBS;
DROP TABLE BBS;
CREATE TABLE BBS(
	ID INT ,
	TITLE VARCHAR(50) ,
	CONTENT VARCHAR(50),
	WRITER INT 
);
INSERT INTO BBS VALUES (1, 'apple', 'apple', 1);
INSERT INTO BBS VALUES (2, 'apple', 'sana', 2);
INSERT INTO BBS VALUES (3, 'apple', 'lisa', 1);
INSERT INTO BBS VALUES (4, 'apple', 'park', 2);


SELECT A.* , B.NAME, B.TEL
FROM BBS A
LEFT JOIN MEMBER B ON A.WRITER = B.ID; 

SELECT * FROM MEMBER A
LEFT JOIN BBS B ON A.ID = B.WRITER
ORDER BY 1;

SELECT * FROM COMPANY;
CREATE TABLE COMPANY (
	ID VARCHAR2(200) PRIMARY KEY,
	NAME VARCHAR2(200),
	ADDR VARCHAR2(200),
	TEL VARCHAR2(200)
);

INSERT INTO COMPANY VALUES ('c100', 'GOOD', 'SEOUL', '011');

INSERT INTO COMPANY VALUES ('c200', 'JOA', 'BUSAN', '012');

INSERT INTO COMPANY VALUES ('c300', 'MARIA', 'ULSAN', '013');

INSERT INTO COMPANY VALUES ('c400', 'MY', 'KWANGJU', '014');
COMMIT;
-- SELF JOIN : 같은 테이블을 조인하는 경우 자기 자신과 조인을 맺는것
-- 동일한 테이블내에서 원하는 정보를 한번에 가져올수 없을 때 사용 
SELECT 
*
FROM EMP A;
SELECT 
    A.EMPNO
    , A.ENAME 사원이름
    , A.DEPTNO
    , A.MGR
    , B.ENAME 관리자이름
FROM EMP A
    , EMP B
WHERE A.MGR = B.EMPNO;

-- 다중조인 : N 개의 테이블을 조회할때 사용 
-- ANSI표준
-- 순서중요 
SELECT
     A.EMPNO
    , A.ENAME   
    , E.DNAME 
    , C.GRADE  SAL_LEVEL
    , A.MGR		MGR_CODE
    , B.ENAME MGR_NAME
    , D.GRADE MGR_SAL_LEVEL
    , F.DNAME MGR_DEPT
FROM EMP A
JOIN EMP B ON A.MGR = B.EMPNO
LEFT JOIN SALGRADE C ON A.SAL BETWEEN C.LOSAL AND C.HISAL
LEFT JOIN SALGRADE D ON B.SAL BETWEEN D.LOSAL AND D.HISAL
LEFT JOIN DEPT E ON A.DEPTNO = E.DEPTNO
LEFT JOIN DEPT F ON B.DEPTNO = F.DEPTNO;

SELECT * FROM MEMBER0;
DROP TABLE MEMBMER0;
CREATE TABLE MEMBER0 (
	ID VARCHAR2(200) ,
	PW VARCHAR2(200),
	NAME VARCHAR2(200),
	TEL VARCHAR2(200)
);
INSERT INTO MEMBER0 VALUES ('3', '3', 'SSD', '0226');