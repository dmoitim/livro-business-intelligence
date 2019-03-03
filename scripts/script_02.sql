/*
 * Script 02
 *
 * Objetivo: comandos para criação da estrutura do DW
 *
 * Resultado: Geração dos objetos de banco
 */

/*
 * Drop all tables
   DROP TABLE [dbo].[F_VendaDetalhe];
   DROP TABLE [dbo].[F_Venda];
   DROP TABLE [dbo].[D_Cliente];
   DROP TABLE [dbo].[D_Data];
   DROP TABLE [dbo].[D_Funcionario];
   DROP TABLE [dbo].[D_Produto];
   DROP TABLE [dbo].[D_RegiaoVendas];
   DROP TABLE [dbo].[D_Pais];
   DROP TABLE [dbo].[D_GrupoGeografico];
 */

USE [DW]

GO

CREATE TABLE [dbo].[D_Cliente](
    [Id_Cliente] [int] identity(1,1) NOT NULL,
    [Cod_Cliente] [varchar](10) NOT NULL,
    [Nome] [varchar](50) NOT NULL,
    [Email] [varchar](50) NOT NULL,
    [LinData] [date] NOT NULL,
    [LinOrig] [varchar](50) NOT NULL,
    CONSTRAINT [PK_D_Cliente] PRIMARY KEY CLUSTERED
    (
        [Id_Cliente] ASC
    ) WITH (
        PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
    ) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[D_Data](
    [Data] [date] NOT NULL,
    [Dia] [char](2) NOT NULL,
    [Mes] [char](2) NOT NULL,
    [Ano] [char](4) NOT NULL,
    CONSTRAINT [PK_D_Data] PRIMARY KEY CLUSTERED
    (
        [Data] ASC
    ) WITH (
        PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
    ) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[D_Funcionario](
    [Id_Funcionario] [int] identity(1,1) NOT NULL,
    [Nome] [varchar](50) NOT NULL,
    [Login] [varchar](50) NOT NULL,
    [Id_Chefe] [int] NULL,
    [LinData] [date] NOT NULL,
    [LinOrig] [varchar](50) NOT NULL,
    CONSTRAINT [PK_D_Funcionario] PRIMARY KEY CLUSTERED
    (
        [Id_Funcionario] ASC
    ) WITH (
        PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
    ) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[D_GrupoGeografico](
    [Id_GrupoGeo] [int] identity(1,1) NOT NULL,
    [Nome] [varchar](50) NOT NULL,
    [LinData] [date] NOT NULL,
    [LinOrig] [varchar](50) NOT NULL,
    CONSTRAINT [PK_D_GrupoGeografico] PRIMARY KEY CLUSTERED
    (
        [Id_GrupoGeo] ASC
    ) WITH (
        PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
    ) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[D_Pais](
    [Id_Pais] [int] identity(1,1) NOT NULL,
    [Id_GrupoGeo] [int] NOT NULL,
    [Sigla] [char](2) NOT NULL,
    [LinData] [date] NOT NULL,
    [LinOrig] [varchar](50) NOT NULL,
    CONSTRAINT [PK_D_Pais] PRIMARY KEY CLUSTERED
    (
        [Id_Pais] ASC
    ) WITH (
        PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
    ) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[D_Produto](
    [Id_Produto] [int] identity(1,1) NOT NULL,
    [Cod_Produto] [varchar](20) NOT NULL,
    [Nome] [varchar](50) NOT NULL,
    [Tamanho] [varchar](5) NOT NULL,
    [Cor] [varchar](20) NOT NULL,
    [Ativo] [char](1) NOT NULL,
    [LinData] [date] NOT NULL,
    [LinOrig] [varchar](50) NOT NULL,
    CONSTRAINT [PK_D_Produto] PRIMARY KEY CLUSTERED
    (
        [Id_Produto] ASC
    ) WITH (
        PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
    ) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[D_RegiaoVendas](
    [Id_RegiaoVendas] [int] identity(1,1) NOT NULL,
    [Id_Pais] [int] NOT NULL,
    [Nome] [varchar](20) NOT NULL,
    [LinData] [date] NOT NULL,
    [LinOrig] [varchar](50) NOT NULL,
    CONSTRAINT [PK_D_RegiaoVendas] PRIMARY KEY CLUSTERED
    (
        [Id_RegiaoVendas] ASC
    ) WITH (
        PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
    ) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[F_Venda](
    [Data] [date] NOT NULL,
    [Nr_NF][varchar] (10) NOT NULL,
    [Id_Cliente] [int] NOT NULL,
    [Id_Funcionario] [int] NOT NULL,
    [Id_RegiaoVendas] [int] NOT NULL,
    [Vlr_Imposto] [decimal](18, 2) NOT NULL,
    [Vlr_Frete] [decimal](18, 2) NOT NULL,
    [LinData] [date] NOT NULL,
    [LinOrig] [varchar](50) NOT NULL,
    CONSTRAINT [PK_F_Venda] PRIMARY KEY CLUSTERED
    (
        [Data] ASC,
        [Nr_NF] ASC,
        [Id_Cliente] ASC,
        [Id_Funcionario] ASC,
        [Id_RegiaoVendas] ASC
    ) WITH (
        PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
    ) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[F_VendaDetalhe](
    [Data] [date] NOT NULL,
    [Nr_NF][varchar] (10) NOT NULL,
    [Id_Cliente] [int] NOT NULL,
    [Id_Funcionario] [int] NOT NULL,
    [Id_RegiaoVendas] [int] NOT NULL,
    [Id_Produto] [int] NOT NULL,
    [Vlr_Unitario] [decimal](18, 2) NOT NULL,
    [Qtd_Vendida] [int] NOT NULL,
    [LinData] [date] NOT NULL,
    [LinOrig] [varchar](50) NOT NULL,
    CONSTRAINT [PK_F_VendaDetalhe] PRIMARY KEY CLUSTERED
    (
        [Data] ASC,
        [Nr_NF] ASC,
        [Id_Cliente] ASC,
        [Id_Funcionario] ASC,
        [Id_RegiaoVendas] ASC,
        [Id_Produto] ASC
    ) WITH (
        PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
    ) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX [IX_D_Pais] ON [dbo].[D_Pais] (
    [Id_GrupoGeo] ASC
) WITH (
    PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX [IX_D_RegiaoVendas] ON [dbo].[D_RegiaoVendas] (
    [Id_Pais] ASC
) WITH (
    PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[D_Pais]
    WITH CHECK ADD CONSTRAINT [FK_D_Pais_D_GrupoGeografico]
    FOREIGN KEY([Id_GrupoGeo])
    REFERENCES [dbo].[D_GrupoGeografico] ([Id_GrupoGeo])

GO

ALTER TABLE [dbo].[D_Pais]
    CHECK CONSTRAINT [FK_D_Pais_D_GrupoGeografico]

GO

ALTER TABLE [dbo].[D_RegiaoVendas]
    WITH CHECK ADD CONSTRAINT [FK_D_RegiaoVendas_D_Pais]
    FOREIGN KEY([Id_Pais])
    REFERENCES [dbo].[D_Pais] ([Id_Pais])

GO

ALTER TABLE [dbo].[D_RegiaoVendas]
    CHECK CONSTRAINT [FK_D_RegiaoVendas_D_Pais]

GO

ALTER TABLE [dbo].[F_Venda]
    WITH CHECK ADD CONSTRAINT [FK_F_Venda_D_Cliente]
    FOREIGN KEY([Id_Cliente])
    REFERENCES [dbo].[D_Cliente] ([Id_Cliente])

GO

ALTER TABLE [dbo].[F_Venda]
    CHECK CONSTRAINT [FK_F_Venda_D_Cliente]

GO

ALTER TABLE [dbo].[F_Venda]
    WITH CHECK ADD CONSTRAINT [FK_F_Venda_D_Data]
    FOREIGN KEY([Data])
    REFERENCES [dbo].[D_Data] ([Data])

GO

ALTER TABLE [dbo].[F_Venda]
    CHECK CONSTRAINT [FK_F_Venda_D_Data]

GO

ALTER TABLE [dbo].[F_Venda]
    WITH CHECK ADD CONSTRAINT [FK_F_Venda_D_Funcionario]
    FOREIGN KEY([Id_Funcionario])
    REFERENCES [dbo].[D_Funcionario] ([Id_Funcionario])

GO

ALTER TABLE [dbo].[F_Venda]
    CHECK CONSTRAINT [FK_F_Venda_D_Funcionario]

GO

ALTER TABLE [dbo].[F_Venda]
    WITH CHECK ADD CONSTRAINT [FK_F_Venda_D_RegiaoVendas]
    FOREIGN KEY([Id_RegiaoVendas])
    REFERENCES [dbo].[D_RegiaoVendas] ([Id_RegiaoVendas])

GO

ALTER TABLE [dbo].[F_Venda]
    CHECK CONSTRAINT [FK_F_Venda_D_RegiaoVendas]

GO

ALTER TABLE [dbo].[F_VendaDetalhe]
    WITH CHECK ADD CONSTRAINT [FK_F_VendaDetalhe_D_Produto]
    FOREIGN KEY([Id_Produto])
    REFERENCES [dbo].[D_Produto] ([Id_Produto])

GO

ALTER TABLE [dbo].[F_VendaDetalhe]
    CHECK CONSTRAINT [FK_F_VendaDetalhe_D_Produto]

GO

ALTER TABLE [dbo].[F_VendaDetalhe]
    WITH CHECK ADD CONSTRAINT [FK_F_VendaDetalhe_F_Venda]
    FOREIGN KEY(
        [Data],
        [Nr_NF],
        [Id_Cliente],
        [Id_Funcionario],
        [Id_RegiaoVendas]
    ) REFERENCES [dbo].[F_Venda] (
        [Data],
        [Nr_NF],
        [Id_Cliente],
        [Id_Funcionario],
        [Id_RegiaoVendas]
    )

GO

ALTER TABLE [dbo].[F_VendaDetalhe]
    CHECK CONSTRAINT [FK_F_VendaDetalhe_F_Venda]

GO