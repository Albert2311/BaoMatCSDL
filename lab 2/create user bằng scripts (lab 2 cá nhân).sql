﻿use QLBongDa
go

CREATE LOGIN BDU01 WITH PASSWORD = '123';
CREATE USER BDU01 FROM LOGIN BDU01;
GRANT CREATE TABLE TO BDU01;
GRANT ALTER ON SCHEMA :: dbo to BDU01

CREATE TABLE BANG (
ID INT,
)
DROP TABLE BANG
GRANT CREATE TABLE TO BDU01;

CREATE LOGIN BDU02 WITH PASSWORD = '123';s
CREATE USER BDU02 FROM LOGIN BDU02;
GRANT select, update TO BDU02;

CREATE LOGIN BDU03 WITH PASSWORD = '123';
CREATE USER BDU03 FROM LOGIN BDU03;
GRANT select, insert, update, delete on dbo.CAULACBO TO BDU03;


CREATE LOGIN BDU04 WITH PASSWORD = '123';
CREATE VIEW VIEW_01 AS  SELECT MACT, HOTEN, VITRI, DIACHI, MACLB, MAQG, SO FROM CAUTHU
CREATE USER BDU04 FROM LOGIN BDU04;
GRANT select, delete on VIEW_01 TO BDU04;
GRANT UPDATE (MACT, HOTEN, DIACHI, MACLB, MAQG, SO) ON VIEW_01 TO BDU04 


SELECT MACT FROM CAUTHU
SELECT NGAYSINH FROM CAUTHU
UPDATE CAUTHU SET VITRI = 'TIEN VE' WHERE VITRI = N'Tiền vệ'
