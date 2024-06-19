-- New script in localhost 2.
-- Connection Type: dev 
-- Url: jdbc:mysql://localhost:3306/
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 6. 19.
-- Time: 오후 4:23:01

USE SCOTT;

CREATE TABLE TB_USERS(
    USER_NO INT PRIMARY KEY,        -- 회원 번호 (PK)
    USER_ID VARCHAR(100) UNIQUE,    -- 아이디 (유니크)
    USER_PASSWORD VARCHAR(100),    -- 비밀번호
    USER_NAME VARCHAR(20),            -- 이름
    USER_PROFILE_IMG_PATH VARCHAR(100),    -- 프로필 이미지 경로
    USER_NICKNAME VARCHAR(20),      -- 닉네임
    USER_AGE INT,                    -- 나이
    USER_GENDER VARCHAR(3) CHECK (USER_GENDER IN ('M','F')),    -- 성별(남M,여F)
    USER_TEL VARCHAR(15),            -- 연락처
    USER_MANNER_COUNT INT DEFAULT '0',                    -- 매너 카운트
    USER_BAN_COUNT INT DEFAULT '0',                        -- 신고 카운트
        USER_SIGNUP_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                -- 회원 가입일
    USER_DELETE_ACCOUNT_DATE DATE DEFAULT NULL,            -- 회원 탈퇴일 (기본값 NULL)
    USER_DELETE_ACCOUNT VARCHAR(3) DEFAULT 'N' CHECK (USER_DELETE_ACCOUNT IN ('Y','N'))    -- 퇴원 탈퇴 여부(탈퇴Y,기본N)
);

-- CREATE SEQUENCE TB_USERS_SEQ        -- 회원 번호 증가 시퀀스 생성
--     START WITH 1
--     INCREMENT BY 1
--     NOMAXVALUE;
-- 
-- CREATE OR REPLACE TRIGGER TRG_TB_USERS_SEQ    --시퀀스 사용 트리거 생성
-- BEFORE INSERT ON TB_USERS
-- FOR EACH ROW
-- BEGIN
--     SELECT TB_USERS_SEQ.NEXTVAL INTO :NEW.NO FROM DUAL;
-- END;
-- --TB_USERS Table

CREATE TABLE TB_RMATCH (
    RMCH_CODE VARCHAR(100),
    USER_ID VARCHAR(100),
    RMCH_CATEGORY VARCHAR(100),
    PRIMARY KEY (RMCH_CODE),
    FOREIGN KEY (USER_ID) REFERENCES TB_USERS(USER_ID)
);

CREATE TABLE TB_FRND_LIST (
    FRND_CODE VARCHAR(100),
    USER_ID VARCHAR(100),
    FRND_ADD VARCHAR(100) DEFAULT NULL,
    FRND_BAN VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (FRND_CODE),
    FOREIGN KEY (USER_ID) REFERENCES TB_USERS(USER_ID),
    FOREIGN KEY (FRND_ADD) REFERENCES TB_USERS(USER_ID),
    FOREIGN KEY (FRND_BAN) REFERENCES TB_USERS(USER_ID)
);



CREATE TABLE TB_CLUB (
    GRP_CODE VARCHAR(100) PRIMARY KEY,
    USER_ID VARCHAR(100),
    GRP_KICK VARCHAR(100),
    GRP_MANAGER VARCHAR(100),
    GRP_CATEGORY VARCHAR(100),
    FOREIGN KEY (USER_ID) REFERENCES TB_USERS(USER_ID)
);

CREATE TABLE TB_CHAT_LOG (
    CHAT_CODE VARCHAR(100),
    USER_ID VARCHAR(100),
    CHAT_CONTENT VARCHAR(255),
    CHAT_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHAT_TYPE VARCHAR(100),
    FOREIGN KEY (CHAT_CODE) REFERENCES TB_RMATCH(RMCH_CODE),
    FOREIGN KEY (CHAT_CODE) REFERENCES TB_CLUB(GRP_CODE),
    FOREIGN KEY (CHAT_CODE) REFERENCES TB_FRND_LIST(FRND_CODE),
    FOREIGN KEY (USER_ID) REFERENCES TB_USERS(USER_ID)
);

COMMIT;