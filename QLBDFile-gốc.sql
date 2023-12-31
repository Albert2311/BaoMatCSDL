create database QLBongDa
GO
use QLBongDa
go

create table QUOCGIA
(
	MAQG varchar(5),
	TENQG nvarchar(60) not null,
	constraint pk_quocgia primary key (MAQG),
)
go

create table TINH 
(
	MATINH varchar(5),
	TENTINH nvarchar(100) not null,
	constraint pk_tinh primary key (MATINH)
)
go

create table SANVD
(
	MASAN varchar(5),
	TENSAN nvarchar(100) not null,
	DIACHI nvarchar(100),
	constraint pk_sanvd primary key (MASAN)
)
go

create table HUANLUYENVIEN
(
	MAHLV varchar(5),
	TENHLV nvarchar(100) not null,
	NGAYSINH datetime,
	DIACHI nvarchar(100),
	DIENTHOAI nvarchar(20),
	MAQG varchar(5) not null,
	constraint pk_hlv primary key (MAHLV),
	constraint fk_hlv foreign key (MAQG) references QUOCGIA(MAQG)
)
go

create table CAULACBO
(
	MACLB varchar(5),
	TENCLB nvarchar(100),
	MASAN varchar(5),
	MATINH varchar(5),

	constraint pk_caulacbo primary key (MACLB),
	constraint fk_caulacbo_sanvd foreign key                    (MASAN) references SANVD(MASAN),
	constraint fk_caulacbo_tinh foreign key                   (MATINH) references TINH(MATINH)
)
go

create table HLV_CLB
(
	MAHLV varchar(5),
	MACLB varchar(5),
	VAITRO nvarchar(100)
	
        constraint pk_hlvclb primary key                       (MAHLV,MACLB),
	constraint fk_hlvclb_hlv foreign key                   (MAHLV) references HUANLUYENVIEN(MAHLV),
	constraint fk_hlvclb_clb foreign key                   (MACLB) references CAULACBO(MACLB)
)
go

create table CAUTHU
(
	MACT numeric identity,
	HOTEN nvarchar(100) not null,
	VITRI nvarchar(50) not null,
	NGAYSINH datetime,
	DIACHI nvarchar(200),
	MACLB varchar(5) not null,
	MAQG varchar(5) not null,
	SO int not null,
	constraint pk_cauthu primary key (MACT),
	constraint fk_cauthu_hlv foreign key (MACLB) references CAULACBO(MACLB),
	constraint fk_cauthu_quocgia foreign key (MAQG) references QUOCGIA(MAQG)
)
go

create table TRANDAU
(
	MATRAN numeric identity,
	NAM int not null,
	VONG int not null,
	NGAYTD datetime not null,
	MACLB1 varchar(5) not null,
	MACLB2 varchar(5) not null,
	MASAN varchar(5) not null,
	KETQUA varchar(5) not null,
	constraint pk_trandau primary key (MATRAN),
	constraint fk_clb1 foreign key (MACLB1) references CAULACBO(MACLB),
	constraint fk_clb2 foreign key (MACLB2) references CAULACBO(MACLB),
	constraint fk_clb3 foreign key (MASAN) references SANVD(MASAN)
)
go

create table THAMGIA 
(
	MATD numeric,
	MACT numeric,
	SOTRAI int,
	constraint pk_thamgia primary key (MATD,MACT),
	constraint fk_thamgia_tran foreign key (MATD) references TRANDAU(MATRAN),
	constraint fk_thamgia_cauthu foreign key (MACT) references CAUTHU(MACT)
)
go

create table BANGXH
(
	MACLB varchar(5),
	NAM int,
	VONG int,
	SOTRAN int not null,
	THANG int not null,
	HOA int not null,
	THUA int not null,
	HIEUSO varchar(5) not null,
	DIEM int not null,
	HANG int not null,
	constraint pk_bangxh primary key (MACLB,NAM,VONG),
	constraint fk_bangxh foreign key (MACLB) references CAULACBO(MACLB)
)
go


