-- ĐỀ 1 --
-- 1a. Đảm bảo tải trong xe tất cả các loại xe không quá 30 tấn.
ALTER TRIGGER TG_VANCHUYEN_TAITRONGXE ON Vanchuyen
FOR INSERT
AS
BEGIN
	DECLARE @Taitrong INT
	SELECT @Taitrong = TaiTrong FROM inserted

	IF (@Taitrong > 30)
	BEGIN
		RAISERROR(N'Tải trong xe không quá 30 tấn', 15, 1)
		ROLLBACK tran
		RETURN
	END
END
SET IDENTITY_INSERT [VanChuyen] ON 
INSERT [VanChuyen] ([MaChuyen], [MaTaiXe], [BienSo], [TaiTrong], [QuangDuong], [NgayChuyen]) VALUES (5, N'X001', N'55K1-10003', 37, 50, CAST(N'2001-01-10' AS Date))
SET IDENTITY_INSERT [VanChuyen] OFF 

-- 1b. Loại GPLX phải thuộc các loại (B1,B2,C,D,E,F). 
CREATE TRIGGER TG_BANGLAI_GPLX ON BANGLAI
FOR INSERT
AS
BEGIN
	DECLARE @Loai NVARCHAR(50)
	SELECT @Loai = LoaiGPLX FROM inserted

	IF (@Loai NOT IN(N'B1', N'B2', N'C', N'D', N'F'))
	BEGIN 
		RAISERROR(N'Loại GPLX phải thuộc các loại (B1,B2,C,D,E,F)', 15, 1)
		ROLLBACK tran
		RETURN
	END
END
INSERT [BangLai] ([MaBangLai], [MaTaiXe], [NgayCap], [LoaiGPLX]) VALUES (N'M009', N'X001', CAST(N'1990-12-01' AS Date), N'B2')

-- 2a. In danh sách các thông tin bằng lái của tài xế theo Loại GPLX
-- Input: @LoaiGPLX
-- Output: In thông tin gồm “Mã tài xế- Họ tên tài xế-Độ tuổi – Mã bằng lái”
go
create PROCEDURE PROC_BANGLAI_TAIXE_GPLX @Loai NVARCHAR(50)
AS
BEGIN
	DECLARE Point CURSOR
	FOR 
		SELECT TaiXe.MaTaiXe, HoTenTaiXe, NgaySinh, MaBangLai
		FROM TaiXe JOIN BangLai ON TaiXe.MaTaiXe = BangLai.MaTaiXe 
		WHERE LoaiGPLX = @Loai

	OPEN Point
		DECLARE @Mataixe VARCHAR(4), @Hoten NVARCHAR(50), @Ngaysinh DATE, @MaBangLai VARCHAR(4)
		FETCH NEXT FROM Point INTO @Mataixe, @Hoten, @Ngaysinh, @MaBangLai
		WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT(CAST(@Mataixe AS NVARCHAR(50)) + N'-' + @Hoten + N'-' + CAST(DATEPART(yyyy, GETDATE())  - (YEAR(@Ngaysinh)) AS NVARCHAR(50)) + N'-' + @MaBangLai)    
			FETCH NEXT FROM Point INTO @Mataixe, @Hoten, @Ngaysinh, @MaBangLai
		END
	CLOSE Point
	DEALLOCATE Point
END
EXECUTE PROC_BANGLAI_TAIXE_GPLX N'C1'
 
-- ĐỀ 2 --
-- 1a. Đảm bảo tải tuổi tài xế trên 25 tuổi
go
CREATE TRIGGER TG_TAIXE_TUOI ON TAIXE
FOR INSERT
AS
BEGIN
	DECLARE @Tuoi INT
	SELECT @Tuoi = DATEPART(yyyy, GETDATE())  - (YEAR(NgaySinh)) FROM inserted

	IF (@Tuoi < 26)
	BEGIN
		RAISERROR(N'Tài xế phải trên 25 tuổi', 15, 1)
		ROLLBACK TRAN
		RETURN
	END
END
SELECT * FROM TaiXe
INSERT [TaiXe] ([MaTaiXe], [HoTenTaiXe], [NgaySinh], [DiaChi]) VALUES (N'X010', N'Nguyễn Minh An', CAST(N'2007-04-02' AS Date), N'Phổ Quang, Tân Bình, Tp Hồ Chí Minh')


-- 1b. Tên nhà sản xuất phải thuộc thương hiệu “Huyndai, ThaCo, KIA, Honda”.
CREATE TRIGGER TB_LOAIXE_NHASX ON LoaiXe
FOR INSERT
AS
BEGIN
	DECLARE @NhaSX NVARCHAR(20)
	SELECT @NhaSX = NhaSX FROM inserted
	
	IF (@NhaSX NOT IN (N'Huyndai', N'ThaCo', N'KIA', N'Honda'))
	BEGIN
		RAISERROR(N'Tên nhà sản xuất phải thuộc thương hiệu “Huyndai, ThaCo, KIA, Honda”', 15, 1)
		ROLLBACK TRAN
		RETURN
	END
END

SELECT * FROM LoaiXe
INSERT [LoaiXe] ([MaLoaiXe], [TenLoaiXe], [NhaSX], [TaiTrongXe], [NienHan]) VALUES (N'L005', N'Tải hạng nhẹ', N'ThaCo', 6, 50)

-- 2a. In danh sách các thông tin xe theo Nhà sản xuất
-- Input: @NhaSX
-- Output: In thông tin gồm “Biển số- Tên loại xe – Số năm đã sử dụng – Số km”
go
CREATE PROCEDURE PROC_IN_THONG_TIN_XE @NhaSX NVARCHAR(20)
AS
BEGIN
	DECLARE Point CURSOR
	FOR 
		SELECT BienSo, TenLoaiXe, (DATEPART(yyyy, GETDATE()) - YEAR(NgayMua)) AS SoNam, SoKm
		FROM XeTai JOIN LoaiXe ON XeTai.MaLoaiXe = LoaiXe.MaLoaiXe
		WHERE NhaSX = @NhaSX

		OPEN Point
			DECLARE @Bienso VARCHAR(10), @Tenloaixe NVARCHAR(50), @Sonam INT, @Sokm INT
			FETCH NEXT FROM Point INTO @Bienso, @Tenloaixe, @Sonam, @Sokm
			WHILE @@FETCH_STATUS = 0
			BEGIN
				PRINT(@Bienso + ' - ' + @Tenloaixe + ' - ' + CAST(@Sonam AS NVARCHAR(50)) + ' - ' + CAST(@Sokm AS NVARCHAR(50)))
			FETCH NEXT FROM Point INTO @Bienso, @Tenloaixe, @Sonam, @Sokm
			END
		CLOSE Point
		DEALLOCATE Point
END
EXECUTE PROC_IN_THONG_TIN_XE N'Honda'