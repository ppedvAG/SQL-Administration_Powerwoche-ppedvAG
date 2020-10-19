/*
Hochverfügbarkeit

Logshipping
Backup-Restore
BackupLog-->Copy BackupLOG-->RestoreLOG

Assi: +++
5 Aufträge (2 Alerts)

Probleme: 
+++
Dateien kopieren
S1 --> S2  \\
Agent!

Client
Client Redirect
kein AutoFO
ZielDb nur lesbar (bestenfalls)
ZeitDiff: 2min

Einrichtungsdauer: 
unter 1 min

STD Version
1 DB:N DB


Spiegeln
STD version
Assi:++(+)
Manuell: V+T --> Restore auf S2 mit NORECOVERY
ZielDB nicht lesbar
1:1 DB 
(a)synchron

AutoFO--> 3.ten SQL Server(Zeuge kann express)
ClientRedirect: SQLNCLI!
ist depricated
Eig. Kanal: 5022 (port)
Probleme. Firewall, Zugriffsrechte für SQL Dienste auf Endpunkte(5022)
Einrichtungsdauer: 10Sek



Cluster
komplexerer Umgebung
SQL Cluster + NT Cluster
gemeinsame Ressourcen (HDDs auf SAN/iSCSI)

Server : Server
Dateiausfall ist Desaster, es geht hier nur um Dienstausfall

Im Netz : VSQL (virtueller SQL Server)

Einrichtungsdauer: gute 30min (mit schlechten Gewissen)
IsCSI wird auch als csv supported 
tempdb lokal







AvailabilityGroups

NT Cluster (bis 2016).. ab 2017 auch ohne Custer
kein SQL Cluster

SQL1 --> SQL2 spiegeln
1DB : 7 dbs (3 lesbar)  (8 Server)
(a)synchron

Client--> VSQL



*/