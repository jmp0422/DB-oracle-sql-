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
    productprice INT,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    
);
SELECT * FROM testprice;


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




CREATE TABLE payment_price(
    payment_price_no INT AUTO_INCREMENT PRIMARY key,
    payment_no INT,
    use_point_price INT,
    payment_discount INT,
    payment_final_price INT,
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
--     CONSTRAINT `payment_price` FOREIGN KEY (`payment_no`) REFERENCES `payment` (`payment_no`),
);
INSERT INTO payment_price values( NULL , 1, 100 , 100, 100 ,default);
DROP TABLE payment_price;
SELECT * FROM payment_price;





CREATE TABLE payment_product_reviews (
    payment_product_reviews_no INT AUTO_INCREMENT PRIMARY key,
    payment_product_no INT,
    product_no INT,
    non_sentiment_no INT,
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modify_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
--     CONSTRAINT `payment_product_revies` FOREIGN KEY (`payment_product_no`) REFERENCES `payment_product` (`payment_product_no`),
--     CONSTRAINT `payment_product_revies` FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`),
--     CONSTRAINT `payment_product` FOREIGN KEY (`non_sentiment_no`) REFERENCES `laptop_non_sentiment` (`non_sentiment_no`)
);
INSERT INTO payment_product_reviews values( NULL , 1, 1 , 1, default ,default);
DROP TABLE payment_product_reviews;
SELECT * FROM payment_product_reviews;