--------UPDATE CO SO DU LIEU
insert into QUOCGIA(MAQG,TENQG) VALUES
('ANH',N'Anh Quốc'),
('BDN',N'Bồ Đào Nha'),
('BRA',N'Bra-xin'),
('HQ',N'Hàn Quốc'),
('ITA',N'Ý'),
('TBN',N'Tây Ban Nha'),
('THA',N'Thái Lan'),
('THAI',N'Thái Lan'),
('VN',N'Việt Nam')


insert into TINH(MATINH,TENTINH) VALUES
('BD',N'Bình Dương'),
('DN',N'Đà Nẵng'),
('DT',N'Đồng Tháp'),
('GL',N'Gia Lai'),
('HN',N'Hà Nội'),
('HP',N'Hải Phòng'),
('KH',N'Khánh Hòa'),
('LA',N'Long An'),
('NA',N'Nghệ An'),
('NB',N'Ninh Bình'),
('PY',N'Phú Yên'),
('SG',N'Sài Gòn'),
('TH',N'Thanh Hóa')

insert into SANVD values
('CL',N'Chi Lăng',N'127 Võ Văn Tần, Đà Nẵng'),
('CLDT',N'Cao Lãnh',N'134 TX Cao Lãnh, Đồng Tháp'),
('GD',N'Gò Đậu', N'123 QL1, TX Thủ Dầu Một, Bình Dương'),
('HD',N'Hàng Đẫy',N'345 Lý Chiêu Hoàng, Bạch Mai, Hà Nội'),
('LA',N'Long An',N'102 Hùng Vương, Tp Tân An, Long An'),
('NT',N'Nha Trang',N'128 Phan Chu Trinh, Nha Trang, Khánh Hòa'),
('PL',N'Pleiku',N'22 Hồ Tùng Mậu, Thống Nhất, Thị xã Pleiku, Gia Lai'),
('TH',N'Tuy Hòa',N'57 Trường Chinh, Tuy Hòa, Phú Yên'),
('TN',N'Thống Nhất',N'123 Lý Thường Kiệt, Quận 5, TpHCM')


insert into HUANLUYENVIEN
values 
('HLV01',N'Vital','1955-10-15',null,'0918011075','BDN'),
('HLV02',N'Lê Huỳnh Đức','1972-5-20',null,'01223456789','VN'),
('HLV03',N'Kiatisuk','1970-12-11',null,'0199123456','THA'),
('HLV04',N'Hoàng Anh Tuấn','1970-6-10',null,'0989112233','VN'),
('HLV05',N'Trần Công Minh','1973-7-7',null,'0909099990','VN'),
('HLV06',N'Trần Văn Phúc','1965-3-2',null,'01650101234','VN'),
('HLV07',N'Yoon-Hwan-Cho','1960-2-2',null,null,'HQ'),
('HLV08',N'Yun-Kyum-Choi','1962-3-3',null,null,'HQ')


insert into CAULACBO
values ('BBD',N'BECAMEX BÌNH DƯƠNG','GD','BD'),
('CSDT',N'TẬP ĐOÀN CAO SU ĐỒNG THÁP','CLDT','DT'),
('GDT',N'GẠCH ĐỒNG TÂM LONG AN','LA','LA'),
('HAGL',N'HOÀNG ANH GIA LAI','PL','GL'),
('KKH',N'KHATOCO KHÁNH HÒA','NT','KH'),
('SDN',N'SHB ĐÀ NẴNG','CL','DN'),
('TPY',N'THÉP PHÚ YÊN','TH','PY')


insert into HLV_CLB values
('HLV01','GDT',N'HLV Chính'),
('HLV02','SDN',N'HLV Chính'),
('HLV03','HAGL',N'HLV Chính'),
('HLV04','KKH',N'HLV Chính'),
('HLV05','TPY',N'HLV Chính'),
('HLV06','CSDT',N'HLV Chính'),
('HLV07','BBD',N'HLV Chính'),
('HLV08','BBD',N'HLV Thủ Môn')

