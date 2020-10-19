--BACKUP

/*
Was an alles passieren?

Physikalische Fehler
HDD defekt mit Log oder die HDD mit Datendateien
Server explodiert 


Logischer Fehler
jemand hat versehentlich Daten ge�ndert (falsch)

Man weiss, dass evtl jemand Daten f�lschlicher Weise �ndert
(ServicePack, Update)



FIRMENREGEL

Wie lange darf der Server bzw die Datenbank still stehen??

Wie hoch darf der Datenverlust sein?  10min..am besten kein Datenverlust

*/


/*
Jede Datenbank hat ein best. RecoveryModel
--> Logfile

Simple
protokolliert: INS, UP, DEL, BULK (rudiment�r)
leert aber nach einer bestimmten Zeit das Protokoll automatisch
es gibt keine LogSicherung

-----------------------
XX  X XX  X X         X
-----------------------



Bulk
protokolliert: INS, UP, DEL, BULK (rudiment�r)
das Log wird nicht mehr automatisch geleert
Das LogFile muss regelm��ig gesichert werden
Da nur die LogSicherung das Protokoll leert

--------------------------------------
                               XXXXXX
--------------------------------------

.BAK (XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX)
--bei Bulk kann man auch auf die Sekunde restoren,
aber nur dann wenn kein BULK stattfand





Full
protokolliert: INS, UP; DEL, BULK (vollst�ndig), Indizes
Das LogFile w�chst schneller.
Es leert sich nicht automatisch
Das Logfile muss regelm. gesichert werden, damit es geleert wird.

--Kann man auf jeden Fall auf Sekunde restoren!!!


Sicher<---------------------->Schnell
FULL              BULK         SIMPEL


Das RecoveryModel ist jederzeit �nderbar..im laufenden Betrieb
Aber das hat immer Konsequenzen











*/





--implizite Transaktionen
insert into customers (companyname, customerid) values ('ppedv G', 'ppedv')

--explizite Transaktionen
begin  transaction
update customers set city = 'bgh'
select * from customers
commit --rollback


---CHECKPOINT
--Committed Daten werden aus dem Log in MDF weggeschrieben





----BACKUP
/*
Vollst�ndige (V)
sichert Dateinamen, Pfade, Inhalte der Dateien
Das Logfile bleibt unangetastet
es wird ein Checkpoint ausgef�hrt
Alle commited Daten werden gesichert

Differentielle  (D)
sichert nur ge�nderte Seiten seit dem letzten V 
f�r den Restore braucht man das V



Transaktionsprotkollback (T)
sichert wie ein Makro(INS, UP, DEL..)
beim Restore wird jede Anweisung wiederholt bis zum gew�nschten Zeitpunkt




V: so h�ufig mie m�glich (abh�ngig von Speicherplatz f�r das Backup, Restoredauer)
T: macht man so h�ufig wie die Firmenregel den max. Datenverlust bestimmt
   zB: max 30min Datenverlust--> alle 30min T
	   so wenig wie m�glich Datenvelust: RecoveryModel: Full
D: verk�rzt den Restore (wg den T)
   alle 3 bis 4 T ein D

DB mit 1000MB (1 GB) Dauer: max 1 min
DB mit 100MB .. sekunden
DB mit 10 GB ..5 min bis 10 min


*/

--Fall 1: Jemand hat versehentlich Daten manipuliert

BACKUP DATABASE [Northwind] TO  DISK = N'C:\_Backup\Northwind.bak' 
		WITH NOFORMAT, NOINIT,  
		NAME = N'Northwind-VOLL', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

BACKUP DATABASE [Northwind] TO  DISK = N'C:\_Backup\Northwind.bak' 
		WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  
		NAME = N'Northwind-DIFF', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

BACKUP LOG [Northwind] TO  DISK = N'C:\_Backup\Northwind.bak' 
		WITH NOFORMAT, NOINIT,  
		NAME = N'Northwind-LOG', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--V  TTT D TTT D TTT






--DB : 1 GB... max Datenverlust: 30min

--V jedene Tag
--T alle 30 min
-- alle 1,5 Stunden D

--V TTT D TTT D TTT