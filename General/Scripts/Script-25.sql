-- New script in localhost 2.
-- Connection Type: dev 
-- Url: jdbc:mysql://localhost:3306/
-- workspace : H:\workspace\multi\04_db
-- Date: 2024. 7. 8.
-- Time: 오전 11:08:25

USE scott;
SELECT * FROM movie ORDER BY `rank`;
DROP TABLE movie;
CREATE TABLE `movie` (
`rank` int DEFAULT NULL COMMENT '순위',
`movieCd` varchar(100) DEFAULT NULL COMMENT '영화코드',
`movieNm` varchar(100) DEFAULT NULL COMMENT '영화제목',
`scrnCnt` int DEFAULT NULL COMMENT '스크린수',
`openDt` varchar(100) DEFAULT NULL COMMENT '개봉날짜'
)

CREATE TABLE movie2 (
    movienum INT AUTO_INCREMENT,
    title VARCHAR(255),
    img VARCHAR(255),
    genre VARCHAR(255),
    running_time VARCHAR(255),
    link VARCHAR(255),
    PRIMARY KEY (movienum)
);

CREATE TABLE young (
    bizId VARCHAR(50) NOT NULL,
    polyBizSjnm VARCHAR(100) NOT NULL,
    plcyTpNm VARCHAR(100) NOT NULL,
    cnsgNmor VARCHAR(100) NOT NULL,
    rqutProcCn TEXT NOT NULL,
    PRIMARY KEY (bizId)
);

SELECT * FROM young;

SELECT * FROM movie2;
INSERT INTO movie2 values(null,"1","1","1","1","!");