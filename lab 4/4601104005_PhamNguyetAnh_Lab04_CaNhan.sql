﻿/*---------------------------------------------------------- 
MASV: 46.01.104.005 
HOTEN: Phạm Nguyệt Anh 	 	

LAB: 04 - CÁ NHÂN
NGAY: 14/04/2023
----------------------------------------------------------*/ 

-- a) CAU LENH TAO DB
CREATE DATABASE QLSV2
GO

USE QLSV2
GO

-- b) CAC CAU LENH TAO TABLE
CREATE TABLE SINHVIEN 
(
	MASV VARCHAR(20) PRIMARY KEY,
	HOTEN NVARCHAR(100) NOT NULL,
	NGAYSINH DATETIME NULL,
	DIACHI NVARCHAR(200) NULL,
	MALOP VARCHAR(20) NULL,
	TENDN NVARCHAR(100) NOT NULL,
	MATKHAU VARCHAR(MAX) NOT NULL
)
 
CREATE TABLE NHANVIEN
(
	MANV VARCHAR(20) PRIMARY KEY,
	HOTEN NVARCHAR(100) NOT NULL,
	EMAIL VARCHAR(20) NULL,
	LUONG VARCHAR(MAX) NULL,
	TENDN NVARCHAR(100) NOT NULL,
	MATKHAU VARCHAR(MAX) NOT NULL,
	PUBKEY VARCHAR(20)
)

CREATE TABLE LOP 
(
	MALOP VARCHAR(20) PRIMARY KEY,
	TENLOP NVARCHAR(100) NOT NULL,
	MANV VARCHAR(20) NULL
)

CREATE TABLE HOCPHAN
(
	MAHP VARCHAR(20) PRIMARY KEY,
	TENHP NVARCHAR(100) NOT NULL,
	SOTC INT NULL
)

CREATE TABLE BANGDIEM 
(
	MASV VARCHAR(20) NOT NULL,
	MAHP VARCHAR(20) NOT NULL,
	DIEMTHI VARBINARY(MAX) NOT NULL
	FOREIGN KEY (MASV) REFERENCES SINHVIEN (MASV), 
	FOREIGN KEY (MAHP) REFERENCES HOCPHAN (MAHP) 
)


-- c) CAU LENH TAO STORED PROCEDURE
/*
	(i)		Stored dùng để thêm mới dữ liệu (Insert) vào table SINHVIEN
*/
GO
ALTER PROCEDURE SP_INS_ENCRYPT_SINHVIEN
	@MASV VARCHAR(20),
	@HOTEN NVARCHAR(100), 
	@NGAYSINH DATETIME,
	@DIACHI NVARCHAR(200),
	@MALOP VARCHAR(20),
	@TENDN NVARCHAR(100),
	@MATKHAU VARCHAR(MAX)
AS
BEGIN
	/*DECLARE	@MD5 VARBINARY(MAX)
	SET @MD5 = CONVERT(varbinary(MAX), HASHBYTES('MD5', @MATKHAU),2)*/
	INSERT INTO SINHVIEN(MASV, HOTEN, NGAYSINH, DIACHI, MALOP, TENDN, MATKHAU) 
	VALUES(@MASV, @HOTEN, @NGAYSINH, @DIACHI, @MALOP, @TENDN, @MATKHAU)
END
SELECT * FROM SINHVIEN
--DELETE FROM SINHVIEN WHERE MASV = 'SV04'
EXEC SP_INS_ENCRYPT_SINHVIEN 'SV03', 'ANH3', '1/1/1990', '280 AN DUONG VUONG', 'CNTT-K35', 'NVA', 'i2yBMU+FxDo='
EXEC SP_INS_ENCRYPT_SINHVIEN 'SV01', 'ANH2', '1/1/1990', '280 AN DUONG VUONG', 'CNTT-K35', 'SVANH1', 'i2yBMU+FxDo='
/*
	(ii)	Stored  dùng để  thêm  mới  dữ  liệu  (Insert)  vào  table  NHANVIEN,
			trong đó  thuộc  tính MATKHAU được  mã  hóa  (HASH)  sử  dụng  SHA1  và  
			thuộc  tính  LUONG sẽ được  mã hóa sử dụng thuật toán AES 256, với khóa mã 
			hóa là mã số của sinh viên thực hiện bài Lab này. 
*/
GO
CREATE SYMMETRIC KEY SK02
WITH 
	ALGORITHM = AES_256
	ENCRYPTION BY PASSWORD  = '46.01.104.005'
GO
 
CREATE PROC SP_INS_ENCRYPT_NHANVIEN 
	@MANV VARCHAR(20),
	@HOTEN NVARCHAR(100),
	@EMAIL VARCHAR(20),
	@LUONG VARCHAR(MAX),
	@TENDN NVARCHAR(100),
	@MATKHAU VARCHAR(MAX)
AS
BEGIN
	DECLARE @MATKHAUBINARY VARBINARY(MAX)
	SET @MATKHAUBINARY = CONVERT(VARBINARY(MAX), HASHBYTES('SHA1', @MATKHAU), 2)

	SET NOCOUNT ON;
	 
	OPEN SYMMETRIC KEY SK02
	DECRYPTION BY PASSWORD = '46.01.104.005' 

	INSERT INTO NHANVIEN(MANV, HOTEN, EMAIL, LUONG, TENDN, MATKHAU) 
	VALUES(@MANV, @HOTEN, @EMAIL, ENCRYPTBYKEY(KEY_GUID('SK01'), CONVERT(VARBINARY(MAX), @LUONG)) , @TENDN, @MATKHAUBINARY)

	CLOSE SYMMETRIC KEY SK02
END
SELECT * FROM NHANVIEN
EXEC SP_INS_ENCRYPT_NHANVIEN 'NV01', 'NGUYEN VAN A', 'NVA@', 'aaaaaaaa', 'NVA', '7C4A8D09CA3762AF61E59520943DC26494F8941B'
EXEC SP_INS_ENCRYPT_NHANVIEN 'NV04', 'ANH4', 'NVA@', 'aaaaaaaa', 'NVANH4', 'bbbbbbbb'

/*
	(iii)	Stored dùng để truy vấn dữ liệu nhân viên (NHANVIEN) 
*/
ALTER PROCEDURE SP_SEL_ENCRYPT_NHANVIEN 
AS
BEGIN
	OPEN SYMMETRIC KEY SK02
	DECRYPTION BY PASSWORD = '46.01.104.005'

	SELECT MANV, HOTEN, EMAIL, CONVERT(VARCHAR(MAX), DECRYPTBYKEY(LUONG)) AS LUONGCB
	FROM NHANVIEN

	CLOSE SYMMETRIC KEY SK02
END
EXECUTE SP_SEL_ENCRYPT_NHANVIEN
select * from NHANVIEN 
SELECT * FROM SINHVIEN 