insert into CAUTHU (HOTEN,VITRI,NGAYSINH,MACLB,MAQG,SO)
values (N'Nguyễn Vũ Phong',N'Tiền Vệ','2016-10-23','BBD','VN',17),
(N'Nguyễn Công Vinh',N'Tiền Đạo','2016-10-23','HAGL','VN',9),
(N'Nguyễn Hồng Sơn',N'Tiền Vệ','2016-10-23','SDN','VN',9),
(N'Lê Tấn Tài',N'Tiền Vệ','2016-10-23','KKH','VN',14),
(N'Phạm Hồng Sơn',N'Thủ Môn','2016-10-23','HAGL','VN',1),
(N'Ronaldo',N'Tiền Vệ','2016-10-23','SDN','BRA',7),
(N'Ronaldo',N'Tiền Vệ','2016-10-23','SDN','BRA',8),
(N'Vidic',N'Tiền Vệ','2016-10-23','HAGL','ANH',3),
(N'Trần Văn Santos',N'Thủ Môn','2016-10-23','BBD','BRA',1),
(N'Nguyễn Trường Sơn',N'Hậu Vệ','2016-10-23','BBD','VN',4),
(N'Lê Huỳnh Đức',N'Tiền Đạo','2016-10-23','BBD','VN',10),
(N'Huỳnh Hồng Sơn',N'Tiền Vệ','2016-10-23','BBD','VN',9),
(N'Lee Nguyễn',N'Tiền Đạo','2016-10-23','BBD','VN',14),
(N'Bùi Tấn Trường',N'Thủ Môn','2016-10-23','CSDT','VN',1),
(N'Phan Văn Tài Em',N'Tiền Vệ','2016-10-23','GDT','VN',10),
(N'Lý Tiểu Long',N'Tiền Vệ','2016-10-23','TPY','VN',7)


insert into TRANDAU (NAM,VONG,NGAYTD,MACLB1,MACLB2,MASAN,KETQUA) values
(2009,1,'2009-02-07','BBD','SDN','GD','3-0'),
(2009,1,'2009-02-07','KKH','GDT','NT','1-1'),
(2009,2,'2009-02-16','SDN','KKH','CL','2-2'),
(2009,2,'2009-02-16','TPY','BBD','TH','5-0'),
(2009,3,'2009-03-01','TPY','GDT','TH','0-2'),
(2009,3,'2009-03-01','KKH','BBD','NT','0-1'),
(2009,4,'2009-03-07','KKH','TPY','NT','1-0'),
(2009,4,'2009-03-07','BBD','GDT','GD','2-2')


insert into THAMGIA
values
('1','1','2'),
('1','11','1'),
('2','4','1'),
('2','16','1'),
('3','3','1'),
('3','4','2'),
('3','7','1'),
('4','15','5'),
('5','16','2'),
('6','13','1'),
('7','4','1'),
('8','12','2'),
('8','16','2')



insert into BANGXH
values 
('BBD','2009','1','1','1','0','0','3-0','3','1'),
('KKH','2009','1','1','0','1','0','1-1','1','2'),
('GDT','2009','1','1','0','1','0','1-1','1','3'),
('TPY','2009','1','0','0','0','0','0-0','0','3'),
('SDN','2009','1','1','0','0','1','0-3','0','5'),
('TPY','2009','2','1','1','0','0','5-0','3','1'),
('BBD','2009','2','2','1','0','1','3-5','3','2'),
('KKH','2009','2','2','0','2','0','3-3','2','3'),
('GDT','2009','2','1','0','1','0','1-1','1','4'),
('SDN','2009','2','2','1','1','0','2-5','1','5'),
('BBD','2009','3','3','2','0','1','4-5','6','1'),
('GDT','2009','3','2','1','1','0','3-1','4','2'),
('TPY','2009','3','2','1','0','1','5-2','3','3'),
('KKH','2009','3','3','0','2','1','3-4','2','4'),
('SDN','2009','3','2','1','1','0','2-5','1','5'),
('BBD','2009','4','4','2','1','1','6-7','7','1'),
('GDT','2009','4','3','1','2','0','5-1','5','2'),
('KKH','2009','4','4','1','2','1','4-4','5','3'),
('TPY','2009','4','3','1','0','2','5-3','3','4'),
('SDN','2009','4','2','1','1','0','2-5','1','5')


