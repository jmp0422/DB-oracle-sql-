-- New script in localhost 2.
-- Connection Type: dev 
-- Url: jdbc:mysql://localhost:3306/
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 7. 31.
-- Time: 오전 9:47:41

USE scott;

CREATE TABLE payment (
	payment_no INT AUTO_INCREMENT PRIMARY KEY,
    member_no INT NOT NULL,
    product_no INT NOT NULL,
    purchase_price INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    im_port_id varchar(255),
    confirm char(1) DEFAULT 'N',
    confirm_at TIMESTAMP DEFAULT NULL,
    refund CHAR(1) DEFAULT 'N',
    refund_at TIMESTAMP DEFAULT NULL,
    CONSTRAINT payment_member_no_fk FOREIGN KEY (member_no) REFERENCES mem_member(member_no) ON DELETE CASCADE,
    CONSTRAINT payment_product_no_fk FOREIGN KEY (product_no) REFERENCES product(product_no) ON DELETE CASCADE
);
SELECT * from payment;
DROP TABLE payment;






CREATE TABLE payment_point (
    payment_point_no INT NOT NULL AUTO_INCREMENT,
    member_no INT NOT NULL,
    im_port_id varchar(255),
    payment_point_change INT NOT NULL,
    payment_point_info VARCHAR(20),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (payment_point_no),
    CONSTRAINT member_no_fk FOREIGN KEY (member_no) REFERENCES mem_member(member_no) ON DELETE CASCADE
);
DROP TABLE payment_point;
SELECT * FROM payment_point;

SELECT * FROM payment_point WHERE im_port_id = "imp_410483301292";



CREATE TABLE payment_product_reviews (
    payment_product_reviews_no INT AUTO_INCREMENT PRIMARY key,
    member_no INT NOT NULL,
    product_no INT NOT NULL,
    tag_answer char(1) DEFAULT 'N',
    content varchar(255),
    rating varchar(255),
    im_port_id varchar(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modify_at TIMESTAMP DEFAULT NULL,
    CONSTRAINT payment_review_member_no_fk FOREIGN KEY (member_no) REFERENCES mem_member(member_no) ON DELETE CASCADE,
    CONSTRAINT payment_review_product_no_fk FOREIGN KEY (product_no) REFERENCES product(product_no) ON DELETE CASCADE
);
DROP TABLE payment_product_reviews;
SELECT * FROM payment_product_reviews;

SELECT * FROM ;

CREATE OR REPLACE VIEW vw_paymentpage AS
SELECT
    p.product_no,
    pd.product_name,
    pd.product_code,
    pd.type_no,
    pd.price,
--     GROUP_CONCAT(CONCAT(pd.options, ' : ', pd.option_value) SEPARATOR ' / ') AS product_info,
    MAX(pd.upload_name) AS upload_name
FROM
    product p
JOIN
    vw_product_detail pd ON p.product_name = pd.product_name
GROUP BY
    p.product_no, pd.product_name, pd.product_code, pd.type_no, pd.price;
SELECT * FROM vw_paymentpage;
DROP VIEW vw_paymentpage;

CREATE TRIGGER update_payment_on_review_insert
AFTER INSERT ON payment_product_reviews
FOR EACH ROW
BEGIN
    UPDATE payment
    SET confirm = 'Y',
        confirm_at = CURRENT_TIMESTAMP
    WHERE im_port_id = NEW.im_port_id
    AND confirm = 'N';
END;


-- CREATE TABLE paymentpage (
--     username VARCHAR(50),
--     productname VARCHAR(50),
--     productinfo VARCHAR(255),
--     date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     productprice INT
-- );
-- INSERT INTO paymentpage values("jack", "LG GRAM", "WQXGA / GEFORCE RTX 3050 / 144HZ /WINDOWS내장 / 1440*1060", DEFAULT, 200);
-- DROP TABLE paymentpage;
-- SELECT * FROM paymentpage;

-- CREATE TABLE payment (
-- 	payment_no INT AUTO_INCREMENT PRIMARY KEY,
--     username VARCHAR(50),
--     product_name VARCHAR(50),
-- --     productinfo VARCHAR(255),
-- --     productprice INT,
--     purchase_price INT,
--     date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     im_port_id varchar(255),
--     refund CHAR(1) DEFAULT 'N',
--     refund_date TIMESTAMP DEFAULT NULL
-- );
-- SELECT * from payment;
-- DROP TABLE payment;