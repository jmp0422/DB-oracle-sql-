-- New script in localhost 3.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//localhost:1521/XE
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 5. 14.
-- Time: 오전 9:07:06

--서브쿼리(SubQuery)
/*하나의 SQL 문안에 포함되어있는 또다른 SQL 문
알려지지 않은 조건에 근거한 값들을 검색하는 SELECT 문장을 작성하는데 유용함
메인쿼리가 서브쿼리를 포함하는 종속적인 관계
서브쿼리는 반드시 소괄호 로 묶어야함
-> (SELECT...) 형태
*/

SELECT * FROM emp;
-- 사원명이 스미스인 사람의 같은부서 직원을 조회
SELECT DEPTNO FROM EMP WHERE ENAME = 'SMITH';
SELECT * FROM EMP WHERE DEPTNO = '20'

SELECT * FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'SMITH');

--전직원의 평균급여보다 많은 급여를 받고있는 직원의 사번,이름,직급코드,급여를 조회
SELECT DEPTNO, ENAME, JOB, SAL FROM EMP WHERE SAL > (SELECT AVG(SAL) FROM EMP);
SELECT AVG(SAL) FROM EMP;


--서브쿼리의 유형
--단일행 서브쿼리 : 서브쿼리의 조회 결과값이 1개 행일때
--다중행 서브쿼리 : 서브쿼리의 조회 결과값의 행이 여러개일때
--다중열 서브쿼리 : 서브쿼리의 조회 결과값의 컬럼이 여러개일때
--다중행 다중열 서브쿼리 : 조회경로가 행 수와 열수가 여러개일때
--상(호연)관서브쿼리 : 서브쿼리가 만든 결과값을 메인쿼리가 비교 연산할때 
--                  메인쿼리의 값이 변경되면 서브쿼리의 결과값도 바뀌는 서브쿼리 
--스칼라 서브쿼리 : 상관쿼리이면서 결과값이 하나인 서브쿼리 

--* 서브쿼리의 유형에 따라 서브쿼리 앞에 붙은 연산자가 다름

--1. 단일행 서브쿼리 
-- 단일행서브쿼리앞에는 일반비교 연산자사용
-- >,<,>=,<=,=, !=,<>,^= (서브쿼리)

--SMITH 사원의 급여보다 많이 받는 직원의 사번,이름,부서명, 급여를 조회하세요
SELECT A.DEPTNO,A.ENAME,B.DNAME,A.SAL FROM EMP A
LEFT JOIN DEPT B ON A.DEPTNO = B.DEPTNO WHERE A.SAL > (SELECT SAL FROM EMP WHERE ENAME = 'SMITH');

--가장 적은 급여를 받는 직원의 사번,이름,부서명,급여를 조회하세요
SELECT A.DEPTNO,A.ENAME,B.DNAME,A.SAL FROM EMP A
LEFT JOIN DEPT B ON A.DEPTNO = B.DEPTNO WHERE A.SAL = (SELECT MIN(SAL) FROM EMP);

-- 서브쿼리는 SELECT, FROM, WHERE, HAVING, ORDER BY(서브쿼리내부에 포함은 안됨) 에도 사용 가능

-- 부서별 급여의 합계가 가장 큰 부서의 부서명, 급여합계를 구하시오
SELECT B.DEPTNO, B.DNAME, SUM(A.SAL) TOTALSAL
FROM EMP A
INNER JOIN DEPT B ON A.DEPTNO = B.DEPTNO
GROUP BY B.DEPTNO, B.DNAME
HAVING SUM(A.SAL) = (SELECT MAX(SUM(SAL)) FROM EMP GROUP BY DEPTNO);

