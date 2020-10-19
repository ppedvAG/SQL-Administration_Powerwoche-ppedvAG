USE [master]
GO
CREATE LOGIN [EVI] WITH PASSWORD=N'123',
 DEFAULT_DATABASE=[testdb], 
 CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
CREATE LOGIN [MAX] WITH PASSWORD=N'123',
 DEFAULT_DATABASE=[testdb], 
 CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO


USE [testdb]
GO
CREATE USER [MAX] FOR LOGIN [MAX]
GO

USE [testdb]
GO
CREATE USER [EVI] FOR LOGIN [EVI]
GO

USE [testdb]
GO

CREATE SCHEMA [MA]
GO


CREATE SCHEMA [IT]
GO

use testdb;

create table IT.personal (itpersonal int)
create table IT.mitarbeiter (itmitarbeiter int)

create table MA.personal (itpersonal int)
create table MA.mitarbeiter (itmitarbeiter int)


select * from personal --dbo.personal
--default schema ist dbo, kann aber pro User definiert werden

create table dbo.gehalt (id int)


create view it.vgehalt
as
select * from dbo.gehalt

use master

use testdb

exec sp_setapprole 'Gehaltsrolle', 'ppedv2016!'
