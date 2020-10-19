--BACKUP

/*
Vollständig
Sichert "Dateien" --inklusiv Pfad
sichert nur Daten (keine Leerräume in den Dateien)
es wird ein Zeitpunkt gesichert
jede andere Sicherung braucht das V vorab


----TX-- TX-||--TX----



Diffentiell
sichert geänderte Blöcke seit dem V
sichert Zeitpunkt
zum Restore v und letzte D


Transaktionsprotokoll
das T sichert Anweisungen

*/


V TTT D TTT D TTT D TTT

--letzter Backup restoren
V                 D TTT

--was, wenn kein D
V TTT TTT TTT TTT

--wie lange dauert der Restore eines T in Sekunden
--braucht zum Restore genauso lange wie die Anweisungen selber dauerten
--demnach sollten nicht viele Ts aufeinenader folgen

V TTT xTT TTT TTT
--was können wir restoren?
V TTT .. that s it

--daher werden wir alleine schon deswegen
-- Ds  einstreuen



--wenige Fragen regeln das Backup:
1. Frage: max. Datenverlust in Zeit ==> T
2. Frage: Ausfallzeit der DB

--Ds verkürzen den Restoren und machen den restore auch sicherer


--der schnellste restore ist: nur ein V
--je mehr Sichernungen nach V kamen , desto länger dauert es
--> RecoveryModel: 
nur bei FULL kann auf Sekunden ein Restore gemacht werden

bei BULKINSERT kann auch auf Sekunden restoren, aber nur wenn kein BULK stattgefunden hat

bei SIMPLE gibt es kein T-Log Backup


--Produktivserver haben meist FULL


--DATEN




create table kunden
	(id int identity, spx char(4100), spy int, Datum datetime)

insert into Kunden
select 'xy',1, GETDATE()
GO 500


select top 10 * from Kunden order by Datum desc

update Kunden set spx = 'zzz' where id > 5000
--UNFÄLLE
/*
1: versehentliches Löschen von Daten (DB ist ok, nur die Daten nicht)
--unter anderen Namen wiederherstellen
--Zeit evtl ungenau des fehler


2: DB defekt (tats. Resore)
damit kein Datenverlust entsteht müsste vorher 
ein LOG Backup gemacht werden
(Backups sind online)
Die DB darf aber nicht verwendet werden




3: ich weiss, dass was passieren könnte

4: ganzer server weg


*/




--VOLL
BACKUP DATABASE [testdb] TO  DISK = N'C:\_ODINBACKUP\testdb.bak'
	 WITH NOFORMAT, NOINIT,  
	 NAME = N'testdb-Voll', 
	 SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--DIFF
BACKUP DATABASE [testdb] TO  DISK = N'C:\_ODINBACKUP\testdb.bak' 
	WITH  DIFFERENTIAL , 
	NOFORMAT, NOINIT,  NAME = N'testdb-DIFF', 
	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--TLOG
BACKUP LOG [testdb] TO  DISK = N'C:\_ODINBACKUP\testdb.bak' 
	WITH NOFORMAT, NOINIT,  
	NAME = N'testdb-LOG', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--immer wieder 500 datensätze einegfügt
--V TTT D TTT D TTT D TTT














--auf zeitpunkt
USE [master]
RESTORE DATABASE [testdb2] FROM  
	DISK = N'C:\_ODINBACKUP\testdb.bak'
		  WITH  FILE = 2,  MOVE N'testdb' TO N'C:\_ODINDBS\testdb2.mdf', 
		  MOVE N'testdb_log' TO N'C:\_ODINDBS\testdb2_log.ldf',  
		  NORECOVERY,  NOUNLOAD,  STATS = 5

RESTORE DATABASE [testdb2] FROM  DISK = N'C:\_ODINBACKUP\testdb.bak' 
	WITH  FILE = 6,  NORECOVERY,  NOUNLOAD,  STATS = 5

RESTORE LOG [testdb2] FROM  DISK = N'C:\_ODINBACKUP\testdb.bak' 
	WITH  FILE = 7,  NOUNLOAD,  STATS = 5, 
	 STOPAT = N'2017-11-14T09:59:37'

GO


select top 10 * from testdb2.dbo.kunden order by datum desc

--es fehlen deutlich mehr datensätze : 2000
--neuer Restore

--so könnte ein Update aussehen
update testdb.dbo.Kunden set spx = t2.spx
from testdb.dbo.kunden t1
inner join testdb2.dbo.kunden2 t2 on 
t1.id = t2.id
where t1.id > 5000

--Restore der OrgDB
--mit Fragemntsicherung
--kein Datenverlust


USE [master]
ALTER DATABASE [testdb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
BACKUP LOG [testdb] TO  DISK = N'C:\_ODINBACKUP\testdb_LogBackup_2017-11-14_10-20-29.bak' WITH NOFORMAT, NOINIT,  NAME = N'testdb_LogBackup_2017-11-14_10-20-29', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [testdb] FROM  DISK = N'C:\_ODINBACKUP\testdb.bak' WITH  FILE = 2,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE DATABASE [testdb] FROM  DISK = N'C:\_ODINBACKUP\testdb.bak' WITH  FILE = 14,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [testdb] FROM  DISK = N'C:\_ODINBACKUP\testdb.bak' WITH  FILE = 15,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [testdb] FROM  DISK = N'C:\_ODINBACKUP\testdb.bak' WITH  FILE = 16,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [testdb] FROM  DISK = N'C:\_ODINBACKUP\testdb.bak' WITH  FILE = 17,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [testdb] FROM  DISK = N'C:\_ODINBACKUP\testdb.bak' WITH  FILE = 18,  NOUNLOAD,  STATS = 5
ALTER DATABASE [testdb] SET MULTI_USER

GO

--Perfekt!!








--Was wenn ich weiss, dass was passieren kann??

--SNAPSHOT

/*
DB 10 GB

Snapshotsicherung-->lesende DB (fixer Inhalt; zum zeitpunkt der Sicherung (Snapshot)
C:\ frei (5GB)..geht!
C:\ frei (5MB)..geht!
C:\ frei (500KB)..geht!.. aber nicht lang


*/
--Enterprise! ab 2016 Sp1 auch ab Express
--Snapshot kopiert Blöcke vor Änderungen in den Snapshot
--abfragen werden somit entweder von Snapshotdateien beantowrtet 
--oder von der OrgDB, falls keine Ändeungen an den Seiten/Blöcken stattfanden


CREATE DATABASE SN_TESTDB_1115_14112017
ON
	--logischer Name der Datei aus der OrgDB ----neuer Name der Datei des Snapshot
( NAME =testdb , FILENAME = 'c:\_ODINDBS\SN_TESTDB_1115_14112017.mdf' )
AS SNAPSHOT OF testdb;
GO


--TFS: 100 GB
--Datenverlust: 1h
--Ausfallzeit:  3h

--Dauer des V Restore: mind 200MB/sek
V restore 80min
D: 
T: 

T sicherung läuft alle 15/20min
alle 3 T eine D
V jeden Tag einmal

Arbeitszeiten: 6 bis 18 
Mo bis Fr

V: 19 uhr
T: 6:20 alle 20min bis 18:05 
D: 7:10D alle Stunde bis 18:30









+ D oder T

