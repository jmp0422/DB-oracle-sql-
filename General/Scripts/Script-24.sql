-- New script in localhost 3.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//localhost:1521/XE
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 6. 13.
-- Time: 오후 2:36:30
DROP TABLE TESTMEMBER00;
DROP SEQUENCE SEQ_MEMBER_NO00;
CREATE TABLE TESTMEMBER00
(
    MEMBER_NO    NUMBER PRIMARY key,
    MEMBER_ID    VARCHAR2(20),
    MEMBER_PWD    CHAR(60),
    MEMBER_NAME    VARCHAR2(20),
    MEMBER_ROLE VARCHAR2(20)
);

CREATE SEQUENCE SEQ_MEMBER_NO00;

INSERT INTO TESTMEMBER00
VALUES (SEQ_MEMBER_NO00.NEXTVAL, 'admin', '$2a$10$VykXqWfk8QJhkdvFIDy4JOkXK/z/CjTFQh2AGRZOCo1JiOtsNNlRO',  '관리자', 'ROLE_ADMIN');
INSERT INTO TESTMEMBER00 
VALUES (SEQ_MEMBER_NO00.NEXTVAL, 'user01', '$2a$10$Rb4mb05kSDXbyPbt4b7/xOVG8rib7vhpwRZ3/IBUReLMxffVzQQUW',  '홍길동', 'ROLE_MEMBER');
INSERT INTO TESTMEMBER00 
VALUES (SEQ_MEMBER_NO00.NEXTVAL, 'test00', 'test00',  '테스트', 'ROLE_MEMBER');

SELECT * FROM TESTMEMBER00;

COMMIT;