--cau e
/*Tạo stored procedure với yêu cầu cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ 
thuộc đội bóng “SHB Đà Nẵng” và tên quốc tịch =  “Brazil”, trong đó  tên đội  bóng/câu  lạc  bộ  
và  tên  quốc  tịch/quốc  gia  là  2  tham  số  của  stored procedure.
i)Tên stored procedure: SP_SEL_NO_ENCRYPT
ii)Danh sách tham số: @TenCLB, @TenQG*/
create proc SP_SEL_NO_ENCRYPT (@TenCLB nvarchar(50), @TenQG nvarchar(50))
as begin 
	SELECT MACT, HOTEN, NGAYSINH, DIACHI, VITRI 
	FROM CAUTHU CT JOIN CAULACBO CLB ON CT.MACLB = CLB.MACLB 
				  JOIN QUOCGIA QG ON QG.MAQG = CT.MAQG
	WHERE TENCLB = @TenCLB and TENQG = @TenQG
end
exec SP_SEL_NO_ENCRYPT N'SHB Đà Nẵng' , N'Brazil'

---------------------------------------------------
--cau f
/*Tạo stored procedure với yêu cầu như câu e, với nội dung stored được mã hóa.
i)Tên stored procedure: SP_SEL_ENCRYPT
ii)Danh sách tham số: @TenCLB, @TenQG*/
go
create proc SP_SEL_ENCRYPT  (@TenCLB nvarchar(50), @TenQG nvarchar(50)) WITH ENCRYPTION AS
begin
	SELECT MACT, HOTEN, NGAYSINH, DIACHI, VITRI 
	FROM CAUTHU CT JOIN CAULACBO CLB ON CT.MACLB = CLB.MACLB 
				  JOIN QUOCGIA QG ON QG.MAQG = CT.MAQG
	WHERE TENCLB = @TenCLB and TENQG = @TenQG
end

exec SP_SEL_ENCRYPT N'SHB Đà Nẵng' , N'Brazil'
go

-------------------------------------------
--g
/*Thực thi 2 stored procedure trên với tham số truyền vào @TenCLB = “SHB Đà Nẵng” và @TenQG = “Brazil”, xem kết quả và nhận xét*/
--cau store procedure thứ 1 ai cũng có thể xem và sửa ngược lại ở câu store procedure 2 đã được mã hóa nên không thể xem và sửa
USE QLBongDa
EXEC sp_helptext 'SP_SEL_NO_ENCRYPT';



----------------------------------------------------------
-- Tạo và phân quyền trên Views
-- cau 1
--Cho  biết mã  số,  họ  tên,  ngày  sinh, địa  chỉvà vị  trí  của  các  cầu  thủ  thuộc đội bóng “SHB Đà Nẵng” có quốc tịch “Brazil”. 
go
create view vCau1 AS
select MACT, HOTEN, VITRI, NGAYSINH, DIACHI
FROM CAUTHU CT join CAULACBO CLB on (CLB.MACLB = CT.MACLB) 
join QUOCGIA QG on (QG.MAQG = CT.MAQG)
WHERE  QG.TENQG = N'Brazil' and CLB.TENCLB = N'SHB Đà Nẵng'
GO
select * from vCau1
grant select on dbo.vCau1 to BDRead
grant select on dbo.vCau1 to BDU03
grant select on dbo.vCau1 to BDU04
GO
 -- cau 2
 --Cho  biết  kết  quả(MATRAN,  NGAYTD,  TENSAN,  TENCLB1,  TENCLB2, KETQUA)  các trận đấu vòng 3 của mùa bóng năm 2009. 
 create view vCau2 AS
 select MATRAN, NGAYTD, TENSAN, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2,
 KETQUA
 FROM TRANDAU JOIN SANVD ON TRANDAU.MASAN = SANVD.MASAN
 JOIN CAULACBO CLB1 ON TRANDAU.MACLB1 = CLB1.MACLB
 JOIN CAULACBO CLB2 ON TRANDAU.MACLB2 = CLB2.MACLB
 WHERE VONG = 3 AND NAM = 2009

