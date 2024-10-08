-- New script in localhost 2.
-- Connection Type: dev 
-- Url: jdbc:mysql://localhost:3306/
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 7. 18.
-- Time: 오후 3:24:14
USE scott;

ALTER TABLE mem_member
ADD COLUMN is_active CHAR(1) NOT NULL DEFAULT 'N',
ADD COLUMN is_active_at TIMESTAMP NULL;

ALTER TABLE mem_member
MODIFY COLUMN email VARCHAR(255) NULL;

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
SELECT * FROM mem_delivery_address;
DROP TABLE mem_delivery_address;

INSERT INTO mem_delivery_address VALUES (NULL, 4, "우리집" , "박재민", "11111", "가나다라", "마바사", "01000000000", "가나", DEFAULT, NULL);

CREATE TABLE mem_seller_member (
    seller_id INT NOT NULL AUTO_INCREMENT,
    member_no INT NOT NULL,
    company_name VARCHAR(64) NOT NULL,
    representative_name VARCHAR(50) NOT NULL,
    business_registration_number VARCHAR(50) NOT NULL,
    PRIMARY KEY (seller_id),
    CONSTRAINT seller_member_no_fk FOREIGN KEY (member_no) REFERENCES mem_member(member_no) ON DELETE CASCADE
);



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

SELECT count(*) FROM product;






-- 프로덕트 디테일 view
CREATE VIEW vw_product_detail AS
SELECT
	p.product_no,
    p.product_name,
    p.product_code,
    p.type_no,
    p.price,
    c.category_no,
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
    images i ON p.reference_code = i.reference_code;
   
SELECT * FROM vw_product_detail;
drop view vw_product_detail

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
SELECT DISTINCT product_no FROM product_spec;

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

create view vw_spec_and_value as
    SELECT
    s.spec_no,
    s.product_no,
    s.category_no,
    s.option_value,
    c.options
    FROM
    product_spec s
    JOIN
    product p ON s.product_no = p.product_no
    JOIN
    product_category c ON s.category_no = c.category_no;
    
SELECT * FROM vw_spec_and_value;

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




CREATE TABLE personalquestion_category(
	personalq_categorycode varchar(50) PRIMARY KEY,
	personalq_categoryname varchar(100)
);
-- 상품 문의 카테고리
CREATE TABLE productquestion_category(
	productq_categorycode varchar(50) PRIMARY KEY,
	productq_categoryname varchar(100)
);
-- 1:1 문의 테이블
CREATE TABLE personal_question (
    personalq_no INT AUTO_INCREMENT PRIMARY KEY,
    member_no INT,
    personalq_categorycode VARCHAR(50),
    title VARCHAR(100) NOT NULL,
    content text NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    answer VARCHAR(2) DEFAULT 'N',
    reference_code VARCHAR(100),
    FOREIGN KEY (member_no) REFERENCES mem_member(member_no),
    FOREIGN KEY (personalq_categorycode) REFERENCES personalquestion_category(personalq_categorycode)
);

SELECT * FROM personal_question;

-- 상품 문의 테이블
CREATE TABLE product_question (
    productq_no INT AUTO_INCREMENT PRIMARY KEY,
    member_no INT,
    productq_categorycode VARCHAR(50),
    product_no int,
    title VARCHAR(100) NOT NULL,
    content text NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    answer VARCHAR(2) DEFAULT 'N',
    secret VARCHAR(2) DEFAULT 'N',
    reference_code VARCHAR(100),
    FOREIGN KEY (member_no) REFERENCES mem_member(member_no),
    FOREIGN KEY (productq_categorycode) REFERENCES productquestion_category(productq_categorycode),
    FOREIGN KEY (product_no) REFERENCES product(product_no)
);
DROP TABLE product_question;
DROP TABLE product_answer;

SELECT * FROM product_question;

-- 1:1 문의 답변 테이블
CREATE TABLE personal_answer(
	personala_no int AUTO_INCREMENT PRIMARY KEY,
	personalq_no int,
	title varchar(100) NOT null,
	content text NOT NULL,
	created_at timestamp DEFAULT current_timestamp,
	updated_at timestamp ON UPDATE CURRENT_TIMESTAMP,
	reference_code varchar(100),
	FOREIGN KEY (personalq_no) REFERENCES personal_question(personalq_no)
);
-- 상품 문의 답변 테이블
CREATE TABLE product_answer(
	producta_no int AUTO_INCREMENT PRIMARY KEY,
	productq_no int,
	title varchar(100) NOT null,
	content text NOT NULL,
	created_at timestamp DEFAULT current_timestamp,
	updated_at timestamp ON UPDATE CURRENT_TIMESTAMP,
	reference_code varchar(100),
	FOREIGN KEY (productq_no) REFERENCES product_question(productq_no)
);
-- 이미지 테이블
CREATE TABLE images(
	image_no int AUTO_INCREMENT PRIMARY KEY,
	origin_name varchar(255),
	upload_name varchar(255),
	created_at timestamp DEFAULT current_timestamp,
	updated_at timestamp ON UPDATE CURRENT_TIMESTAMP,
	reference_code varchar(100)
);

