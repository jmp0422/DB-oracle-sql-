-- New script in localhost 2.
-- Connection Type: dev 
-- Url: jdbc:mysql://localhost:3306/
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 5. 10.
-- Time: 오전 11:01:30

USE scott;

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