-- CONNECTION: url=jdbc:oracle:thin:@//localhost:1521/XE







-- New script in localhost.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//localhost:1521/XE
-- workspace : C:\Users\daten\AppData\Roaming\DBeaverData\workspace6
-- Date: 2024. 5. 3.
-- Time: 오후 5:35:33

------------------------------------------------------
--computer사용자 생성, 권한설정
CREATE USER computer identified BY 1234;
GRANT CONNECT, resource, dba  TO computer;
------------------------------------------------------
--computer사용자에서 mouse 사용자 생성, 권한설정
CREATE USER mouce IDENTIFIED BY 1111;
GRANT CONNECT TO mouce;
------------------------------------------------------
--mouse사용자에서 keyboard사용자 생성
CREATE USER keyboard identified BY 1234;
--SQL Error [1031] [42000]: ORA-01031: insufficient privileges
-------------------------------------------------------
--system계정에서 computer계정 권한해제
REVOKE resource FROM COMPUTER;
--테이블 생성
CREATE TABLE homwork(
	ID varchar2(100),
	name varchar2(100),
	TEL varchar2(100));
------------------------------------------------------
--계정삭제
DROP USER computer;--DROP 전에 계정 연결해제 먼저 처리 할것
DROP USER mouce;--DROP 전에 계정 연결해제 먼저 처리 할것
------------------------------------------------------

SELECT *FROM HOMWORK;--생성한 테이블 확인