--2. 다중행 서브쿼리 
-- 다중행 서브쿼리 앞에서는 일반 비교 연산자를 사용 할수 없다
-- IN / NOT IN : 여러개의 결과값 중에서 한개라도 일치하는 값이 있다면 , 혹은 없다면 이라는 의미
-- > ANY, < ANY : 여러개의 결과값중에서 한개라도 큰 / 작은 경우 - 가장 작은 값보다 크냐? /가장 큰 값보다 작냐?
-- > ALL, < ALL : 모든값 보다 큰 / 작은 경우 - 가장 큰 값보다 크냐?/가장 작은 값보다 작냐?
-- EXIST / NOT EXIST : 서브쿼리에만 사용하는 연산자로 서브쿼리의 결과중에서 만족하는 값이 하나라도 존재하면 참
--                     값이 존재하는가? / 존재하지않는가?




--부서별 급여의 합계가 가장 큰 부서의 부서명, 급여합계를 구하세요
SELECT * FROM EMP;
SELECT * FROM EMP
WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

-- 관리자에 해당하는 직원에 대한 정보와 관리자가 아닌직원의 정보를 추출하여 조회 
-- 사번, 이름 , 부서명 , '관리자' AS 구분 / '직원' AS 구분
SELECT DISTINCT MGR FROM EMP WHERE MGR IS NOT NULL AND MGR != 0;



SELECT A.*
FROM(
	SELECT A.EMPNO, A.ENAME,B.DNAME, '관리자' 구분 
	FROM EMP A
	LEFT JOIN DEPT B ON A.DEPTNO = B.DEPTNO
	WHERE A.EMPNO IN (SELECT DISTINCT MGR FROM EMP WHERE MGR IS NOT NULL AND MGR != 0)
	UNION
	SELECT A.EMPNO, A.ENAME,B.DNAME, '직원' 구분 
	FROM EMP A
	LEFT JOIN DEPT B ON A.DEPTNO = B.DEPTNO
	WHERE A.EMPNO NOT IN (SELECT DISTINCT MGR FROM EMP WHERE MGR IS NOT NULL AND MGR != 0)
)A
ORDER BY A.구분 DESC;

--

SELECT A.EMPNO, A.ENAME,B.DNAME,
CASE WHEN A.EMPNO IN(SELECT DISTINCT MGR FROM EMP WHERE MGR IS NOT NULL AND MGR != 0) THEN '관리자'
          ELSE '직원'
     END 구분
FROM EMP A
LEFT JOIN DEPT B ON A.DEPTNO = B.DEPTNO
ORDER BY 구분 DESC;

--EXISTS : 서브쿼리의 결과 중에서 만족하는 값이 하나라도 존재하면 참
-- 참, 거짓 서브쿼리안에 값이 있는지 없는지 
-- 서브쿼리 결과가 참이면 메인쿼리를 실행, 서브쿼리 결과가 거짓이면 메인쿼리를 실행하지않는다.

SELECT 
    A.ENAME
    , A.MGR
FROM EMP A
WHERE EXISTS(SELECT     
                B.ENAME
             FROM EMP B
             --WHERE NVL(B.SAL,0) >= 10000);
			 WHERE NVL(B.SAL,0) >= 5000);

-- 다중열 서브쿼리 
--> 서브쿼리의 조회결과 컬럼의 개수가 여러개일때 (다중행하고는 다르게 결과값이 컬럼이 여러개!!)


-- 직원들 중에서 부서에서  최고 급여를 받는 직원의  정보 조회
SELECT DEPTNO, MAX(SAL)
FROM EMP
GROUP BY DEPTNO;

SELECT
*
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO);

--각 부서에서 가장 오래 근무한 직원의 정보를 조회
SELECT MIN(HIREDATE)
FROM EMP;

SELECT *
FROM EMP
WHERE (DEPTNO, HIREDATE) IN (SELECT DEPTNO, MIN(HIREDATE) FROM EMP GROUP BY DEPTNO);

--다중행다중열 서브쿼리를 이용 - 보통 다중행 다중열일가능성이큳 
-- 직급별 평균월급이 직급과 월급둘다 일치하는 사원 (TRUNC(컬럼명, 0))

SELECT *
FROM EMP
WHERE (JOB, TRUNC(SAL,0)) IN 
(
SELECT JOB,TRUNC(AVG(SAL),0) 
FROM EMP 
GROUP BY JOB 
HAVING TRUNC(AVG(SAL),0) > 0
);