select * from vCau2
grant select on dbo.vCau2 to BDRead
grant select on dbo.vCau2 to BDU03
grant select on dbo.vCau2 to BDU04
 --CAU 3
 /*Cho  biết mã  huấn  luyện  viên,  họ  tên,  ngày  sinh, địa  chỉ,  vai  trò  và  tên  CLB 
 đang làm việc của các huấn luyện viên có quốc tịch “Việt Nam”. */
 go
 create view vCau3 as
 select HLV.MAHLV, TENHLV, NGAYSINH, DIACHI , VAITRO, TENCLB
 FROM HUANLUYENVIEN HLV JOIN QUOCGIA QG ON (HLV.MAQG = QG.MAQG) 
 JOIN HLV_CLB ON HLV_CLB.MAHLV = HLV.MAHLV JOIN CAULACBO CLB ON HLV_CLB.MACLB = CLB.MACLB
 WHERE TENQG = N'Việt Nam'

 select * from vCau3
 grant select on vCau3 to BDRead
 grant select on vCau3 to BDU03
 grant select on vCau3 to BDU04
 -- cau 4
 /*Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài (có quốc tịch khác “Việt Nam”) 
 tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài. */
 go
create view vCau4 as
SELECT CLB.MACLB, TENCLB, TENSAN, SVD.DIACHI, count(CT.MACT) AS SOCAUTHUNUOCNGOAI
FROM CAULACBO CLB, SANVD SVD, CAUTHU CT
WHERE CLB.MASAN = SVD.MASAN 
AND CLB.MACLB = CT.MACLB 
AND CT.MAQG NOT LIKE (SELECT MAQG FROM QUOCGIA WHERE TENQG = N'Việt Nam')
GROUP BY CLB.MACLB, TENCLB, TENSAN, SVD.DIACHI
HAVING COUNT(CT.MACLB) >= 2

 select * from vCau4
 grant select on vCau4 to BDRead
 grant select on vCau4 to BDU03
 grant select on vCau4 to BDU04
-- cau 5
/*Cho biết tên tỉnh, số lượng cầu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc bộ thuộc địa bàn tỉnh đó quản lý. */
go
CREATE VIEW vCau5 AS
SELECT TENTINH, COUNT(MACT) AS SO_CT
FROM TINH AS TINH, CAULACBO AS CLB, CAUTHU 
WHERE TINH.MATINH = CLB.MATINH
AND CLB.MACLB = CAUTHU.MACLB
AND VITRI = N'Tiền đạo'
GROUP BY TENTINH 

select * from vCau5
grant select on dbo.vCau5 to BDRead
grant select on vCau5 to BDU01

--cau 6
/*Cho  biết  tên  câu  lạc  bộ,  tên  tỉnh  mà  CLB đang đóng nằm ở vị trí cao  nhất  của bảng xếp hạng của vòng 3, năm 2009. */
go
CREATE VIEW vCau6 AS
SELECT TENCLB, TENTINH
FROM CAULACBO AS CLB, TINH AS TINH 
WHERE CLB.MATINH = TINH.MATINH
AND CLB.MACLB = (SELECT MACLB FROM BANGXH
WHERE VONG = 3 AND NAM = 2009
AND HANG = 1)

select * from vCau6
grant select on vCau6 to BDRead
grant select on vCau6 to BDU01
-- cau 7
/*Cho  biết  tên  huấn  luyện  viên đang  nắm  giữ  một  vị  trí  trong  một  câu  lạc  bộ  mà chưa có số điện thoại. */
go
CREATE VIEW vCau7 AS
SELECT HLV.TENHLV
FROM HUANLUYENVIEN AS HLV JOIN HLV_CLB ON HLV_CLB.MAHLV = HLV.MAHLV
WHERE EXISTS (SELECT HLV_CLB.VAITRO FROM HLV_CLB) AND HLV.DIENTHOAI IS NULL

select * from vCau7
grant select on vCau7 to BDU01
grant select on vCau7 to BDRead

--cau 8
/*Liệt  kê  các  huấn  luyện  viên  thuộc  quốc  gia Việt  Nam  chưa  làm  công  tác  huấn luyện tại bất kỳ một câu lạc bộ nào. */
go
CREATE VIEW vCau8 AS
SELECT HLV.TENHLV
FROM HUANLUYENVIEN HLV JOIN QUOCGIA QG ON QG.MAQG = HLV.MAQG
WHERE NOT EXISTS (SELECT HLV_CLB.MAHLV FROM HLV_CLB WHERE HLV_CLB.MAHLV = HLV.MAHLV) AND TENQG = N'Việt Nam'

