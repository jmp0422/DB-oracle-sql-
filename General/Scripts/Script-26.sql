-- New script in localhost 2.
-- Connection Type: dev 
-- Url: jdbc:mysql://localhost:3306/
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 7. 18.
-- Time: 오후 3:24:14
USE scott;

CREATE TABLE testproduct (
    username VARCHAR(50),
    productname VARCHAR(50),
    productinfo VARCHAR(255),
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    productprice INT
);
INSERT INTO testproduct values("jack", "LG GRAM", "WQXGA / GEFORCE RTX 3050 / 144HZ /WINDOWS내장 / 1440*1060", DEFAULT, 200);
DROP TABLE TESTPRODUCT;
SELECT * FROM testproduct;

CREATE TABLE testprice (
    username VARCHAR(50),
    productname VARCHAR(50),
    productinfo VARCHAR(255),
    productprice INT,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    imd varchar(255),
    refund CHAR(1) DEFAULT 'N',
    refund_date TIMESTAMP DEFAULT NULL
);
SELECT * FROM testprice;
DROP TABLE testprice;
INSERT INTO testprice values("jack", "samsung super111", "서라운드 스피커 / GEFORCE RTX 4090 / 165HZ / WINDOWS내장 / 1440*1060", 20000, NOW(), 113 ,DEFAULT , NULL);
INSERT INTO testprice values("jack", "samsung super222", "서라운드 스피커 / GEFORCE RTX 4090 / 165HZ / WINDOWS내장 / 1440*1060", 20000, NOW(), 222 ,DEFAULT , NULL);
INSERT INTO testprice values("jack", "samsung super333", "서라운드 스피커 / GEFORCE RTX 4090 / 165HZ / WINDOWS내장 / 1440*1060", 20000, NOW(), 444 ,DEFAULT , NULL);


CREATE TABLE mem_member (
    member_no INT NOT NULL AUTO_INCREMENT,
    member_name VARCHAR(30) NOT NULL,
    email VARCHAR(255) NOT NULL,
    nick_name VARCHAR(50),
    tel VARCHAR(15),
    point INT NOT NULL DEFAULT 0,
    role VARCHAR(15) NOT NULL DEFAULT 'ROLE_USER',
    login_type VARCHAR(15) NOT NULL DEFAULT 'local',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (member_no),
    UNIQUE (member_name),
    UNIQUE (nick_name)
);
SELECT * FROM mem_member;
CREATE TABLE mem_password (
    password_id INT NOT NULL AUTO_INCREMENT,
    member_no INT NOT NULL,
    member_password VARCHAR(128) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (password_id),
    FOREIGN KEY (member_no) REFERENCES mem_member(member_no) ON DELETE CASCADE
);
SELECT * FROM mem_password;


CREATE TABLE mem_pas23sword (
    password_id INT
    );
DROP TABLE mem_pas23sword;





















CREATE TABLE payment_product (
    payment_product_no INT AUTO_INCREMENT PRIMARY key,
    payment_no INT,
    payment_price_no INT,
    product_no INT,
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
--     CONSTRAINT `payment_product` FOREIGN KEY (`payment_no`) REFERENCES `payment` (`payment_no`),
--     CONSTRAINT `payment_product` FOREIGN KEY (`payment_price_no`) REFERENCES `payment_price` (`payment_price_no`),
--     CONSTRAINT `payment_product` FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`)
);
INSERT INTO payment_product values( NULL , 1, 1, 1, default);
DROP TABLE payment_product;
SELECT * FROM payment_product;




CREATE TABLE payment(
    payment_no INT AUTO_INCREMENT PRIMARY key,
    member_no INT,
    payment_plan varchar(255),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
--     CONSTRAINT `payment` FOREIGN KEY (`payment_no`) REFERENCES `mem_member` (`member_no`),
);
INSERT INTO payment values( NULL , 1, "card", default);
DROP TABLE payment;
SELECT * FROM payment;




CREATE TABLE payment_point(
    payment_price_no INT AUTO_INCREMENT PRIMARY key,
    username varchar(255),
    payment_possession_point INT DEFAULT 0,
    payment_point_change varchar(255),
    payment_point_info varchar(255),
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modify_date TIMESTAMP DEFAULT NULL
--     CONSTRAINT `payment_price` FOREIGN KEY (`payment_no`) REFERENCES `payment` (`payment_no`),
);

CREATE TABLE payment_point (
    payment_price_no INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255),
    payment_possession_point INT DEFAULT 0 CHECK (payment_possession_point >= 0),
    payment_point_change VARCHAR(255),
    payment_point_info VARCHAR(255),
    create_date TIMESTAMP DEFAULT NULL
    -- CONSTRAINT `payment_price` FOREIGN KEY (`payment_no`) REFERENCES `payment` (`payment_no`)
);

INSERT INTO payment_point values( NULL , "jack", 100 , null, null , NOW());
DROP TABLE payment_point;

SELECT * FROM payment_point;




CREATE TABLE payment_product_reviews (
    payment_product_reviews_no INT AUTO_INCREMENT PRIMARY key,
    username varchar(255),
    product_name varchar(255),
    tag_answer char(1) DEFAULT 'N',
    content varchar(255),
    rating varchar(255),
    impuid varchar(255),
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modify_date TIMESTAMP DEFAULT NULL
--     CONSTRAINT `payment_product_revies` FOREIGN KEY (`payment_product_no`) REFERENCES `payment_product` (`payment_product_no`),
--     CONSTRAINT `payment_product_revies` FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`),
--     CONSTRAINT `payment_product` FOREIGN KEY (`non_sentiment_no`) REFERENCES `laptop_non_sentiment` (`non_sentiment_no`)
);
INSERT INTO payment_product_reviews values( NULL , 1, 1 , 1, default ,default);
DROP TABLE payment_product_reviews;
SELECT * FROM payment_product_reviews;