-- 상[호연]관 서브쿼리
-- 일반적으로는 서브쿼리가 만든 결과값을 메인쿼리가 비교 연산
-- 메인쿼리가 사용하는 테이블의 값을 서브쿼리가 이용해서 결과를 만듬
-- 메인쿼리의 테이블 값이 변경되면, 서브쿼리의 결과값도 바뀌게 됨

--메인쿼리에 있는것을 서브쿼리에서 가져다쓰면 상관 서브쿼리
--서브쿼리가 독단적으로 사용이 되면 일반서브쿼리

-- 관리자 사번이 EMP 테이블에 존재 하는 직원에 대한 조회
SELECT * FROM EMP A
WHERE EXISTS (
	SELECT 1
	FROM EMP B
	WHERE B.EMPNO = A.MGR
);

-- 스칼라 서브쿼리
-- 단일행 서브쿼리 + 상관쿼리(-> 상관쿼리 이면서 결과값이 1개인 서브쿼리)
-- SELECT절, WHERE절, ORDER BY절 사용 가능

-- WHERE절에서 스칼라 서브쿼리 이용
-- 동일 직급의 급여 평균 TRUNC(AVG(SAL), 0)보다 급여를 많이 받고 있는 직원의
-- 사번, 직급코드, 급여를 조회하세요
SELECT * FROM EMP A
WHERE SAL > (
	SELECT TRUNC(AVG(SAL),0)FROM EMP B
	WHERE A.JOB = B.JOB
);

--SELECT 절에서 스칼라 서브쿼리 이용 
-- 모든 사원의 사번, 이름, 관리자 사번, 관리자명 조회
SELECT
    EMPNO AS "EMPNO",
    ENAME AS "ENAME",
    MGR AS "MGR",
    NVL((SELECT ENAME
         FROM EMP
         WHERE EMPNO = E.MGR
    ), '없음') AS "MANAGER_NAME"
FROM EMP E
ORDER BY EMPNO;

-- ORDER BY 절에서 스칼라 서브쿼리 이용 

-- 모든 직원의 사번, 이름 , 소속 부서코드 조회
-- 단 부서명 내림차순 정렬 
SELECT
    EMPNO AS "EMPNO",
    ENAME AS "ENAME",
    A.DEPTNO AS "DEPTNO"
FROM EMP A
ORDER BY (SELECT DNAME
          FROM DEPT B
          WHERE A. DEPTNO = B.DEPTNO) DESC NULLS LAST;

-- 서브쿼리의 사용 위치 : 
-- SELECT절, FROM절, WHERE절, HAVING절, GROUP BY절, ORDER BY절
-- DML 구문 : INSERT문, UPDATE문
-- DDL 구문 : CREATE TABLE문, CREATE VIEW문


-- FROM 절에서 서브쿼리를 사용할 수 있다 : 테이블 대신에 사용
-- 인라인 뷰(INLINE VIEW)라고 함
-- : 서브쿼리가 만든 결과집합(RESULT SET)에 대한 출력 화면

-- 부서명이 ACCOUNTING인  사원명  , 부서명, 직급이름 을 구하시오 (인라인뷰사용)
SELECT A.*
FROM ( SELECT
	    E.ENAME AS "ENAME",
	    D.DNAME AS "DEPT_NAME",
	    E.JOB AS "JOB_NAME"
	FROM EMP E
	JOIN DEPT D ON E.DEPTNO = D.DEPTNO
        )A
WHERE A.DEPT_NAME = 'ACCOUNTING';

/*우선 TOP-N 분석에 대해 알아보자
# TOP-N 분석이란?
	TOP-N 질의는 columns에서 가장 큰 n개의 값 또는 가장 작은 n개의 값을 요청할 때
	사용됨
	예) 가장 적게 팔린 제품 10가지는? 또는 회사에서 가장 소득이 많은 사람 3명은?
*/
SELECT ROWNUM,
		ENAME,
		SAL
FROM EMP;