/*BÀI TẬP*/
/*PHẦN 9 TRIGGER*/
/*Bài 48: Khi thêm cầu thủ mới, kiểm tra vị trí trên sân của cần thủ chỉ thuộc một trong các
vị trí sau: Thủ môn, Tiền đạo, Tiền vệ, Trung vệ, Hậu vệ.*/
go
CREATE TRIGGER TG_VITRI ON CAUTHU FOR INSERT
AS
BEGIN
	DECLARE @VITRI NVARCHAR(50)
	SELECT @VITRI = VITRI FROM inserted 
	IF @VITRI NOT IN (N'Hậu vệ', N'Tiền vệ', N'Trung vệ', N'Thủ môn' ,N'Tiền đạo')
	BEGIN
		RAISERROR ('VI TRI KHONG HOP LE',15,1)
		ROLLBACK TRAN
		RETURN
	END
END

insert into CAUTHU (HOTEN,VITRI,NGAYSINH,MACLB,MAQG,SO) values (N'Nguyễn Vũ Phong',N'Tiền','2016-10-23','BBD','VN',17)
/*49. Khi thêm cầu thủ mới, kiểm tra số áo của cầu thủ thuộc cùng một câu lạc bộ phải
khác nhau.*/
-- CREATE ALTER
go
ALTER TRIGGER TG_SOAO ON CAUTHU FOR INSERT
AS
BEGIN
	DECLARE @SO INT, @MACLB varchar(5)
	SELECT @SO = SO , @MACLB = MACLB FROM inserted
	IF ((SELECT COUNT(*) FROM CAUTHU WHERE @MACLB = MACLB AND @SO=SO) > 1)
	BEGIN 
		RAISERROR (N'SỐ ÁO BỊ TRÙNG', 15,1)
		ROLLBACK TRAN
		RETURN
	END
END
insert into CAUTHU (HOTEN,VITRI,NGAYSINH,MACLB,MAQG,SO) values (N'Nguyễn Vũ Phong',N'Tiền vệ','2016-10-23','BBD','VN',2)
/*50. Khi thêm thông tin cầu thủ thì in ra câu thông báo bằng Tiếng Việt ‘Đã thêm cầu
thủ mới’.*/
--CREATE 
CREATE TRIGGER TG_INTHONGTIN ON CAUTHU FOR INSERT
AS
BEGIN
	PRINT N'Đã thêm cầu thủ mới'
END
/*51. Khi thêm cầu thủ mới, kiểm tra số lượng cầu thủ nước ngoài ở mỗi câu lạc bộ chỉ
được phép đăng ký tối đa 8 cầu thủ.*/
/*CÁCH 1*/
--CREATE ALTER
go
ALTER trigger tg_CAUTHU_NUOCNGOAI on CAUTHU
FOR INSERT
AS
BEGIN
   declare @maqg varchar(5), @maclb varchar(5)
   select @maqg=maqg , @maclb = MACLB from inserted

   declare @mavn varchar(5) --luu mã quoc gia vn 
   select @mavn = MAQG from QUOCGIA where TENQG = N'Việt Nam'

   declare @sl_nb int --DEM SL CAUTHU NGOAI BINH
   select @sl_nb = COUNT(MACT)
   FROM CAULACBO JOIN CAUTHU ON CAULACBO.MACLB=CAUTHU.MACLB
   WHERE CAULACBO.MACLB = @maclb AND MAQG <> @mavn

   if((@maqg <> @mavn) AND (@sl_nb > 2))
   begin 
		raiserror (N'Đội đã đủ 2 cầu thủ ngoại binh',15,2)
		rollback tran
		return 
	end
	ELSE
	BEGIN
			PRINT N'Đã thêm cầu thủ mới'
	END
	
