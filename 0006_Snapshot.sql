

-- Create the database snapshot
CREATE DATABASE <Database_Name, sysname, Database_Name>_<Snapshot_Id,,Snapshot_ID> ON
( NAME = <Database_Name, sysname, Database_Name>, FILENAME = 
'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Data\<Database_Name, sysname, Database_Name>_<Snapshot_Id,,Snapshot_ID>.ss' )
AS SNAPSHOT OF <Database_Name, sysname, Database_Name>;
GO


use testdb;

update kunden set spx = 'zz' where id < 10


select * from testdb.dbo.kunden where ID<10
select * from [SN_TESTDB_1115_14112017].dbo.kunden where ID<10


--Kann ich :
--ein Backup eines Snapshots machen?--NEIN
--ein Backup der OrgDB? --JA.. klar..logo!
--ein restore des Snapshot-- Hä.. kein Backup..kein Restore
--OrgDB restoren? --NEIN wg Snapshot, erst müssen alle Snapshots gelöscht werden
--kann man mehrere SNAPSHOTS haben.. ja
--vom Snapshot restoren.. ? ja!
--


--zuerst jeder User runter von der OrgDB! und am besten auch von snapshot!!
use master;


restore database testdb
from database_Snapshot='SN_TESTDB_1115_14112017'

select * from sysprocesses
		 where spid > 50--userprozesse
				and 
				dbid in (DB_ID('testdb'),DB_ID('SN_TESTDB_1115_14112017'))

--59,61

kill 59
kill 61