SELECT * FROM EMP;
-- 급여 평균 2위안에드는 부서의 부서코드와 부서명 , 평균급여를 조회하세요 (인라인뷰를 활용한 TOP-N분석 사용 )
SELECT 
	ROWNUM,
	A.DEPTNO,
	A.AVGSAL
FROM (
	SELECT A.DEPTNO, AVG(SAL) AVGSAL
	FROM EMP A LEFT JOIN DEPT B ON A.DEPTNO = B.DEPTNO
	GROUP BY A.DEPTNO
	ORDER BY AVG(SAL) DESC
)A WHERE ROWNUM <= 2;
	
-- 직원 정보에서 급여를 가장 많이 받는 순으로 이름, 급여, 순위 조회
SELECT 
    ENAME AS "이름",
    SAL AS "급여",
    DENSE_RANK() OVER (ORDER BY SAL DESC) AS "순위"-- 중복된거 이후 순위가 순차적으로 나옴 
FROM EMP;


SELECT 
    ENAME AS "이름",
    SAL AS "급여",
    RANK() OVER (ORDER BY SAL DESC) AS "순위"
FROM EMP;	
	
-- 직원 테이블에서 보너스 포함한 연봉이 높은 5명의 RANK() OVER
-- 사번, 이름, 부서명, 직급명, 입사일을 조회하세요
--급여 상위 5명 조회
SELECT 
    이름,
    급여,
    순위,
    순위2
FROM (
    SELECT
        ENAME AS "이름",
        SAL AS "급여",
        RANK() OVER (ORDER BY SAL DESC) AS "순위",
        DENSE_RANK() OVER (ORDER BY SAL DESC) AS "순위2"
    FROM EMP
) A
WHERE 순위 <= 5;	
	

-- WITH 이름 AS (쿼리문)
-- 서브쿼리에 이름을 붙여주고 사용시 이름을 사용하게 됨
-- 인라인뷰로 사용될 서브쿼리에서 이용됨
-- 같은 서브쿼리가 여러번 사용될 경우 중복 작성을 줄일 수 있다.

WITH TOPN_SAL AS(

	SELECT
		EMPNO,
		ENAME,
		SAL
	FROM EMP
	ORDER BY SAL DESC 

)
SELECT 
	ROWNUM 순위,
	ENAME,
	SAL
FROM TOPN_SAL;

--WITH절 여러개 

WITH TOT_SAL AS
    (
        SELECT SUM(SAL) SAL1
        FROM EMP
    ),
    AVG_SAL AS
    (
        SELECT AVG(SAL) SAL2
        FROM EMP

    )
SELECT
    '합' COL1 , ROUND(S.SAL1, 0) COL2
FROM TOT_SAL S
UNION ALL
SELECT 
    '평균' COL1, ROUND(A.SAL2, 0) COL2
FROM AVG_SAL A
UNION ALL
SELECT 
    '직원' COL1 , SUM(SAL) COL2
FROM EMP
WHERE EMPNO IN ('7839','7698');

WITH TOT_SAL AS
    (
        SELECT SUM(SAL) SAL1
        FROM EMP
    ),
    AVG_SAL AS
    (
        SELECT AVG(SAL) SAL2
        FROM EMP

    )  
SELECT
    A.*, ROUND(SAL1, 0) 합,  ROUND(SAL2, 0) 평균
FROM EMP A , TOT_SAL , AVG_SAL;

WITH SalStats AS (
    SELECT SUM(SAL) AS Total_Sal, AVG(SAL) AS Avg_Sal
    FROM EMP
)
SELECT 
    A.EMPNO,
    A.ENAME,
    A.SAL AS Emp_Sal,
    ROUND(S.Total_Sal, 0) AS Total_Sal,
    ROUND(S.Avg_Sal, 0) AS Avg_Sal
FROM 
    EMP A,
    SalStats S;
    
-- 부서별 급여 합계가 전체 급여의 총 합의 20%보다 많은
-- 부서의 부서명과, 부서별 급여 합계 조회
   --1번째방법 -HAVING
   --2번째방법 -인라인뷰
   --3번째방법 - WITH사용