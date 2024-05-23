-- New script in localhost 2.
-- Connection Type: dev 
-- Url: jdbc:mysql://localhost:3306/
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 5. 21.
-- Time: 오후 3:19:00

CREATE DATABASE jsp;
USE jsp;
create table member (
    id varchar(100) NULL,
    name varchar(256) NULL,
    email varchar(100) NULL,
    address varchar(500) NULL
);



SELECT * FROM MEMBER;