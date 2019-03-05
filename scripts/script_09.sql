/*
 * Script 09
 *
 * Objetivo: comandos para criação das procedures de importação
 */

USE [DS]
GO

CREATE PROCEDURE [dbo].[Carrega_D_Data]
AS

BEGIN TRY
    -- Apaga os dados da D_Data no Stage:
    TRUNCATE TABLE [DS]..[D_Data]

    -- Insere os dados na D_Data no Stage:
    INSERT INTO [dbo].[D_Data]
    SELECT DISTINCT
		   CAST(DataVenda AS DATE) AS Data,
		   RIGHT('00' + CAST(DAY(DataVenda) AS VARCHAR(2)), 2) AS Dia,
		   RIGHT('00' + CAST(MONTH(DataVenda) AS VARCHAR(2)), 2) AS Mes,
		   YEAR(DataVenda) AS Ano
      FROM [DS]..[TbImp_Vendas]

	-- Carrega os dados no DW
	INSERT INTO [DW]..[D_Data]
	SELECT ds.data,
	       ds.Dia,
		   ds.Mes,
		   ds.Ano
	  FROM [DS]..[D_Data] AS ds
	  LEFT JOIN [DW]..[D_Data] AS dw
	    ON ds.Data = dw.Data
	 WHERE dw.Data IS NULL -- Trata o backup incremental

	 -- Faz o log do processo:
	 INSERT INTO [dbo].Adm_Log
	 VALUES (NEWID(),
			 GETDATE(),
			 'Importa Data',
			 'S',
			 'Carga de D_Data com sucesso.')
END TRY

BEGIN CATCH
	 -- Faz o log do processo:
	 INSERT INTO [dbo].Adm_Log
	 VALUES (NEWID(),
			 GETDATE(),
			 'Importa Data',
			 'F',
			 'Erro ao carregar D_Data.')
END CATCH

GO

CREATE PROCEDURE [dbo].[Carrega_D_Cliente]
AS

BEGIN TRY
	-- Apaga os dados da D_Cliente no Stage:
	TRUNCATE TABLE [DS]..[D_Cliente]

	-- Insere os dados na D_Cliente no Stage:
	INSERT INTO [dbo].[D_Cliente]
	SELECT DISTINCT
		   CodCliente AS [Cod_Cliente],
		   NomeCliente AS [Nome],
		   EmailCliente AS [Email],
		   Getdate() AS [LinData],
		   'Arquivo de Vendas' AS [LinOrig]
	  FROM [DS]..[TbImp_Vendas]

	-- Carrega os dados no DW:
	INSERT INTO [DW]..[D_Cliente]
	SELECT ds.Cod_Cliente,
	       ds.Nome,
		   ds.Email,
		   ds.LinData,
		   ds.LinOrig
	  FROM [DS]..[D_Cliente] AS ds
	  LEFT JOIN [DW]..[D_Cliente] AS dw
	    ON ds.Cod_Cliente = dw.Cod_Cliente
	 WHERE dw.ID_Cliente IS NULL -- Trata o backup incremental

	-- Faz o log do processo:
	INSERT INTO [dbo].[Adm_Log]
	VALUES (NEWID(),
	        GETDATE(),
			'Importa Cliente',
			'S',
			'Carga de D_Cliente com sucesso.')
END TRY

BEGIN CATCH
	-- Faz o log do processo:
	INSERT INTO [dbo].[Adm_Log]
	VALUES (NEWID(),
	        GETDATE(),
			'Importa Cliente',
			'F',
			'Erro ao carregar D_Cliente.')
END CATCH