select * from vCau8
grant select on vCau8 to BDU01
grant select on vCau8 to BDRead
-- CAU 9
/*Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) 
của câu lạc bộ CLB đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009. */
GO
CREATE view vCau9 as
select NGAYTD, TENSAN, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2, KETQUA
FROM TRANDAU TD JOIN SANVD S ON S.MASAN =  TD.MASAN
				JOIN CAULACBO CLB1 ON CLB1.MACLB = TD.MACLB1 
				JOIN CAULACBO CLB2 ON CLB2.MACLB = TD.MACLB2	 
				
WHERE TD.VONG <= 3 AND TD.NAM = 2009 
AND 
(
(TD.MACLB1 = (SELECT MACLB FROM BANGXH WHERE HANG = 1 AND VONG = 3 AND NAM = 2009)) OR 
(TD.MACLB2 = (SELECT MACLB FROM BANGXH WHERE HANG = 1 AND VONG = 3 AND NAM = 2009))
)

select * from vCau9
grant select on vCau9 to BDRead
grant select on vCau9 to BDU01
--CAU 10
/*Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của câu lạc bộ CLB 
có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2009. */
GO
CREATE view vCau10 as
select NGAYTD, TENSAN, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2, KETQUA
FROM TRANDAU TD JOIN SANVD S ON S.MASAN =  TD.MASAN
				JOIN CAULACBO CLB1 ON CLB1.MACLB = TD.MACLB1 
				JOIN CAULACBO CLB2 ON CLB2.MACLB = TD.MACLB2	 
				
WHERE TD.VONG <= 3 AND TD.NAM = 2009 AND 
(
(TD.MACLB1 = (SELECT MACLB FROM BANGXH WHERE VONG = 3 AND NAM =2009 AND HANG = (SELECT MAX(HANG) FROM BANGXH WHERE VONG = 3 AND NAM = 2009 ))) OR 
(TD.MACLB2 = (SELECT MACLB FROM BANGXH WHERE VONG = 3 AND NAM =2009 AND HANG = (SELECT MAX(HANG) FROM BANGXH WHERE VONG = 3 AND NAM = 2009 )))
)

select * from vCau10
grant select on vCau10 to BDRead
grant select on vCau10 to BDU01
DROP VIEW vCau10
----------------------------------------------------------
--Tạo và phân quyền trên Stored Procedure
-- cau 1
go
CREATE PROC SPCau1 @tenclb nvarchar(50), @tenqg nvarchar(50)
as begin 
	select MACT, HOTEN, VITRI, NGAYSINH, DIACHI
	FROM CAUTHU CT join CAULACBO CLB on (CLB.MACLB = CT.MACLB) 
					join QUOCGIA QG on (QG.MAQG = CT.MAQG)
	WHERE  QG.TENQG = @tenqg and CLB.TENCLB = @tenclb
end

exec SPCau1 N'SHB Đà Nẵng', N'Brazil'
grant exec on SPCau1 to BDRead
grant exec on SPCau1 to BDU03
grant exec on SPCau1 to BDU04
------------------------------------------------
--cau 2
go
CREATE PROC SPCau2 @vong int, @nam int
as begin 
	select MATRAN, NGAYTD, TENSAN, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2,KETQUA
	FROM TRANDAU JOIN SANVD ON TRANDAU.MASAN = SANVD.MASAN
			JOIN CAULACBO CLB1 ON TRANDAU.MACLB1 = CLB1.MACLB
			JOIN CAULACBO CLB2 ON TRANDAU.MACLB2 = CLB2.MACLB
	WHERE VONG = @vong AND NAM = @nam
end

exec SPCau2 3 , 2009
grant exec on SPCau2 to BDRead
grant exec on SPCau2 to BDU03
grant exec on SPCau2 to BDU04
----------------------------------
--cau 3
go
CREATE PROC SPCau3 @tenqg nvarchar(50)
as begin 
	select HLV.MAHLV, TENHLV, NGAYSINH, DIACHI , VAITRO, TENCLB
	FROM HUANLUYENVIEN HLV JOIN QUOCGIA QG ON (HLV.MAQG = QG.MAQG) 
				JOIN HLV_CLB ON HLV_CLB.MAHLV = HLV.MAHLV JOIN CAULACBO CLB ON HLV_CLB.MACLB = CLB.MACLB
	WHERE TENQG = @tenqg
end

