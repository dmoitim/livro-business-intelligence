/*
 * Script 08
 *
 * Objetivo: comandos para criação das tabelas de dimensão no banco Stage
 */

USE [DS]
GO

CREATE TABLE [dbo].[D_Data](
    [Data] [date] Primary Key NOT NULL,
    [Dia] [char](2) NOT NULL,
    [Mes] [char](2) NOT NULL,
    [Ano] [char](4) NOT NULL)

USE [DS]
GO

CREATE TABLE [dbo].[D_Cliente](
    [Cod_Cliente] [varchar](10) NOT NULL,
    [Nome] [varchar](50) NOT NULL,
    [Email] [varchar](50) NOT NULL,
    [LinData] [date] NOT NULL,
    [LinOrig] [varchar](50) NOT NULL)

GO

CREATE INDEX IX_Cod_Cliente ON [DS]..[D_Cliente] (Cod_Cliente)
CREATE INDEX IX_Cod_Cliente ON [DW]..[D_Cliente] (Cod_Cliente)