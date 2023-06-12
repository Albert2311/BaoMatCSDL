USE [QLBongDa]
GO
/****** Object:  User [BDAdmin]    Script Date: 3/14/2023 10:06:30 AM ******/
CREATE USER [BDAdmin] FOR LOGIN [BDAdmin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [BDBK]    Script Date: 3/14/2023 10:06:30 AM ******/
CREATE USER [BDBK] FOR LOGIN [BDBK] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [BDProfile]    Script Date: 3/14/2023 10:06:30 AM ******/
CREATE USER [BDProfile] FOR LOGIN [BDProfile] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [BDRead]    Script Date: 3/14/2023 10:06:30 AM ******/
CREATE USER [BDRead] FOR LOGIN [BDRead] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [BDU01]    Script Date: 3/14/2023 10:06:30 AM ******/
CREATE USER [BDU01] FOR LOGIN [BDU01] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [BDU02]    Script Date: 3/14/2023 10:06:30 AM ******/
CREATE USER [BDU02] FOR LOGIN [BDU02] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [BDU03]    Script Date: 3/14/2023 10:06:30 AM ******/
CREATE USER [BDU03] FOR LOGIN [BDU03] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [BDU04]    Script Date: 3/14/2023 10:06:30 AM ******/
CREATE USER [BDU04] FOR LOGIN [BDU04] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [BDAdmin]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [BDBK]
GO
ALTER ROLE [db_datareader] ADD MEMBER [BDRead]
GO
ALTER ROLE [db_datareader] ADD MEMBER [BDU04]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [BDU04]
GO
/****** Object:  Table [dbo].[QUOCGIA]    Script Date: 3/14/2023 10:06:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QUOCGIA](
	[MAQG] [varchar](5) NOT NULL,
	[TENQG] [nvarchar](60) NOT NULL,
 CONSTRAINT [pk_quocgia] PRIMARY KEY CLUSTERED 
(
	[MAQG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CAULACBO]    Script Date: 3/14/2023 10:06:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAULACBO](
	[MACLB] [varchar](5) NOT NULL,
	[TENCLB] [nvarchar](100) NULL,
	[MASAN] [varchar](5) NULL,
	[MATINH] [varchar](5) NULL,
 CONSTRAINT [pk_caulacbo] PRIMARY KEY CLUSTERED 
(
	[MACLB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CAUTHU]    Script Date: 3/14/2023 10:06:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAUTHU](
	[MACT] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[HOTEN] [nvarchar](100) NOT NULL,
	[VITRI] [nvarchar](50) NOT NULL,
	[NGAYSINH] [datetime] NULL,
	[DIACHI] [nvarchar](200) NULL,
	[MACLB] [varchar](5) NOT NULL,
	[MAQG] [varchar](5) NOT NULL,
	[SO] [int] NOT NULL,
 CONSTRAINT [pk_cauthu] PRIMARY KEY CLUSTERED 
(
	[MACT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vCau1]    Script Date: 3/14/2023 10:06:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vCau1] AS
select MACT, HOTEN, VITRI, NGAYSINH, DIACHI
FROM CAUTHU CT join CAULACBO CLB on (CLB.MACLB = CT.MACLB) 
join QUOCGIA QG on (QG.MAQG = CT.MAQG)
WHERE  QG.TENQG = N'Brazil' and CLB.TENCLB = N'SHB Đà Nẵng'
GO
/****** Object:  Table [dbo].[SANVD]    Script Date: 3/14/2023 10:06:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SANVD](
	[MASAN] [varchar](5) NOT NULL,
	[TENSAN] [nvarchar](100) NOT NULL,
	[DIACHI] [nvarchar](100) NULL,
 CONSTRAINT [pk_sanvd] PRIMARY KEY CLUSTERED 
(
	[MASAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRANDAU]    Script Date: 3/14/2023 10:06:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANDAU](
	[MATRAN] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[NAM] [int] NOT NULL,
	[VONG] [int] NOT NULL,
	[NGAYTD] [datetime] NOT NULL,
	[MACLB1] [varchar](5) NOT NULL,
	[MACLB2] [varchar](5) NOT NULL,
	[MASAN] [varchar](5) NOT NULL,
	[KETQUA] [varchar](5) NOT NULL,
 CONSTRAINT [pk_trandau] PRIMARY KEY CLUSTERED 
(
	[MATRAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vCau2]    Script Date: 3/14/2023 10:06:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create view [dbo].[vCau2] AS
 select MATRAN, NGAYTD, TENSAN, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2,
 KETQUA
 FROM TRANDAU JOIN SANVD ON TRANDAU.MASAN = SANVD.MASAN
 JOIN CAULACBO CLB1 ON TRANDAU.MACLB1 = CLB1.MACLB
 JOIN CAULACBO CLB2 ON TRANDAU.MACLB2 = CLB2.MACLB
 WHERE VONG = 3 AND NAM = 2009
GO
/****** Object:  Table [dbo].[BANGXH]    Script Date: 3/14/2023 10:06:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BANGXH](
	[MACLB] [varchar](5) NOT NULL,
	[NAM] [int] NOT NULL,
	[VONG] [int] NOT NULL,
	[SOTRAN] [int] NOT NULL,
	[THANG] [int] NOT NULL,
	[HOA] [int] NOT NULL,
	[THUA] [int] NOT NULL,
	[HIEUSO] [varchar](5) NOT NULL,
	[DIEM] [int] NOT NULL,
	[HANG] [int] NOT NULL,
 CONSTRAINT [pk_bangxh] PRIMARY KEY CLUSTERED 
(
	[MACLB] ASC,
	[NAM] ASC,
	[VONG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HLV_CLB]    Script Date: 3/14/2023 10:06:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HLV_CLB](
	[MAHLV] [varchar](5) NOT NULL,
	[MACLB] [varchar](5) NOT NULL,
	[VAITRO] [nvarchar](100) NULL,
 CONSTRAINT [pk_hlvclb] PRIMARY KEY CLUSTERED 
(
	[MAHLV] ASC,
	[MACLB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HUANLUYENVIEN]    Script Date: 3/14/2023 10:06:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HUANLUYENVIEN](
	[MAHLV] [varchar](5) NOT NULL,
	[TENHLV] [nvarchar](100) NOT NULL,
	[NGAYSINH] [datetime] NULL,
	[DIACHI] [nvarchar](100) NULL,
	[DIENTHOAI] [nvarchar](20) NULL,
	[MAQG] [varchar](5) NOT NULL,
 CONSTRAINT [pk_hlv] PRIMARY KEY CLUSTERED 
(
	[MAHLV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THAMGIA]    Script Date: 3/14/2023 10:06:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THAMGIA](
	[MATD] [numeric](18, 0) NOT NULL,
	[MACT] [numeric](18, 0) NOT NULL,
	[SOTRAI] [int] NULL,
 CONSTRAINT [pk_thamgia] PRIMARY KEY CLUSTERED 
(
	[MATD] ASC,
	[MACT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TINH]    Script Date: 3/14/2023 10:06:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TINH](
	[MATINH] [varchar](5) NOT NULL,
	[TENTINH] [nvarchar](100) NOT NULL,
 CONSTRAINT [pk_tinh] PRIMARY KEY CLUSTERED 
(
	[MATINH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'BBD', 2009, 1, 1, 1, 0, 0, N'3-0', 3, 1)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'BBD', 2009, 2, 2, 1, 0, 1, N'3-5', 3, 2)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'BBD', 2009, 3, 3, 2, 0, 1, N'4-5', 6, 1)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'BBD', 2009, 4, 4, 2, 1, 1, N'6-7', 7, 1)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'GDT', 2009, 1, 1, 0, 1, 0, N'1-1', 1, 3)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'GDT', 2009, 2, 1, 0, 1, 0, N'1-1', 1, 4)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'GDT', 2009, 3, 2, 1, 1, 0, N'3-1', 4, 2)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'GDT', 2009, 4, 3, 1, 2, 0, N'5-1', 5, 2)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'KKH', 2009, 1, 1, 0, 1, 0, N'1-1', 1, 2)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'KKH', 2009, 2, 2, 0, 2, 0, N'3-3', 2, 3)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'KKH', 2009, 3, 3, 0, 2, 1, N'3-4', 2, 4)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'KKH', 2009, 4, 4, 1, 2, 1, N'4-4', 5, 3)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'SDN', 2009, 1, 1, 0, 0, 1, N'0-3', 0, 5)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'SDN', 2009, 2, 2, 1, 1, 0, N'2-5', 1, 5)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'SDN', 2009, 3, 2, 1, 1, 0, N'2-5', 1, 5)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'SDN', 2009, 4, 2, 1, 1, 0, N'2-5', 1, 5)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'TPY', 2009, 1, 0, 0, 0, 0, N'0-0', 0, 3)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'TPY', 2009, 2, 1, 1, 0, 0, N'5-0', 3, 1)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'TPY', 2009, 3, 2, 1, 0, 1, N'5-2', 3, 3)
INSERT [dbo].[BANGXH] ([MACLB], [NAM], [VONG], [SOTRAN], [THANG], [HOA], [THUA], [HIEUSO], [DIEM], [HANG]) VALUES (N'TPY', 2009, 4, 3, 1, 0, 2, N'5-3', 3, 4)
GO
INSERT [dbo].[CAULACBO] ([MACLB], [TENCLB], [MASAN], [MATINH]) VALUES (N'BBD', N'BECAMEX BÌNH DƯƠNG', N'GD', N'BD')
INSERT [dbo].[CAULACBO] ([MACLB], [TENCLB], [MASAN], [MATINH]) VALUES (N'CSDT', N'TẬP ĐOÀN CAO SU ĐỒNG THÁP', N'CLDT', N'DT')
INSERT [dbo].[CAULACBO] ([MACLB], [TENCLB], [MASAN], [MATINH]) VALUES (N'FFF', N'FFF', N'TH', N'PY')
INSERT [dbo].[CAULACBO] ([MACLB], [TENCLB], [MASAN], [MATINH]) VALUES (N'GDT', N'GẠCH ĐỒNG TÂM LONG AN', N'LA', N'LA')
INSERT [dbo].[CAULACBO] ([MACLB], [TENCLB], [MASAN], [MATINH]) VALUES (N'HAGL', N'HOÀNG ANH GIA LAI', N'LA', N'GL')
INSERT [dbo].[CAULACBO] ([MACLB], [TENCLB], [MASAN], [MATINH]) VALUES (N'KKH', N'KHATOCO KHÁNH HÒA', N'NT', N'KH')
INSERT [dbo].[CAULACBO] ([MACLB], [TENCLB], [MASAN], [MATINH]) VALUES (N'N', N'SSCS', N'LA', N'PY')
INSERT [dbo].[CAULACBO] ([MACLB], [TENCLB], [MASAN], [MATINH]) VALUES (N'RR', N'RR', N'LA', N'PY')
INSERT [dbo].[CAULACBO] ([MACLB], [TENCLB], [MASAN], [MATINH]) VALUES (N'SDN', N'SHB ĐÀ NẴNG', N'CL', N'DN')
INSERT [dbo].[CAULACBO] ([MACLB], [TENCLB], [MASAN], [MATINH]) VALUES (N'TPY', N'THÉP PHÚ YÊN', N'LA', N'PY')
INSERT [dbo].[CAULACBO] ([MACLB], [TENCLB], [MASAN], [MATINH]) VALUES (N'UU', N'RR', N'LA', N'PY')
GO
SET IDENTITY_INSERT [dbo].[CAUTHU] ON 

INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(1 AS Numeric(18, 0)), N'Nguyễn Vũ Phong', N'Tiền Vệ', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'BBD', N'VN', 17)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(2 AS Numeric(18, 0)), N'Nguyễn Công Vinh', N'Tiền Đạo', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'HAGL', N'VN', 9)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(3 AS Numeric(18, 0)), N'Nguyễn Hồng Sơn', N'Tiền Vệ', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'SDN', N'VN', 9)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(4 AS Numeric(18, 0)), N'Lê Tấn Tài', N'Tiền Vệ', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'KKH', N'VN', 14)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(5 AS Numeric(18, 0)), N'Phạm Hồng Sơn', N'Thủ Môn', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'HAGL', N'VN', 1)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(6 AS Numeric(18, 0)), N'Ronaldo', N'Tiền Vệ', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'SDN', N'BRA', 7)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(7 AS Numeric(18, 0)), N'Robinho', N'Tiền Vệ', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'SDN', N'BRA', 8)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(8 AS Numeric(18, 0)), N'Vidic', N'Tiền Vệ', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'HAGL', N'ANH', 3)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(9 AS Numeric(18, 0)), N'Trần Văn Santos', N'Thủ Môn', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'BBD', N'BRA', 1)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(10 AS Numeric(18, 0)), N'Nguyễn Trường Sơn', N'Hậu Vệ', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'BBD', N'VN', 4)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(11 AS Numeric(18, 0)), N'Lê Huỳnh Đức', N'Tiền Đạo', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'BBD', N'VN', 10)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(12 AS Numeric(18, 0)), N'Huỳnh Hồng Sơn', N'Tiền Vệ', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'BBD', N'VN', 9)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(13 AS Numeric(18, 0)), N'Lee Nguyễn', N'Tiền Đạo', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'BBD', N'VN', 14)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(14 AS Numeric(18, 0)), N'Bùi Tấn Trường', N'Thủ Môn', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'CSDT', N'VN', 1)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(15 AS Numeric(18, 0)), N'Phan Văn Tài Em', N'Tiền Vệ', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'GDT', N'VN', 10)
INSERT [dbo].[CAUTHU] ([MACT], [HOTEN], [VITRI], [NGAYSINH], [DIACHI], [MACLB], [MAQG], [SO]) VALUES (CAST(16 AS Numeric(18, 0)), N'Lý Tiểu Long', N'Tiền Vệ', CAST(N'2016-10-23T00:00:00.000' AS DateTime), NULL, N'TPY', N'VN', 7)
SET IDENTITY_INSERT [dbo].[CAUTHU] OFF
GO
INSERT [dbo].[HLV_CLB] ([MAHLV], [MACLB], [VAITRO]) VALUES (N'HLV01', N'GDT', N'HLV Chính')
INSERT [dbo].[HLV_CLB] ([MAHLV], [MACLB], [VAITRO]) VALUES (N'HLV02', N'SDN', N'HLV Chính')
INSERT [dbo].[HLV_CLB] ([MAHLV], [MACLB], [VAITRO]) VALUES (N'HLV03', N'HAGL', N'HLV Chính')
INSERT [dbo].[HLV_CLB] ([MAHLV], [MACLB], [VAITRO]) VALUES (N'HLV04', N'KKH', N'HLV Chính')
INSERT [dbo].[HLV_CLB] ([MAHLV], [MACLB], [VAITRO]) VALUES (N'HLV05', N'TPY', N'HLV Chính')
INSERT [dbo].[HLV_CLB] ([MAHLV], [MACLB], [VAITRO]) VALUES (N'HLV06', N'CSDT', N'HLV Chính')
INSERT [dbo].[HLV_CLB] ([MAHLV], [MACLB], [VAITRO]) VALUES (N'HLV07', N'BBD', N'HLV Chính')
INSERT [dbo].[HLV_CLB] ([MAHLV], [MACLB], [VAITRO]) VALUES (N'HLV08', N'BBD', N'HLV Thủ Môn')
GO
INSERT [dbo].[HUANLUYENVIEN] ([MAHLV], [TENHLV], [NGAYSINH], [DIACHI], [DIENTHOAI], [MAQG]) VALUES (N'HLV01', N'Vital', CAST(N'1955-10-15T00:00:00.000' AS DateTime), NULL, N'0918011075', N'BDN')
INSERT [dbo].[HUANLUYENVIEN] ([MAHLV], [TENHLV], [NGAYSINH], [DIACHI], [DIENTHOAI], [MAQG]) VALUES (N'HLV02', N'Lê Huỳnh Đức', CAST(N'1972-05-20T00:00:00.000' AS DateTime), NULL, N'01223456789', N'VN')
INSERT [dbo].[HUANLUYENVIEN] ([MAHLV], [TENHLV], [NGAYSINH], [DIACHI], [DIENTHOAI], [MAQG]) VALUES (N'HLV03', N'Kiatisuk', CAST(N'1970-12-11T00:00:00.000' AS DateTime), NULL, N'0199123456', N'THA')
INSERT [dbo].[HUANLUYENVIEN] ([MAHLV], [TENHLV], [NGAYSINH], [DIACHI], [DIENTHOAI], [MAQG]) VALUES (N'HLV04', N'Hoàng Anh Tuấn', CAST(N'1970-06-10T00:00:00.000' AS DateTime), NULL, N'0989112233', N'VN')
INSERT [dbo].[HUANLUYENVIEN] ([MAHLV], [TENHLV], [NGAYSINH], [DIACHI], [DIENTHOAI], [MAQG]) VALUES (N'HLV05', N'Trần Công Minh', CAST(N'1973-07-07T00:00:00.000' AS DateTime), NULL, N'0909099990', N'VN')
INSERT [dbo].[HUANLUYENVIEN] ([MAHLV], [TENHLV], [NGAYSINH], [DIACHI], [DIENTHOAI], [MAQG]) VALUES (N'HLV06', N'Trần Văn Phúc', CAST(N'1965-03-02T00:00:00.000' AS DateTime), NULL, N'01650101234', N'VN')
INSERT [dbo].[HUANLUYENVIEN] ([MAHLV], [TENHLV], [NGAYSINH], [DIACHI], [DIENTHOAI], [MAQG]) VALUES (N'HLV07', N'Yoon-Hwan-Cho', CAST(N'1960-02-02T00:00:00.000' AS DateTime), NULL, NULL, N'HQ')
INSERT [dbo].[HUANLUYENVIEN] ([MAHLV], [TENHLV], [NGAYSINH], [DIACHI], [DIENTHOAI], [MAQG]) VALUES (N'HLV08', N'Yun-Kyum-Choi', CAST(N'1962-03-03T00:00:00.000' AS DateTime), NULL, NULL, N'HQ')
GO
INSERT [dbo].[QUOCGIA] ([MAQG], [TENQG]) VALUES (N'ANH', N'Anh Quốc')
INSERT [dbo].[QUOCGIA] ([MAQG], [TENQG]) VALUES (N'BDN', N'Bồ Đào Nha')
INSERT [dbo].[QUOCGIA] ([MAQG], [TENQG]) VALUES (N'BRA', N'Brazil')
INSERT [dbo].[QUOCGIA] ([MAQG], [TENQG]) VALUES (N'HQ', N'Hàn Quốc')
INSERT [dbo].[QUOCGIA] ([MAQG], [TENQG]) VALUES (N'ITA', N'Ý')
INSERT [dbo].[QUOCGIA] ([MAQG], [TENQG]) VALUES (N'TBN', N'Tây Ban Nha')
INSERT [dbo].[QUOCGIA] ([MAQG], [TENQG]) VALUES (N'THA', N'Thái Lan')
INSERT [dbo].[QUOCGIA] ([MAQG], [TENQG]) VALUES (N'THAI', N'Thái Lan')
INSERT [dbo].[QUOCGIA] ([MAQG], [TENQG]) VALUES (N'VN', N'Việt Nam')
GO
INSERT [dbo].[SANVD] ([MASAN], [TENSAN], [DIACHI]) VALUES (N'CL', N'Chi Lăng', N'127 Võ Văn Tần, Đà Nẵng')
INSERT [dbo].[SANVD] ([MASAN], [TENSAN], [DIACHI]) VALUES (N'CLDT', N'Cao Lãnh', N'134 TX Cao Lãnh, Đồng Tháp')
INSERT [dbo].[SANVD] ([MASAN], [TENSAN], [DIACHI]) VALUES (N'GD', N'Gò Đậu', N'123 QL1, TX Thủ Dầu Một, Bình Dương')
INSERT [dbo].[SANVD] ([MASAN], [TENSAN], [DIACHI]) VALUES (N'HD', N'Hàng Đẫy', N'345 Lý Chiêu Hoàng, Bạch Mai, Hà Nội')
INSERT [dbo].[SANVD] ([MASAN], [TENSAN], [DIACHI]) VALUES (N'LA', N'Long An', N'102 Hùng Vương, Tp Tân An, Long An')
INSERT [dbo].[SANVD] ([MASAN], [TENSAN], [DIACHI]) VALUES (N'NT', N'Nha Trang', N'128 Phan Chu Trinh, Nha Trang, Khánh Hòa')
INSERT [dbo].[SANVD] ([MASAN], [TENSAN], [DIACHI]) VALUES (N'PL', N'Pleiku', N'22 Hồ Tùng Mậu, Thống Nhất, Thị xã Pleiku, Gia Lai')
INSERT [dbo].[SANVD] ([MASAN], [TENSAN], [DIACHI]) VALUES (N'TH', N'Tuy Hòa', N'57 Trường Chinh, Tuy Hòa, Phú Yên')
INSERT [dbo].[SANVD] ([MASAN], [TENSAN], [DIACHI]) VALUES (N'TN', N'Thống Nhất', N'123 Lý Thường Kiệt, Quận 5, TpHCM')
GO
INSERT [dbo].[THAMGIA] ([MATD], [MACT], [SOTRAI]) VALUES (CAST(1 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), 2)
INSERT [dbo].[THAMGIA] ([MATD], [MACT], [SOTRAI]) VALUES (CAST(1 AS Numeric(18, 0)), CAST(11 AS Numeric(18, 0)), 1)
INSERT [dbo].[THAMGIA] ([MATD], [MACT], [SOTRAI]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), 1)
INSERT [dbo].[THAMGIA] ([MATD], [MACT], [SOTRAI]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(16 AS Numeric(18, 0)), 1)
INSERT [dbo].[THAMGIA] ([MATD], [MACT], [SOTRAI]) VALUES (CAST(3 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), 1)
INSERT [dbo].[THAMGIA] ([MATD], [MACT], [SOTRAI]) VALUES (CAST(3 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), 2)
INSERT [dbo].[THAMGIA] ([MATD], [MACT], [SOTRAI]) VALUES (CAST(3 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), 1)
INSERT [dbo].[THAMGIA] ([MATD], [MACT], [SOTRAI]) VALUES (CAST(4 AS Numeric(18, 0)), CAST(15 AS Numeric(18, 0)), 5)
INSERT [dbo].[THAMGIA] ([MATD], [MACT], [SOTRAI]) VALUES (CAST(5 AS Numeric(18, 0)), CAST(16 AS Numeric(18, 0)), 2)
INSERT [dbo].[THAMGIA] ([MATD], [MACT], [SOTRAI]) VALUES (CAST(6 AS Numeric(18, 0)), CAST(13 AS Numeric(18, 0)), 1)
INSERT [dbo].[THAMGIA] ([MATD], [MACT], [SOTRAI]) VALUES (CAST(7 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), 1)
INSERT [dbo].[THAMGIA] ([MATD], [MACT], [SOTRAI]) VALUES (CAST(8 AS Numeric(18, 0)), CAST(12 AS Numeric(18, 0)), 2)
INSERT [dbo].[THAMGIA] ([MATD], [MACT], [SOTRAI]) VALUES (CAST(8 AS Numeric(18, 0)), CAST(16 AS Numeric(18, 0)), 2)
GO
INSERT [dbo].[TINH] ([MATINH], [TENTINH]) VALUES (N'BD', N'Bình Dương')
INSERT [dbo].[TINH] ([MATINH], [TENTINH]) VALUES (N'DN', N'Đà Nẵng')
INSERT [dbo].[TINH] ([MATINH], [TENTINH]) VALUES (N'DT', N'Đồng Tháp')
INSERT [dbo].[TINH] ([MATINH], [TENTINH]) VALUES (N'GL', N'Gia Lai')
INSERT [dbo].[TINH] ([MATINH], [TENTINH]) VALUES (N'HN', N'Hà Nội')
INSERT [dbo].[TINH] ([MATINH], [TENTINH]) VALUES (N'HP', N'Hải Phòng')
INSERT [dbo].[TINH] ([MATINH], [TENTINH]) VALUES (N'KH', N'Khánh Hòa')
INSERT [dbo].[TINH] ([MATINH], [TENTINH]) VALUES (N'LA', N'Long An')
INSERT [dbo].[TINH] ([MATINH], [TENTINH]) VALUES (N'NA', N'Nghệ An')
INSERT [dbo].[TINH] ([MATINH], [TENTINH]) VALUES (N'NB', N'Ninh Bình')
INSERT [dbo].[TINH] ([MATINH], [TENTINH]) VALUES (N'PY', N'Phú Yên')
INSERT [dbo].[TINH] ([MATINH], [TENTINH]) VALUES (N'SG', N'Sài Gòn')
INSERT [dbo].[TINH] ([MATINH], [TENTINH]) VALUES (N'TH', N'Thanh Hóa')
GO
SET IDENTITY_INSERT [dbo].[TRANDAU] ON 

INSERT [dbo].[TRANDAU] ([MATRAN], [NAM], [VONG], [NGAYTD], [MACLB1], [MACLB2], [MASAN], [KETQUA]) VALUES (CAST(1 AS Numeric(18, 0)), 2009, 1, CAST(N'2009-02-07T00:00:00.000' AS DateTime), N'BBD', N'SDN', N'GD', N'3-0')
INSERT [dbo].[TRANDAU] ([MATRAN], [NAM], [VONG], [NGAYTD], [MACLB1], [MACLB2], [MASAN], [KETQUA]) VALUES (CAST(2 AS Numeric(18, 0)), 2009, 1, CAST(N'2009-02-07T00:00:00.000' AS DateTime), N'KKH', N'GDT', N'NT', N'1-1')
INSERT [dbo].[TRANDAU] ([MATRAN], [NAM], [VONG], [NGAYTD], [MACLB1], [MACLB2], [MASAN], [KETQUA]) VALUES (CAST(3 AS Numeric(18, 0)), 2009, 2, CAST(N'2009-02-16T00:00:00.000' AS DateTime), N'SDN', N'KKH', N'CL', N'2-2')
INSERT [dbo].[TRANDAU] ([MATRAN], [NAM], [VONG], [NGAYTD], [MACLB1], [MACLB2], [MASAN], [KETQUA]) VALUES (CAST(4 AS Numeric(18, 0)), 2009, 2, CAST(N'2009-02-16T00:00:00.000' AS DateTime), N'TPY', N'BBD', N'TH', N'5-0')
INSERT [dbo].[TRANDAU] ([MATRAN], [NAM], [VONG], [NGAYTD], [MACLB1], [MACLB2], [MASAN], [KETQUA]) VALUES (CAST(5 AS Numeric(18, 0)), 2009, 3, CAST(N'2009-03-01T00:00:00.000' AS DateTime), N'TPY', N'GDT', N'TH', N'0-2')
INSERT [dbo].[TRANDAU] ([MATRAN], [NAM], [VONG], [NGAYTD], [MACLB1], [MACLB2], [MASAN], [KETQUA]) VALUES (CAST(6 AS Numeric(18, 0)), 2009, 3, CAST(N'2009-03-01T00:00:00.000' AS DateTime), N'KKH', N'BBD', N'NT', N'0-1')
INSERT [dbo].[TRANDAU] ([MATRAN], [NAM], [VONG], [NGAYTD], [MACLB1], [MACLB2], [MASAN], [KETQUA]) VALUES (CAST(7 AS Numeric(18, 0)), 2009, 4, CAST(N'2009-03-07T00:00:00.000' AS DateTime), N'KKH', N'TPY', N'NT', N'1-0')
INSERT [dbo].[TRANDAU] ([MATRAN], [NAM], [VONG], [NGAYTD], [MACLB1], [MACLB2], [MASAN], [KETQUA]) VALUES (CAST(8 AS Numeric(18, 0)), 2009, 4, CAST(N'2009-03-07T00:00:00.000' AS DateTime), N'BBD', N'GDT', N'GD', N'2-2')
SET IDENTITY_INSERT [dbo].[TRANDAU] OFF
GO
ALTER TABLE [dbo].[BANGXH]  WITH CHECK ADD  CONSTRAINT [fk_bangxh] FOREIGN KEY([MACLB])
REFERENCES [dbo].[CAULACBO] ([MACLB])
GO
ALTER TABLE [dbo].[BANGXH] CHECK CONSTRAINT [fk_bangxh]
GO
ALTER TABLE [dbo].[CAULACBO]  WITH CHECK ADD  CONSTRAINT [fk_caulacbo_sanvd] FOREIGN KEY([MASAN])
REFERENCES [dbo].[SANVD] ([MASAN])
GO
ALTER TABLE [dbo].[CAULACBO] CHECK CONSTRAINT [fk_caulacbo_sanvd]
GO
ALTER TABLE [dbo].[CAULACBO]  WITH CHECK ADD  CONSTRAINT [fk_caulacbo_tinh] FOREIGN KEY([MATINH])
REFERENCES [dbo].[TINH] ([MATINH])
GO
ALTER TABLE [dbo].[CAULACBO] CHECK CONSTRAINT [fk_caulacbo_tinh]
GO
ALTER TABLE [dbo].[CAUTHU]  WITH CHECK ADD  CONSTRAINT [fk_cauthu_hlv] FOREIGN KEY([MACLB])
REFERENCES [dbo].[CAULACBO] ([MACLB])
GO
ALTER TABLE [dbo].[CAUTHU] CHECK CONSTRAINT [fk_cauthu_hlv]
GO
ALTER TABLE [dbo].[CAUTHU]  WITH CHECK ADD  CONSTRAINT [fk_cauthu_quocgia] FOREIGN KEY([MAQG])
REFERENCES [dbo].[QUOCGIA] ([MAQG])
GO
ALTER TABLE [dbo].[CAUTHU] CHECK CONSTRAINT [fk_cauthu_quocgia]
GO
ALTER TABLE [dbo].[HLV_CLB]  WITH CHECK ADD  CONSTRAINT [fk_hlvclb_clb] FOREIGN KEY([MACLB])
REFERENCES [dbo].[CAULACBO] ([MACLB])
GO
ALTER TABLE [dbo].[HLV_CLB] CHECK CONSTRAINT [fk_hlvclb_clb]
GO
ALTER TABLE [dbo].[HLV_CLB]  WITH CHECK ADD  CONSTRAINT [fk_hlvclb_hlv] FOREIGN KEY([MAHLV])
REFERENCES [dbo].[HUANLUYENVIEN] ([MAHLV])
GO
ALTER TABLE [dbo].[HLV_CLB] CHECK CONSTRAINT [fk_hlvclb_hlv]
GO
ALTER TABLE [dbo].[HUANLUYENVIEN]  WITH CHECK ADD  CONSTRAINT [fk_hlv] FOREIGN KEY([MAQG])
REFERENCES [dbo].[QUOCGIA] ([MAQG])
GO
ALTER TABLE [dbo].[HUANLUYENVIEN] CHECK CONSTRAINT [fk_hlv]
GO
ALTER TABLE [dbo].[THAMGIA]  WITH CHECK ADD  CONSTRAINT [fk_thamgia_cauthu] FOREIGN KEY([MACT])
REFERENCES [dbo].[CAUTHU] ([MACT])
GO
ALTER TABLE [dbo].[THAMGIA] CHECK CONSTRAINT [fk_thamgia_cauthu]
GO
ALTER TABLE [dbo].[THAMGIA]  WITH CHECK ADD  CONSTRAINT [fk_thamgia_tran] FOREIGN KEY([MATD])
REFERENCES [dbo].[TRANDAU] ([MATRAN])
GO
ALTER TABLE [dbo].[THAMGIA] CHECK CONSTRAINT [fk_thamgia_tran]
GO
ALTER TABLE [dbo].[TRANDAU]  WITH CHECK ADD  CONSTRAINT [fk_clb1] FOREIGN KEY([MACLB1])
REFERENCES [dbo].[CAULACBO] ([MACLB])
GO
ALTER TABLE [dbo].[TRANDAU] CHECK CONSTRAINT [fk_clb1]
GO
ALTER TABLE [dbo].[TRANDAU]  WITH CHECK ADD  CONSTRAINT [fk_clb2] FOREIGN KEY([MACLB2])
REFERENCES [dbo].[CAULACBO] ([MACLB])
GO
ALTER TABLE [dbo].[TRANDAU] CHECK CONSTRAINT [fk_clb2]
GO
ALTER TABLE [dbo].[TRANDAU]  WITH CHECK ADD  CONSTRAINT [fk_clb3] FOREIGN KEY([MASAN])
REFERENCES [dbo].[SANVD] ([MASAN])
GO
ALTER TABLE [dbo].[TRANDAU] CHECK CONSTRAINT [fk_clb3]
GO