exec SPCau3 N'Việt Nam'
grant exec on SPCau3 to BDRead
grant exec on SPCau3 to BDU03
grant exec on SPCau3 to BDU04
-------------------------------------
--cau 4
go
CREATE PROC SPCau4 @tenqg nvarchar(50)
as begin 
	SELECT CLB.MACLB, TENCLB, TENSAN, SVD.DIACHI, count(CT.MACT) AS SOCAUTHUNUOCNGOAI
	FROM CAULACBO CLB, SANVD SVD, CAUTHU CT
	WHERE CLB.MASAN = SVD.MASAN AND CLB.MACLB = CT.MACLB 
	AND CT.MAQG NOT LIKE (SELECT MAQG FROM QUOCGIA WHERE TENQG = @tenqg)
	GROUP BY CLB.MACLB, TENCLB, TENSAN, SVD.DIACHI HAVING COUNT(CT.MACLB) >= 2
end

exec SPCau4 N'Việt Nam'
grant exec on SPCau4 to BDRead
grant exec on SPCau4 to BDU03
grant exec on SPCau4 to BDU04
------------------------------------
--cau 5
go
CREATE PROC SPCau5 @vitri nvarchar(50)
as begin 
	SELECT TENTINH, COUNT(MACT) AS SO_CT
	FROM TINH AS TINH, CAULACBO AS CLB, CAUTHU 
	WHERE TINH.MATINH = CLB.MATINH AND CLB.MACLB = CAUTHU.MACLB
	AND VITRI = @vitri GROUP BY TENTINH 
end

exec SPCau5 N'Tiền đạo'
grant exec on SPCau5 to BDRead
grant exec on SPCau5 to BDU01
------------------------------------
--cau 6
go
CREATE PROC SPCau6 @vong int, @nam int, @hang int
as begin 
	SELECT TENCLB, TENTINH
	FROM CAULACBO AS CLB, TINH AS TINH 
	WHERE CLB.MATINH = TINH.MATINH 
	AND CLB.MACLB = (SELECT MACLB FROM BANGXH WHERE VONG = @vong AND NAM = @nam AND HANG = @hang)
end

exec SPCau6 3 , 2009, 1
grant exec on SPCau6 to BDRead
grant exec on SPCau6 to BDU01
--------------------------------------
--cau 7
go
CREATE PROC SPCau7 
as begin 
	SELECT HLV.TENHLV
	FROM HUANLUYENVIEN AS HLV JOIN HLV_CLB ON HLV_CLB.MAHLV = HLV.MAHLV
	WHERE EXISTS (SELECT HLV_CLB.VAITRO FROM HLV_CLB) AND HLV.DIENTHOAI IS NULL
end

exec SPCau7
grant exec on SPCau7 to BDRead
grant exec on SPCau7 to BDU01
--------------------------
--cau 8
go
CREATE PROC SPCau8 @tenqg nvarchar(50)
as begin 
	SELECT HLV.TENHLV
	FROM HUANLUYENVIEN HLV JOIN QUOCGIA QG ON QG.MAQG = HLV.MAQG
	WHERE NOT EXISTS (SELECT HLV_CLB.MAHLV FROM HLV_CLB WHERE HLV_CLB.MAHLV = HLV.MAHLV) AND TENQG = @tenqg
end

exec SPCau8 N'Việt Nam'
grant exec on SPCau8 to BDRead
grant exec on SPCau8 to BDU01
----------------------------------
--cau 9
go
CREATE PROC SPCau9 @vong int , @nam int 
as begin 
	select NGAYTD, TENSAN, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2, KETQUA
	FROM TRANDAU TD JOIN SANVD S ON S.MASAN =  TD.MASAN
				JOIN CAULACBO CLB1 ON CLB1.MACLB = TD.MACLB1 
				JOIN CAULACBO CLB2 ON CLB2.MACLB = TD.MACLB2	 
	WHERE TD.VONG <= 3 AND TD.NAM = 2009 
AND 
( (TD.MACLB1 = (SELECT MACLB FROM BANGXH WHERE HANG = 1 AND VONG = @vong AND NAM = @nam)) OR 
(TD.MACLB2 = (SELECT MACLB FROM BANGXH WHERE HANG = 1 AND VONG = @vong AND NAM = @nam)) )
end

exec SPCau9 3, 2009
grant exec on SPCau9 to BDRead
grant exec on SPCau9 to BDU01
----------------------------------
--cau 10
go
CREATE PROC SPCau10 @vong int , @nam int 
as begin 
select NGAYTD, TENSAN, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2, KETQUA
FROM TRANDAU TD JOIN SANVD S ON S.MASAN =  TD.MASAN
				JOIN CAULACBO CLB1 ON CLB1.MACLB = TD.MACLB1 
				JOIN CAULACBO CLB2 ON CLB2.MACLB = TD.MACLB2	 	
