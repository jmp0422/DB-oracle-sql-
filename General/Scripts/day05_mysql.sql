-- New script in localhost 2.
-- Connection Type: dev 
-- Url: jdbc:mysql://localhost:3306/
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 5. 10.
-- Time: 오전 11:01:30

USE scottt;

DROP TABLE MEMBER;
CREATE TABLE member(
	NO INT AUTO_INCREMENT PRIMARY KEY,
	ID varchar(10),
	PW varchar(10),
	NAME varchar(10),
	TEL varchar(10),
	CREATE_DATE timestamp
);

INSERT INTO MEMBER VALUES(NULL,1,1,'리사','010',NOW());
COMMIT;
SELECT * FROM MEMBER;

SHOW grants;

CREATE USER scottt@'%' IDENTIFIED BY 'tiger'; -- 외부에서 접속가능하다 

-- 모든 DATABASE 및 모든 TABLE에 대한 접근 허용
-- GRANT ALL PRIVILEGES ON *.* TO '사용자아이디'@'접속허용IP';
GRANT ALL PRIVILEGES ON scott.* TO 'scottt'@'%';
CREATE DATABASE scottt;