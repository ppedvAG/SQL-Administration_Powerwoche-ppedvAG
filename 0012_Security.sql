--Logins
select * from syslogins

--veraltet
sp_change_users_login 'report' --Auflisten aller verwaisten benutzer
sp_change_users_login 'Auto_fix', 'HANS', 'HANS',NULL, 'kennwort'

sp_change_users_login 'update_one', 'Hans', 'Hans' --bestehenden Benutzer mit Login verknüpfen

--Download
sp_help_revlogin