END
SELECT * FROM CAUTHU where maclb = 'HAGL'
SELECT * FROM CAULACBO
insert into CAUTHU (HOTEN,VITRI,NGAYSINH,MACLB,MAQG,SO) values (N'Nguyễn Vũ',N'Tiền vệ','2016-10-23','HAGL','ANH',22)
/*CÁCH 2*/
ALTER TRIGGER TG_CAUTHU_NGOAI ON CAUTHU FOR INSERT
AS
BEGIN
	DECLARE @MACLB VARCHAR(5)
	SELECT @MACLB = MACLB  FROM inserted
	IF ((SELECT COUNT (MACT) FROM CAUTHU WHERE MAQG != 'VN' AND @MACLB = MACLB) > 2)
	BEGIN
		RAISERROR (N'Đội đã đủ 2 cầu thủ ngoại binh',14,1)
		ROLLBACK TRAN
		RETURN
	END
	ELSE
	BEGIN
		PRINT 'DA THEM THANH CONG'
	END
END
/*52. Khi thêm tên quốc gia, kiểm tra tên quốc gia không được trùng với tên quốc gia
đã có.*/
--ALTER CREATE
ALTER TRIGGER TG_TRUNGTQG ON QUOCGIA FOR INSERT
AS
BEGIN
	DECLARE @TENQG NVARCHAR(50)
	SELECT @TENQG = TENQG FROM inserted
	IF (SELECT COUNT (*) FROM QUOCGIA WHERE @TENQG = TENQG) > 1
	BEGIN 
		RAISERROR (N'TRÙNG TÊN QUỐC GIA',15,1)
		ROLLBACK
		RETURN
	END
END

SELECT * FROM QUOCGIA
insert into QUOCGIA(MAQG,TENQG) VALUES('ANH4',N'Anh Quốc')
/*53. Khi thêm tên tỉnh thành, kiểm tra tên tỉnh thành không được trùng với tên tỉnh
thành đã có.*/
CREATE TRIGGER TG_TRUNG_TINH ON TINH FOR INSERT
AS
BEGIN
	DECLARE @TENTINH NVARCHAR(50)
	SELECT @TENTINH = TENTINH FROM inserted
	IF(SELECT COUNT (*) FROM TINH WHERE TENTINH = @TENTINH) > 1
	BEGIN
		RAISERROR ('TRUNG TEN TINH THANH',15,1)
	END
END
insert into TINH(MATINH,TENTINH) VALUES('BD1',N'Bình Dương')
/*54. Không cho sửa kết quả của các trận đã diễn ra.*/
--ALTER CREATE
ALTER TRIGGER TG_SUA_KQ ON TRANDAU FOR UPDATE 
AS
BEGIN
	IF UPDATE (KETQUA)
	BEGIN
		RAISERROR ('KHONG THE CHINH SUA KET QUA',15,1)
		ROLLBACK TRAN
		RETURN
	END
END

SELECT * FROM TRANDAU
UPDATE TRANDAU SET KETQUA = '3-0' WHERE MATRAN = 1 
/*55. Khi phân công huấn luyện viên cho câu lạc bộ:
a. Kiểm tra vai trò của huấn luyện viên chỉ thuộc một trong các vai trò sau: HLV
chính, HLV phụ, HLV thể lực, HLV thủ môn.
b. Kiểm tra mỗi câu lạc bộ chỉ có tối đa 2 HLV chính.*/
ALTER TRIGGER TG_hlv_clb ON HLV_CLB FOR INSERT
AS
BEGIN 
	DECLARE @VAITRO NVARCHAR(20)
	SELECT @VAITRO = VAITRO FROM inserted
	IF @VAITRO NOT IN (N'HLV Chính', N'HLV phụ',N'HLV thể lực',N'HLV thủ môn')
	begin
		raiserror (N'vai tro ko hop le',15,1)
		rollback tran
		return
	end
	if(select count (*) from HLV_CLB where VAITRO = N'HLV Chính' ) > 2 
	begin
		raiserror (N'Mỗi câu lạc bộ chỉ có tối đa 2 HLV chính',15,1)
		rollback tran
		return
	end
