-- New script in localhost.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//localhost:1521/XE
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 5. 10.
-- Time: 오후 3:12:30

CREATE USER student IDENTIFIED BY student;
GRANT CONNECT,resource TO student;

CREATE TABLE EMP11(
	ENAME11 varchar(20)
);
CREATE TABLE DMP11(
	DNAME11 varchar(20)
);

INSERT INTO EMP11 VALUES('2');
INSERT INTO DMP11 VALUES('222');
SELECT * FROM EMP11;
SELECT * FROM DMP11;

SELECT ENAME11 , DNAME11 FROM EMP11 CROSS JOIN DMP11 ORDER BY ENAME11;