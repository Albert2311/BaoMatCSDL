﻿/*---------------------------------------------------------- 
MASV: 46.01.104.065
HO TEN CAC THANH VIEN NHOM: 
	1.	Nguyễn Minh Huy 	
	2.	Phạm Nguyệt Anh		
	3.	Trần Công Bình 		
	4.	Lê Thị Thanh Chúc 	
	5.	Nguyễn Đình Khoa 	

LAB: 04 - NHOM 
NGAY: 14/04/2023
----------------------------------------------------------*/ 

-- a) CAU LENH TAO DB
CREATE DATABASE QLSV
GO

USE QLSV
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
	MATKHAU VARBINARY(MAX) NOT NULL
)
GO

CREATE TABLE NHANVIEN
(
	MANV VARCHAR(20) PRIMARY KEY,
	HOTEN NVARCHAR(100) NOT NULL,
	EMAIL VARCHAR(20) NULL,
	LUONG VARBINARY(MAX) NULL,
	TENDN NVARCHAR(100) NOT NULL,
	MATKHAU VARBINARY(MAX) NOT NULL,
	PUBKEY VARCHAR(20)
)
GO  

CREATE TABLE LOP 
(
	MALOP VARCHAR(20) PRIMARY KEY,
	TENLOP NVARCHAR(100) NOT NULL,
	MANV VARCHAR(20) NULL
)
GO


CREATE TABLE HOCPHAN
(
	MAHP VARCHAR(20) PRIMARY KEY,
	TENHP NVARCHAR(100) NOT NULL,
	SOTC INT NULL
)
GO

CREATE TABLE BANGDIEM 
(
	MASV VARCHAR(20) NOT NULL,
	MAHP VARCHAR(20) NOT NULL,
	DIEMTHI VARBINARY(MAX) NOT NULL

	CONSTRAINT BANGDIEM PRIMARY KEY (MASV, MAHP)
)
GO

-- c) CAU LENH TAO STORED PROCEDURE
/*
		i) Stored dùng để thêm mới dữ liệu (Insert) vào table NHANVIEN, trong đó  
•	Thuộc tính MATKHAU được mã hóa (HASH) sử dụng SHA1 
•	Thuộc tính LUONG sẽđược mã hóa từ tham số LUONGCB sử dụng thuật toán RSA 512,
	với khóa bí mật là tham số MK được truyền vào. 
•	Thuộc  tính  PUBKEY  sẽ  lưu  trữ  tên  khóa  công  khai được  tạo ra ứng với  
	nhân  viên này, giá trị này sẽ = với mã nhân viên. 
*/

CREATE ASYMMETRIC KEY AK01
WITH 
	ALGORITHM = RSA_2048
	ENCRYPTION BY PASSWORD = '46.01.104.065';
GO


ALTER PROCEDURE SP_INS_PUBLIC_NHANVIEN
	@MANV VARCHAR(20),
	@HOTEN NVARCHAR(100),
	@EMAIL VARCHAR(20),
	@LUONG INT,
	@TENDN NVARCHAR(100),
	@MATKHAU VARCHAR(MAX)  
AS
BEGIN
	DECLARE @MATKHAUVARBINARY VARBINARY(MAX)
	SET @MATKHAUVARBINARY = CONVERT(VARBINARY(MAX), HASHBYTES('SHA1', @MATKHAU), 2)

	DECLARE @LUONGVARBINARY VARBINARY(MAX)
	SET @LUONGVARBINARY = ENCRYPTBYASYMKEY(ASYMKEY_ID('AK01'), CONVERT(VARCHAR(MAX), @LUONG))

	INSERT INTO NHANVIEN(MANV, HOTEN, EMAIL, LUONG, TENDN, MATKHAU, PUBKEY)
	VALUES (@MANV, @HOTEN, @EMAIL, @LUONGVARBINARY, @TENDN, @MATKHAUVARBINARY, @MANV)
END

EXEC SP_INS_PUBLIC_NHANVIEN 'NV01', 'NGUYEN VAN A', 'NVA@', 3000000, 'NVA', 'abcd12'


/*
		ii) Stored dùng để truy vấn dữ liệu nhân viên (NHANVIEN) 
*/
ALTER PROCEDURE SP_SEL_PUBLIC_NHANVIEN  
	@TENDN NVARCHAR(100),
	@MATKHAU VARCHAR(MAX)  
AS
BEGIN 
	SELECT MANV, HOTEN, EMAIL, CONVERT(varchar(max), DECRYPTBYASYMKEY(ASYMKEY_ID('AK01'), LUONG, N'46.01.104.065')) AS LUONGCB
	FROM NHANVIEN
	WHERE @TENDN = TENDN AND CONVERT(VARBINARY(MAX), HASHBYTES('SHA1', @MATKHAU), 2) = MATKHAU
END

EXEC SP_SEL_PUBLIC_NHANVIEN N'NVA', '123456'
EXEC SP_SEL_PUBLIC_NHANVIEN N'NVA', '123456'

-- d) Viết các stored procedure và chương trình (sử dụng C#) để thực hiện các yêu cầu sau
--	Viết script tạo sẵn 2 nhân viên với thông tin chưa được mã hóa (LUONG, MATKHAU)

EXEC SP_INS_PUBLIC_NHANVIEN 'NV01', 'NGUYEN VAN A', 'nva@yahoo.com', 3000000, 'NVA', '123456'
EXEC SP_INS_PUBLIC_NHANVIEN 'NV02', 'NGUYEN VAN B', 'nvb@yahoo.com', 2000000, 'NVB', '1234567'

SELECT * FROM NHANVIEN

SELECT * FROM LOP

INSERT INTO LOP(MALOP, TENLOP, MANV) VALUES('L03', N'LTHDT', 'NV01')