END

SELECT * FROM HLV_CLB
select * from HUANLUYENVIEN
insert into HLV_CLB values ('HLV05','GDT',N'HLV Chính')
delete from HLV_CLB where VAITRO = N'HLV'

/*56. Khi thêm mới một câu lạc bộ thì kiểm tra xem đã có câu lạc bộ trùng tên với câu
lạc bộ vừa được thêm hay không?
a. chỉ thông báo vẫn cho insert.
b. thông báo và không cho insert.*/
--ALTER CREATE
alter trigger tg_cau_b on CAULACBO for insert
as
begin
	declare @TENCLB NVARCHAR(100)
	SELECT @TENCLB = TENCLB FROM inserted
	IF (SELECT COUNT (*) FROM CAULACBO WHERE @TENCLB = TENCLB) > 1
	BEGIN 
		RAISERROR ('CAU LAC BO NAY DA CO ROI',15,1)
		rollback tran /*bo dong nay thi van cho insert*/
		return
	END
end

select * from CAULACBO
insert into CAULACBO values ('BBD1',N'BECAMEX BÌNH DƯƠNG','GD','BD')
DELETE FROM CAULACBO WHERE MACLB = 'BBD1'
/*57. Khi sửa tên cầu thủ cho một (hoặc nhiều) cầu thủ thì in ra:
a. danh sách mã cầu thủ của các cầu thủ vừa được sửa.
b. danh sách mã cầu thủ vừa được sửa và tên cầu thủ mới.
c. danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ.
d. danh sách mã cầu thủ vừa được sửa và tên cầu thủ cũ và cầu thủ mới.
e. câu thông báo bằng Tiếng Việt:
‘Vừa sửa thông tin của cầu thủ có mã số xxx’
với xxx là mã cầu thủ vừa được sửa.*/

/*PHẦN 8: Bài tập về Store Procedure:*/
/*35. In ra dòng ‘Xin chào’ + @ten với @ten là tham số đầu vào là tên của bạn.*/
--create alter
go
alter proc hello(@ten nvarchar(50))
as
begin
	print N'Xin chào ' + @ten
end
exec hello @ten = N'Anh'
/*36. Nhập vào 2 số @s1,@s2. In ra câu ‘tổng là : @tg ‘ với @tg =@s1+@s2.*/
--create alter
go 
alter proc tong(@s1  int , @s2 int)
as
begin
	declare @tg int
	select @tg = @s1 + @s2 
	print N'Tổng là : ' + cast(@tg as nvarchar(50))
end
exec tong @s1 =2 , @s2 = 4
/*37. Nhập vào 2 số @s1,@s2. Xuat tong @s1+@s2 ra tham so @tong.*/
alter procedure tong2 (@s1 int, @s2 int,@tong int out)
as
begin
	select @tong = @s1 + @s2 
end
go
----------
declare	@tong int
declare @s1 int = 2 , @s2 int = 4
exec tong2 @s1, @s2, @tong  out
print cast(@tong as nvarchar(50))
go

/*38. Nhập vào 2 số @s1,@s2. In ra câu ‘Số lớn nhất của @s1 và @s2 là max’ với
@s1,@s2,max là các giá trị tương ứng.*/
go
alter procedure max(@s1 int , @s2 int )
as
begin 
	declare @max int
	if (@s1 > @s2)
	begin
		select @max = @s1
		print N'Số lớn nhất là ' + cast(@s1 as nvarchar(50)) 
	end
	else
	begin
		select @max = @s2
		print N'Số lớn nhất là ' + cast(@s2 as nvarchar(50)) 
	end
	return
end

exec max 2, 3
--39.Nhập vào 2 số @s1,@s2. Xuất min và max của chúng ra tham so @max.
--Cho thực thi và in giá trị của các tham số này để kiểm tra.
go
alter proc minmax(@a int , @b int,  @min int out, @max int out)
as
begin
	if(@a <  @b)
	begin
		select @a = @min , @b = @max
	end
	else
	begin
		select @b = @min , @a = @max
	end
	return
