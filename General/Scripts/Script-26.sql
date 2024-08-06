-- New script in localhost 2.
-- Connection Type: dev 
-- Url: jdbc:mysql://localhost:3306/
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 7. 18.
-- Time: 오후 3:24:14
USE scott;

-- 회원 테이블
CREATE TABLE mem_member (
    member_no INT NOT NULL AUTO_INCREMENT,
    member_name VARCHAR(30) NOT NULL,
    email VARCHAR(255) NOT NULL,
    nick_name VARCHAR(50),
    tel VARCHAR(15),
    point INT NOT NULL DEFAULT 0 CHECK (point >= 0),
    role VARCHAR(15) NOT NULL DEFAULT 'ROLE_USER',
    login_type VARCHAR(15) NOT NULL DEFAULT 'local',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (member_no),
    CONSTRAINT member_name_uk UNIQUE (member_name),
    CONSTRAINT nick_name_uk UNIQUE (nick_name)
);
DROP TABLE mem_member;
INSERT mem_member values(1, "park", "rhkdlf6587@naver.com", "park", "010-1234-6587", 1000, DEFAULT, DEFAULT, DEFAULT, NULL );
SELECT * FROM mem_member;


-- 비밀번호 테이블
CREATE TABLE mem_password (
    password_id INT NOT NULL AUTO_INCREMENT,
    member_no INT NOT NULL,
    member_password VARCHAR(128) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON
UPDATE
	CURRENT_TIMESTAMP,
	PRIMARY KEY (password_id),
	FOREIGN KEY (member_no) REFERENCES mem_member(member_no) ON
	DELETE
		CASCADE
);
DROP TABLE mem_password;
SELECT * FROM mem_password;

-- 소셜 회원 테이블
CREATE TABLE mem_social_member (
    social_id INT NOT NULL AUTO_INCREMENT,
    member_no INT NOT NULL,
    external_id VARCHAR(64) NOT NULL,
    PRIMARY KEY (social_id),
    FOREIGN KEY (member_no) REFERENCES mem_member(member_no) ON DELETE CASCADE
);
DROP TABLE mem_social_member;
SELECT * FROM mem_password;

-- 배송지 테이블
CREATE TABLE mem_delivery_address (
    address_id INT NOT NULL AUTO_INCREMENT,
    member_no INT NOT NULL,
    address_name VARCHAR(255) NOT NULL,
    recipient_name VARCHAR(100),
    postal_code VARCHAR(10),
    address VARCHAR(255),
    detail_address VARCHAR(255),
    recipient_phone VARCHAR(15),
    request VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (address_id),
    FOREIGN KEY (member_no) REFERENCES mem_member(member_no)
);
DROP TABLE mem_delivery_address;

CREATE TABLE payment_point (
    payment_point_no INT NOT NULL AUTO_INCREMENT,
    member_no INT NOT NULL,
    im_port_id varchar(255),
    payment_point_change INT NOT NULL,
    payment_point_info VARCHAR(20),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (payment_point_no),
    CONSTRAINT member_no_fk FOREIGN KEY (member_no) REFERENCES mem_member(member_no) ON DELETE CASCADE
);
DROP TABLE payment_point;
SELECT * FROM payment_point;

-- 상품 테이블
CREATE TABLE product (
    product_no INT NOT NULL AUTO_INCREMENT,
    type_no INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    price INT NOT NULL,
    product_code VARCHAR(20) NOT NULL,
    reference_code VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT product_PK PRIMARY KEY(product_no),
    CONSTRAINT fk_product_type_no FOREIGN KEY (type_no) REFERENCES product_type(type_no)
);
DROP TABLE product;
DELETE FROM product WHERE type_no = 1;
SELECT * FROM product;

CREATE VIEW product_detail AS
SELECT 
    p.product_name,
    p.product_code,
    p.type_no,
    p.price,
    c.options,
    s.option_value,
    i.upload_name
FROM 
    product p
JOIN 
    product_spec s ON p.product_no = s.product_no
JOIN 
    product_category c ON s.category_no = c.category_no
JOIN 
    images i ON p.reference_code = i.reference_code
WHERE 
    p.type_no = 1;
   
SELECT * FROM product_detail;
DROP VIEW product_detail;

-- 상품 카테고리 테이블
CREATE TABLE product_category (
    category_no VARCHAR(50) NOT NULL,
    type_no INT NOT NULL,
    options VARCHAR(50),
    CONSTRAINT product_category_PK PRIMARY KEY(category_no),
    CONSTRAINT fk_product_category_type_no FOREIGN KEY (type_no) REFERENCES product_type(type_no)
);
DROP TABLE product_category;
SELECT * FROM product_category;

-- 상품타입 테이블
CREATE TABLE product_type (
    type_no INT NOT NULL AUTO_INCREMENT,
    type_name VARCHAR(20) NOT NULL,
    CONSTRAINT product_type_PK PRIMARY KEY(type_no)
);
DROP TABLE product_type;
SELECT * FROM product_type;

-- 상품타입 데이터
insert into product_type values(1,'노트북');
insert into product_type values(2,'마우스');
insert into product_type values(3,'키보드');
SELECT * FROM product_type;

-- 상품스펙 테이블
CREATE TABLE product_spec (
    spec_no INT NOT NULL AUTO_INCREMENT,
    product_no INT NOT NULL,
    category_no VARCHAR(50) NOT NULL,
    option_value VARCHAR(50),
    CONSTRAINT product_spec_PK PRIMARY KEY(spec_no),
    CONSTRAINT fk_product_spec_product_no FOREIGN KEY (product_no) REFERENCES product(product_no),
    CONSTRAINT fk_product_spec_category_no FOREIGN KEY (category_no) REFERENCES product_category(category_no)
);
DROP TABLE product_spec;
SELECT * FROM product_spec;
-- 위시리스트 테이블
CREATE TABLE wishlist (
	wishlist_no INT NOT NULL AUTO_INCREMENT,
	product_no INT NOT NULL,
	member_no INT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT wishlist_PK PRIMARY KEY(wishlist_no)
);
DROP TABLE wishlist ;
SELECT * FROM wishlist;

-- 이미지 매핑 테이블
CREATE TABLE images (
	image_no INT NOT NULL AUTO_INCREMENT,
	reference_code VARCHAR(255) NOT NULL,
	origin_name VARCHAR(255) NOT NULL,
	upload_name VARCHAR(255) NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT images_PK PRIMARY KEY(image_no)
);
DROP TABLE images ;
SELECT * FROM images;


-- 리뷰 데이터 테이블
create table review (
	review_no INT NOT NULL AUTO_INCREMENT PRIMARY key,
	product_no INT NOT NULL,
	rating INT NOT NULL,
	title varchar(255) NOT NULL,
	content text NOT null,
	create_date TIMESTAMP default CURRENT_TIMESTAMP,
	FOREIGN key (product_no) REFERENCES product(product_no) ON DELETE CASCADE

);
DROP TABLE review;
SELECT * FROM ;

CREATE VIEW view_paymentpage AS
SELECT 
    pd.product_name,
    pd.product_code,
    pd.type_no,
    pd.price,
    GROUP_CONCAT(CONCAT(pd.options, ' : ', pd.option_value) SEPARATOR ' / ') AS product_info,
    MAX(pd.upload_name) AS upload_name
FROM 
    product_detail pd
GROUP BY 
    pd.product_name, pd.product_code, pd.type_no, pd.price;
SELECT * FROM view_paymentpage;
DROP VIEW view_paymentpage;