--Dateigruppen helfen also 
--Tabellen auf mehrere Laufwerke zu verteilen--
--Performance

create table Produkte (id int) on STAMM

--backup und Restore von DGruppen m�glich
--aber beim restore braucht man die Logfilesicherungen.. alle seit dem def. zeitpunkt

