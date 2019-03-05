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

GO

CREATE TABLE [dbo].[D_GrupoGeografico] (
	[Nome] [varchar](50) NOT NULL,
	[LinData] [date] NOT NULL,
	[LinOrig] [varchar](50) NOT NULL)

GO

CREATE INDEX IX_D_GrupoGeografico_nome ON [DS]..[D_GrupoGeografico] ([Nome])
CREATE INDEX IX_D_GrupoGeografico_nome ON [DW]..[D_GrupoGeografico] ([Nome])

GO

CREATE TABLE [dbo].[D_Pais] (
	[Id_GrupoGeo] [int] NOT NULL,
    [Sigla] [char](2) NOT NULL,
    [LinData] [date] NOT NULL,
    [LinOrig] [varchar](50) NOT NULL)

GO

CREATE INDEX IX_D_PaisIdGrupoGeo ON [DS]..[D_Pais] ([Id_GrupoGeo])
CREATE INDEX IX_D_PaisSigla ON [DS]..[D_Pais] ([Sigla])
CREATE INDEX IX_D_PaisSigla ON [DW]..[D_Pais] ([Sigla])

GO

CREATE TABLE [dbo].[D_RegiaoVendas](
    [Id_Pais] [int] NOT NULL,
    [Nome] [varchar](20) NOT NULL,
    [LinData] [date] NOT NULL,
    [LinOrig] [varchar](50) NOT NULL)

GO

CREATE INDEX IX_D_RegiaoIdPais ON [DS]..[D_RegiaoVendas] ([Id_Pais])
CREATE INDEX IX_D_RegiaoNome ON [DS]..[D_RegiaoVendas] ([Nome])
CREATE INDEX IX_D_RegiaoNome ON [DW]..[D_RegiaoVendas] ([Nome])

GO

CREATE TABLE [dbo].[D_Funcionario](
    [Nome] [varchar](50) NOT NULL,
    [Login] [varchar](50) NOT NULL,
    [Id_Chefe] [int] NULL,
    [LinData] [date] NOT NULL,
    [LinOrig] [varchar](50) NOT NULL)

CREATE INDEX IX_D_FuncionarioLogin ON [DS]..[D_Funcionario] ([Login])
CREATE INDEX IX_D_FuncionarioLogin ON [DW]..[D_Funcionario] ([Login])