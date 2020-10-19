--Emailsystem 

/*
SQL ist eine SMTP Client

Profil beihaltet ein SMTP Konto

IP oder name des rechner des SMPT Server: hv-sql2
Port: 25
Absendeemail: SQLService@sql.local
(bei Exchange evtl Konto des Agents...)


DOKU SQL 2008: 100.000
         2017   150.000

*/

--msdb ist kaputt
--muss die msdb im SingleUserModus sein
USE [master]
GO
ALTER DATABASE [msdb] SET  SINGLE_USER WITH NO_WAIT --nur eine einzige Verbindung
--Agent stoppen
GO

--jetzt restoren..am besten oer TSQL
USE [master]
RESTORE DATABASE [msdb] FROM  DISK = N'C:\_Backup\msdb\msdb_backup_2018_05_08_082759_1421616.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 5

GO

ALTER DATABASE [msdb] SET  MULTI_USER WITH NO_WAIT 

GO



--MASTER??
--der Server muss im Single_User Modus sein
-- Startparameter -m

--!! Tipp: Netzwerkkabel ziehen, Dienste stoppen (Agent, Reporting, Analysis, Integration..etc)

restore database.. .master


--danach Startparameter wieder rausnehmen


--bei defekten Dateien (master, msdb): Server fährt nicht mehr hoch
--dann auch kein Restore möglich

--Kopie der Templates verwenden
--C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Binn\Templates
--aserver starten.. alles leer, aber...
--dananach geht auch der Restore wieder


select * from sysusers









