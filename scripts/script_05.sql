/*
 * Script 04
 *
 * Objetivo: comandos para criação da tabela de importação dos dados de venda
 */

USE [DS]
GO

CREATE TABLE [dbo].[TbImp_Vendas](
    [NrNf] [varchar](50) NULL,
    [DataVenda] [varchar](50) NULL,
    [CodCliente] [varchar](50) NULL,
    [NomeCliente] [varchar](50) NULL,
    [EmailCliente] [varchar](50) NULL,
    [RegiaoVendas] [varchar](50) NULL,
    [Pais] [varchar](50) NULL,
    [GrupoGeografico] [varchar](50) NULL,
    [VendedorLogin] [varchar](50) NULL,
    [VendedorNome] [varchar](50) NULL,
    [VendedorChefeNome] [varchar](50) NULL,
    [Cod_Produto] [varchar](20) NULL,
    [Produto] [varchar](50) NULL,
    [Tamanho] [varchar](50) NULL,
    [Linha] [varchar](50) NULL,
    [Cor] [varchar](50) NULL,
    [SubTotal] [varchar](50) NULL,
    [ImpTotal] [varchar](50) NULL,
    [Frete] [varchar](50) NULL,
    [PrecoUnitario] [varchar](50) NULL,
    [Qtd] [varchar](50) NULL
) ON [PRIMARY]