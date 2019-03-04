/*
 * Script 04
 *
 * Objetivo: comandos para criação da tabela de logs
 */

USE [DS]
GO

CREATE TABLE [dbo].[Adm_Log](
    [Id_Log] [uniqueidentifier] primary key NOT NULL,
    [Data] [datetime] NOT NULL,
    [Passo] [varchar](50) NOT NULL,
    [SucessoFalha] [char](1) NOT NULL,
    [mensagem] [varchar](255) NOT NULL
)