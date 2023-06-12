/*---------------------------------------------------------- 
MASV: 46.01.104.005
HO TEN: Phạm Nguyệt Anh
LAB: 05 
NGAY: 21/04/2023
----------------------------------------------------------*/ 
--attach-----------------
USE [master]
GO
CREATE DATABASE [QLBongDa2] ON 
( FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\QLBongDa2.mdf' ),
( FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\QLBongDa2_log.ldf' )
 FOR ATTACH
GO
-----end attach--------------
-------ma hoa TDE -------------
use master
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = '123';
GO

CREATE CERTIFICATE QLBDCertificate WITH SUBJECT = 'QLBD Certificate';
GO

use QLBongDa2
go

CREATE DATABASE ENCRYPTION KEY
   WITH ALGORITHM = AES_256
   ENCRYPTION BY SERVER CERTIFICATE QLBDCertificate;
   go
   /*select db_name(database_id) 'Database', encryption_state FROM  sys.dm_database_encryption_keys;
   go*/

use master
go

ALTER DATABASE QLBongDa2
SET ENCRYPTION ON;
GO
------------------------end------------------
------------Detach và Attach đã mã hóa TDE --------------
--server 1
use master
GO

backup CERTIFICATE QLBDCertificate to file = 'C:\temp\QLBDCertificate'
with private key 
(file = 'C:\temp\QLBDCertificate.pvk',
encryption by password = '123');
go
--server 2
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '123';
GO

CREATE CERTIFICATE QLBDCertificate FROM FILE = 'C:\temp\QLBDCertificate'
WITH PRIVATE KEY (
	FILE = 'C:\temp\QLBDCertificate.pvk',
	DECRYPTION BY PASSWORD = '123'
)
----Backup và Restore đã mã hóa TDE --------------------
--server 1
use master
GO

backup CERTIFICATE QLBDCertificate to file = 'C:\temp\QLBDCertificate'
with private key 
(file = 'C:\temp\QLBDCertificate.pvk',
encryption by password = '123');
go
--server 2
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '123';
GO

CREATE CERTIFICATE QLBDCertificate FROM FILE = 'C:\temp\QLBDCertificate'
WITH PRIVATE KEY (
	FILE = 'C:\temp\QLBDCertificate.pvk',
	DECRYPTION BY PASSWORD = '123'
)