WHERE TD.VONG <= @vong AND TD.NAM = 2009 AND 
(
(TD.MACLB1 = (SELECT MACLB FROM BANGXH WHERE VONG = @vong AND NAM =@nam AND HANG = (SELECT MAX(HANG) FROM BANGXH WHERE VONG = @vong AND NAM = @nam ))) OR 
(TD.MACLB2 = (SELECT MACLB FROM BANGXH WHERE VONG = @vong AND NAM =@nam AND HANG = (SELECT MAX(HANG) FROM BANGXH WHERE VONG = @vong AND NAM = @nam )))
)
end

exec SPCau10 3, 2009
grant exec on SPCau10 to BDRead
grant exec on SPCau10 to BDU01

----------------------------
drop proc sp_creatediagram
EXEC sp_helptext '[dbo].[SP_SEL_ENCRYPT]';

select Text from sp_helptext 

SELECT * 
  FROM [QLBongDa].INFORMATION_SCHEMA.ROUTINES
 WHERE ROUTINE_TYPE = 'PROCEDURE' 
   AND LEFT(ROUTINE_NAME, 3) NOT IN ('sp_', 'xp_', 'ms_')



SELECT [name]  FROM sysobjects WHERE [type] = 'P' AND category = 0 ORDER BY [name]

-------h



SELECT O.name, M.definition, O.type_desc, O.type 
FROM sys.sql_modules M 
INNER JOIN sys.objects O ON M.object_id=O.object_id 
WHERE O.type IN ('P');
GO

create procedure SP_encrypt_all_sp 
with ENCRYPTION
as  
begin 
	declare @name_sp nvarchar(max)
	declare point_Sp cursor for
	SELECT top 1 [name]  FROM sysobjects WHERE [type] = 'P' AND category = 0 ORDER BY [name]
	open point_Sp 
	fetch next from point_Sp into @name_sp
	while @@FETCH_STATUS = 0
	begin 
		print @name_sp
		print ''
		DECLARE @script_sp nvarchar(max)
		SELECT @script_sp =  M.definition
		FROM sys.sql_modules M 
		INNER JOIN sys.objects O ON M.object_id=O.object_id 
		WHERE O.type IN ('P') and O.name = @name_sp
		declare @split_Script nvarchar(max)
		declare point_Sp1 cursor for
		select value from string_split(@script_sp, char(10))
		open point_Sp1
		fetch next from point_Sp1 into @split_Script
		while @@FETCH_STATUS = 0
			begin
				print @split_Script
				fetch next from point_Sp1 into @split_Script
			end
			close point_Sp1
			deallocate point_Sp1
		--print @script_sp
		--print''
		fetch next from point_Sp into @name_sp
	end
	close point_Sp
	deallocate point_Sp
end





alter procedure SP_encrypt_all_sp 
with ENCRYPTION
as  
begin 
	declare @name_sp nvarchar(max)
	declare point_Sp cursor for
	SELECT [name]  FROM sysobjects WHERE [type] = 'P' AND category = 0 ORDER BY [name]
	open point_Sp 
	fetch next from point_Sp into @name_sp
	while @@FETCH_STATUS = 0
	begin 
		declare @dem int
		set @dem = 0
		declare @Script nvarchar(max)
		set @Script =''
		DECLARE @script_sp nvarchar(max)
		SELECT @script_sp =  M.definition
		FROM sys.sql_modules M 
		INNER JOIN sys.objects O ON M.object_id=O.object_id 
		WHERE O.type IN ('P') and O.name = @name_sp
		if(@script_sp IS NULL) fetch next from point_Sp into @name_sp
		declare @split_Script nvarchar(max)
		declare point_Sp1 cursor for
		select value from string_split(@script_sp, char(10))
		open point_Sp1
		fetch next from point_Sp1 into @split_Script
		while @@FETCH_STATUS = 0
			begin
				set @Script = @Script + @split_Script
				set @dem = @dem + 1
				if(@dem = 1) set @Script = @Script + 'with ENCRYPTION' + char(10)
				fetch next from point_Sp1 into @split_Script
			end
			close point_Sp1
			deallocate point_Sp1
		set @Script = (select REPLACE(@Script,'CREATE','ALTER'))
		exec (@Script)
		fetch next from point_Sp into @name_sp
	end
	close point_Sp
	deallocate point_Sp
end

exec SP_encrypt_all_sp