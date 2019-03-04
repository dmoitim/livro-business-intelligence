/*
 * Script 03
 *
 * Objetivo: comandos para permitir a execução de comandos para o Windows diretamente pelo SQL Server
 */
 
exec sp_configure "show advanced options", 1
go

reconfigure
go

EXEC sp_configure 'xp_cmdshell', 1
go

reconfigure
go