end
go
declare @min int , @max int 
declare @a int  , @b int 
exec minmax 2,9, @min out, @max out
select @min as sonho, @max as solon
/*40. Nhập vào số nguyên @n. In ra các số từ 1 đến @n.*/
go 
create proc songuyen(@n int)
as
begin
	declare @i int
	select @i = 1
	while(@i <=@n)
	begin
		print cast(@i as nvarchar(100))
		set @i += 1
	end
end
-----
exec songuyen @n = 7
/*41. Nhập vào số nguyên @n. In ra tổng và số lượng các số chẵn từ 1 đến @n*/
go 
-- alter create
alter proc so_nguyen (@n int )
as
begin
	declare @i int, @tong int
	select @i = 0, @tong = 0 
	while ( @i <= @n)
		begin
			set @tong = @tong + @i
			set @i = @i + 1
		end
		begin
			print cast(@tong as nvarchar(50))
		end
	return
end
go
exec so_nguyen @n = 3
-----------------
go
alter procedure xuatn1 (@n int)
as
begin
	declare @i int 
	set @i = 1 
	while(@i < @n)
		begin
			if (@i % 2 = 0)
				begin 
					print cast(@i as nvarchar)
				end
			set @i = @i +1
		end
end
exec xuatn1 @n = 7
/*42. Cho biết có bao nhiêu trận đấu hòa nhau ở vòng 3 năm 2009.*/
CREATE proc tran_hoa
as
begin
	declare @S nvarchar(50)
	select @S = count (*)
	from TRANDAU
	where vong = 3 and nam = 2009 and left (KETQUA, CHARINDEX('-',KETQUA) -1) = right (KETQUA, len(KETQUA) - CHARINDEX('-',KETQUA))
	PRINT N'SÔ TRẬN ĐẤU HÒA Ở VÒNG 3 NĂM 2009 LÀ ' + CAST(@S AS NVARCHAR(50))
end

tran_hoa
select * from TRANDAU where vong = 3 and nam = 2009

/*PHẦN 10: Bài tập về Cursor*/
/*58. Dùng lệnh print để in ra danh sách mã các cầu thủ, tên câu thủ, vị trí trên sân.*/
go
alter proc in_ds
as
begin
	declare point cursor
	for select MACT , HOTEN, VITRI FROM CAUTHU
	open point
		declare @mact numeric(18,1), @hoten nvarchar(50), @vitri nvarchar(100)
		fetch next from point into @mact, @hoten, @vitri 
		while @@FETCH_STATUS = 0
		begin
			print N'Mã cầu thủ: ' + cast(@mact as nvarchar(50))
			print N'Họ tên cầu thủ: ' + @hoten
			print N'Vị trí cầu thủ: ' + @vitri
			print N''
			fetch next from point into @mact , @hoten, @vitri
		end
	close point
	deallocate point
end
in_ds
/*59.Dùng lệnh print để in ra danh sách mã câu lạc bộ, tên câu lạc bộ, tên sân vận động.*/
go
alter proc in_ds_clb 
as
begin 
	declare point2 cursor
	for select MACLB , TENCLB, TENSAN FROM CAULACBO INNER JOIN SANVD ON CAULACBO.MASAN = SANVD.MASAN 
	open point2
		declare @maclb varchar(50), @tenclb nvarchar(50), @tensan nvarchar(50)
		fetch next from point2 into @maclb, @tenclb , @tensan
		while @@FETCH_STATUS = 0
		begin
			print N'Mã câu lạc bộ: ' +  @maclb
			print N'Tên câu lạc bộ: ' + @tenclb
			print N'Tên sân: ' + @tensan
			print N''
			fetch next from point2 into @maclb, @tenclb, @tensan
		end
	close point2
	deallocate point2
