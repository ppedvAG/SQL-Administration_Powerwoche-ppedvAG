--mailsystem
--MAIl = MSDB
--SQL = SMTP Client

/*
MAILROOT
	DROP:	ankommenden Mails
	PICKUP: zu verschickende Mails
	QUEUE: geroutete MAILs
	BadMail: nicht zu stellbar


Agent Jobs k�nnen per Proxy auch mit anderen Konto ausgef�hrt werden


PROXY
--------------
1. Anmeldeinformation unter Sicherheit 
	(Windows Konto + Kennwort)
2. Unter SQL Agent
		die Anmeldeinformation als Proxy f�r best. Kategorien hinterlegen
3. Je nach Kategorie kann das Proxykonto f�r Auftr�ge verwendet werden

--PRoxy gibts es f�r Powershell, Cmd,Replikation oder auch SSIS
--aber nicht f�r TSQL


DBMAIL
--------------------------------
1. Facet auf Server: database Mail aktivieren
2. UNter Verwaltung
	DatenbankEmail konfiguerieren
		--> angabe des SMTP Konto (Server, email, Port, Authentifizierung)
			= Mail Profil
3. Agent: 
	Warnungssystem aktivieren und Mailprofil aus 2. zuweisen
	Agent neu starten

4. Operator einrichten (Unter Agent)
	Alias f�r hinterlegte emaiL adresse oder Pager

5. Auftr�gen Operator zuweisen


!! jeder der ein �ffentliches Mailprofil verwenden will
	muss in Datenbankrolle Databasemailuserrole sein

--> databasmailuserrole in msdb

sp_send_dbmail..

*/

select * from msdb.dbo.sysmail_log
select * from msdb.dbo.sysmail_allitems
select * from msdb.dbo.sysmail_faileditems
...
