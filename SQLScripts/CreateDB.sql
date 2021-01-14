CREATE DATABASE LegoInventoryTracker
ON
PRIMARY
(
	NAME=LegoInventoryTrackerData,
	FILENAME='D:\Database\MSSQL15.MSSQLSERVER\MSSQL\DATA\LegoInventoryTrackerData.mdf',
	SIZE=6MB,
	MAXSIZE=50MB,
	FILEGROWTH=15%
)
LOG ON
(
	NAME=LegoInventoryTrackerLog,
	FILENAME='D:\Database\MSSQL15.MSSQLSERVER\MSSQL\DATA\LegoInventoryTrackerLog.ldf',
	SIZE=3MB,
	MAXSIZE=10MB,
	FILEGROWTH=10%
)
GO

use LegoInventoryTracker
GO

CREATE USER morrisjj FROM LOGIN morrisjj;
exec sp_addrolemember 'db_owner', 'morrisjj';
GO

CREATE USER cramerj1 FROM LOGIN cramerj1;
exec sp_addrolemember 'db_owner', 'cramerj1';
GO

CREATE USER ferderl1 FROM LOGIN ferderl1;
exec sp_addrolemember 'db_owner', 'ferderl1';
GO