end
in_ds_clb
SELECT * FROM CAULACBO
SELECT * FROM SANVD

/*60. In danh sách các đội bóng và số cầu thủ nước ngoài của mỗi đội.*/
go
alter proc in_ds_ctng
as
begin
	declare point_ctng cursor
	for select CAULACBO.TENCLB , COUNT (CAUTHU.MACT) AS SL_CAUTHU_NGOAIBANG FROM CAUTHU INNER JOIN CAULACBO 
	ON CAULACBO.MACLB = CAUTHU.MACLB WHERE MAQG != 'VN' GROUP BY TENCLB
	OPEN point_ctng
		declare @tenclb nvarchar(60), @slnb nvarchar(50)
		fetch next from point_ctng into @tenclb, @slnb
		while @@FETCH_STATUS = 0
		begin 
			print N'Tên câu lạc bô: ' + @tenclb
			print N'Sô cầu thủ ngoại bang: ' + @slnb
			print N''
			fetch next from point_ctng into @slnb, @tenclb
		end
	close point_ctng
	deallocate point_ctng
end
in_ds_ctng
select * from CAULACBO
select * from CAUTHU
select TENCLB , COUNT (CAUTHU.MACT) AS SLNB FROM CAUTHU INNER JOIN CAULACBO ON CAULACBO.MACLB = CAUTHU.MACLB 
WHERE MAQG != 'VN' group by TENCLB

/*CÁCH 2*/
go
declare point_ct cursor
for select TENCLB , COUNT (MACT) AS SL_CT_NGOAI FROM CAULACBO LEFT JOIN
(
	SELECT * 
	FROM CAUTHU
	WHERE MAQG != 'VN'
) CT ON CAULACBO.MACLB = CT.MACLB GROUP BY TENCLB
OPEN point_ct 
	declare @tenclb nvarchar(50) , @sl int 
	fetch next from point_ct into @tenclb , @sl
	while @@FETCH_STATUS = 0
	begin
		print N'Tên câu lạc bộ: ' + @tenclb
		if (@sl != 0)
		begin
				print N'Số lượng cầu thủ nước ngoài: ' + cast(@sl as nvarchar(70))
				print N''
		end
			else
		begin
			print N'Không có cầu thủ nước ngoài'
			print N''
		END
		fetch next from point_ct into @tenclb , @sl
		end
close point_ct
deallocate point_ct

GO
alter proc test2 
as
begin
	declare point_test cursor
	for select TENCLB, COUNT(MACT) FROM CAULACBO LEFT JOIN
(
	SELECT * FROM CAUTHU WHERE MAQG != 'VN'
) CAUTHU ON CAULACBO.MACLB = CAUTHU.MACLB GROUP BY TENCLB
	OPEN point_test 
		declare @tenclb nvarchar(50) , @sl int
		fetch next from point_test into @tenclb , @sl 
		while @@FETCH_STATUS = 0 
		begin
			print N'Tên câu lạc bộ: ' + @tenclb 
			if (@sl != 0)
			begin
				print N'Số lượng cầu thủ ngoại bang: ' + cast(@sl as nvarchar(40))
				
			end
				else
			begin
				print N'Không có cầu thủ ngoại bang'
			end
			print N''
			fetch next from point_test into @tenclb , @sl 
		end
	close point_test
	deallocate point_test
end
/*61. In danh sách các đội bóng và ghi chú thêm cột HLV_NN, nếu có thì ghi số lượng, nếu
không có thì ghi chú là “Không có”.*/
declare point_ctnn cursor
for select TENCLB FROM CAULACBO LEFT JOIN 
(
	SELECT HLV_CLB.MACLB, COUNT(HLV_CLB.MAHLV) FROM HUANLUYENVIEN JOIN HLV_CLB 
	ON HLV_CLB.MAHLV = HUANLUYENVIEN.MAHLV WHERE MAQG != 'VN' GROUP BY HLV_CLB.MACLB
) CT ON HLV_CLB.MACLB = 
select * from HUANLUYENVIEN
SELECT * FROM HLV_CLB