-- 공지사항 테이블
CREATE TABLE notice(
	notice_no int AUTO_INCREMENT PRIMARY KEY,
	member_no int,
	title varchar(100),
	content text,
	main_regist varchar(10) DEFAULT 'N',
	create_at timestamp DEFAULT current_timestamp,
	updated_at timestamp ON UPDATE CURRENT_TIMESTAMP,
	reference_code varchar(100),
	FOREIGN KEY (member_no) REFERENCES mem_member(member_no)
);
drop TABLE notice;
CREATE TABLE notice(
	notice_no int AUTO_INCREMENT PRIMARY KEY,
	member_no int,
	title varchar(100),
	content text,
	main_regist varchar(10) DEFAULT 'N',
	created_at timestamp DEFAULT current_timestamp,
	updated_at timestamp ON UPDATE CURRENT_TIMESTAMP,
	reference_code varchar(100),
	FOREIGN KEY (member_no) REFERENCES mem_member(member_no) ON DELETE CASCADE
);

INSERT INTO personalquestion_category VALUES ('personalq_member','회원');
INSERT INTO personalquestion_category VALUES ('personalq_else','기타');
INSERT INTO productquestion_category VALUES ('productq_product','상품');
INSERT INTO productquestion_category VALUES ('productq_else','기타');
INSERT INTO productquestion_category VALUES ('productq_opinion','의견');
INSERT INTO productquestion_category VALUES ('productq_question','문의');

-- 로그인 로그 테이블
CREATE TABLE log_login (
    login_log_id INT NOT NULL AUTO_INCREMENT,
    member_no INT NOT NULL,
    login_ip VARCHAR(45) NOT NULL,
    user_agent VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (login_log_id),
    CONSTRAINT log_login_member_no_fk FOREIGN KEY (member_no) REFERENCES mem_member(member_no) ON DELETE CASCADE
);

-- 방문자 수 테이블
CREATE TABLE log_count_visit (
    visit_log INT NOT NULL AUTO_INCREMENT,
    visit_count INT NOT NULL DEFAULT 0,
    created_at DATE NOT NULL,
    PRIMARY KEY (visit_log),
    UNIQUE (created_at)
);
SELECT * FROM log_login;
SELECT * FROM log_count_visit;

INSERT INTO log_count_visit (visit_count, created_at) 
VALUES (1, DATE_SUB(CURDATE(), INTERVAL 5 DAY));

alter table product
add column view_count INT not null default 0;

SELECT * FROM product;

CREATE TRIGGER delete_related_images
AFTER DELETE ON product
FOR EACH ROW
BEGIN
    DELETE FROM images WHERE reference_code = OLD.reference_code;
END;



-- 태그 테이블
CREATE TABLE laptop_tag (
    tag_no INT NOT NULL AUTO_INCREMENT, -- 태그 번호
    tag_data VARCHAR(50) NOT NULL,-- 태그 데이터
    CONSTRAINT laptop_tag_PK PRIMARY KEY(tag_no)
);
DROP TABLE laptop_tag;
DROP TABLE machine_tagkey;
DROP TABLE laptop_data;
DROP TABLE laptop_sentiment;
-- 매핑 테이블
CREATE TABLE machine_tagkey(
    product_no INT NOT NULL ,
    tag_no INT NOT NULL,
    PRIMARY KEY (product_no, tag_no),
   CONSTRAINT  product_FK FOREIGN KEY(product_no) REFERENCES product(product_no) ON DELETE CASCADE,
    CONSTRAINT tag_FK FOREIGN KEY(tag_no) REFERENCES laptop_tag(tag_no) ON DELETE CASCADE
);

-- 스팩 점수화 테이블
CREATE TABLE laptop_data(
    product_no INT NOT NULL AUTO_INCREMENT,
    cpu_score INT NULL,
    gpu_score INT NULL,
    ram_score INT NULL,
    storage_score INT NULL,
    price_score INT NULL,
    weight_score INT NULL,
    screen_size_score INT NULL,
    resolution_score INT NULL,
    FOREIGN KEY (product_no) REFERENCES product(product_no) ON DELETE CASCADE
);
-- 감정 분석 테이블
CREATE TABLE laptop_sentiment (
    product_no INT NOT NULL ,
        sentiment_positive INT NOT NULL,
    sentiment_denial INT NOT NULL,
    sentiment_neutrality INT NOT NULL,
    primary key (product_no),
    FOREIGN KEY (product_no) REFERENCES product(product_no) ON DELETE CASCADE
);

ALTER TABLE machine_tagkey
    ADD CONSTRAINT product_FK
     FOREIGN KEY (product_no)
     REFERENCES product(product_no)
     ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE machine_tagkey
    ADD CONSTRAINT tag_FK
    FOREIGN KEY (tag_no)
    REFERENCES laptop_tag(tag_no)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE laptop_data
    ADD CONSTRAINT product_data_FK
    FOREIGN KEY (product_no)
    REFERENCES product(product_no)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE laptop_sentiment
    ADD CONSTRAINT product_sentiment_FK
    FOREIGN KEY (product_no)
    REFERENCES product(product_no)
    ON DELETE CASCADE ON UPDATE CASCADE;

-- 태그 내용
INSERT INTO laptop_tag (tag_data) VALUES
('게이밍'),
('작업용'),
('사무용'),
('가벼움'),
('무거움'),
('넓은 화면'),
('작은 화면'),
('코딩'),
('슬림'),
('최신제품'),
('적은 USB 단자'),
('많은 USB 단자'),
('동영상 편집'),
('고전력'),
('저전력'),
('넉넉한 저장 공간'),
('높은 해상도'),
('리그오브레전드'),
('배틀그라운드'),
('로스트아크'),
('눈부심 방지'),
('중간 화면 사이즈'),
('착한 가격 겜트북'),
('착한 가격'),
('가성비 겜트북'),
('가성비'),
('고성능'),
('비즈니스 모델'),
('윈도우 있음'),
('펠월드'),
('초경량');






