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

GO

CREATE PROCEDURE [dbo].[Carrega_D_Geografia]
AS

BEGIN TRY
	-- Apaga os dados das tabelas no Stage:
	TRUNCATE TABLE [DS]..[D_GrupoGeografico]
	TRUNCATE TABLE [DS]..[D_Pais]
	TRUNCATE TABLE [DS]..[D_RegiaoVendas]

	-- Insere os dados da D_GrupoGeografico no Stage:
	INSERT INTO [dbo].[D_GrupoGeografico]
	SELECT DISTINCT
	       GrupoGeografico,
		   GETDATE() AS [LinData],
		   'Arquivo de Vendas' AS [LinOrig]
	  FROM [DS]..[TbImp_Vendas]

	-- Carrega os dados no DW:
	INSERT INTO [DW]..[D_GrupoGeografico]
	SELECT DISTINCT
	       ds.Nome,
		   ds.LinData,
		   ds.LinOrig
	  FROM [DS]..[D_GrupoGeografico] AS ds
	  LEFT JOIN [DW]..[D_GrupoGeografico] AS dw
	    ON ds.[Nome] = dw.[Nome]
	 WHERE dw.[Id_GrupoGeo] IS NULL

	-- Insere os dados na D_Pais do Stage:
	INSERT INTO [dbo].[D_Pais]
	SELECT DISTINCT
	       dw.Id_GrupoGeo,
		   ds.Pais,
		   GETDATE() AS [LinData],
		   'Arquivo	de	Vendas'	AS	[LinOrig]
	  FROM [DS]..[TbImp_Vendas]	AS ds
	 INNER JOIN [DW]..[D_GrupoGeografico] AS dw
	    ON ds.GrupoGeografico = dw.Nome

	-- Carrega os dados no DW:
	INSERT INTO [DW]..[D_Pais]
	SELECT ds.[Id_GrupoGeo],
	       ds.[Sigla],
		   ds.[LinData],
		   ds.[LinOrig]
	  from [DS]..[D_Pais] AS ds
	  LEFT JOIN [DW]..[D_Pais] AS dw
	    ON ds.Id_GrupoGeo = dw.Id_GrupoGeo
	   AND ds.Sigla = dw.Sigla
	 WHERE dw.Id_Pais IS NULL

	 -- Insere os dados na D_RegiaoVendas do Stage:
	 INSERT INTO [dbo].[D_RegiaoVendas]
	 SELECT DISTINCT
			dw.Id_Pais,
			ds.RegiaoVendas,
			GETDATE() AS [LinData],
			'Arquivo de Vendas' AS [LinOrig]
	   FROM [DS]..[TbImp_Vendas] AS ds
	  INNER JOIN [DW]..[D_Pais] AS dw
		 ON ds.Pais = dw.[Sigla]

	 -- Carrega os dados no DW:
	 INSERT INTO [DW]..[D_RegiaoVendas]
	 SELECT ds.[Id_Pais],
	        ds.[Nome],
			ds.[LinData],
			ds.[LinOrig]
	   FROM [DS]..[D_RegiaoVendas] AS ds
	   LEFT JOIN [DW]..[D_RegiaoVendas] AS dw
	     ON ds.Id_Pais = dw.Id_Pais
		AND ds.Nome = dw.Nome
	  WHERE dw.Id_RegiaoVendas IS NULL

	 -- Faz o log do processo:
	 INSERT INTO [dbo].[Adm_Log]
	 VALUES (NEWID(),
	        GETDATE(),
			'Importa Geografia',
			'S',
			'Carga das tabelas de Geografia com sucesso.')
END TRY

BEGIN CATCH
	-- Faz o log do processo:
	 INSERT INTO [dbo].[Adm_Log]
	 VALUES (NEWID(),
	        GETDATE(),
			'Importa Geografia',
			'F',
			'Erro ao carregar tabelas de Geografia.')
END CATCH

GO

CREATE PROCEDURE [dbo].[Carrega_D_Funcionario]
AS

BEGIN TRY
	-- Apaga os dados da D_Funcionario no Stage:
	TRUNCATE TABLE [DS]..[D_Funcionario]

	-- Isere os dados na D__Funcionario no Stage:
	INSERT INTO [dbo].[D_Funcionario]
		([Nome], [Login], [LinData], [LinOrig])
	SELECT DISTINCT
	       VendedorNome,
		   VendedorLogin,
		   GETDATE() AS [LinData],
		   'Arquivo de Vendas' AS [LinOrig]
	  FROM [DS]..[TbImp_Vendas]

	-- Carrega os dados no DW:
	INSERT INTO [DW]..[D_Funcionario]
	SELECT ds.[Nome],
		   ds.[Login],
		   ds.[Id_Chefe],
		   ds.[LinData],
		   ds.[LinOrig]
	  FROM [DS]..[D_Funcionario] AS ds
	  LEFT JOIN [DW]..[D_Funcionario] AS dw
		ON ds.[Login] = dw.[Login]
	 WHERE dw.Id_Funcionario IS NULL

	-- Atualiza o Id_Chefe no DW:
	declare @Id_funcionario int
	declare @LoginFuncionario varchar(50)
	declare @NomeFuncionario varchar(50)
	declare @NomeChefe varchar(50)
	declare @Id_Chefe int

declare cur_AtualizaChefe cursor for
	SELECT Id_Funcionario,
		   Login,
		   Nome
	  FROM [DW]..[D_Funcionario]

	OPEN cur_AtualizaChefe
		FETCH NEXT FROM cur_AtualizaChefe
		INTO @Id_funcionario, @LoginFuncionario, @NomeFuncionario

		WHILE @@FETCH_STATUS = 0
			BEGIN
				-- Determina o nome do Chefe:
				SET @NomeChefe = (SELECT DISTINCT VendedorChefeNome
				                    FROM [DS]..[TbImp_Vendas] AS b
								   WHERE b.VendedorLogin = @LoginFuncionario)

				-- Determina o ID do Chefe:
				SET @Id_Chefe = (SELECT Id_Funcionario
				                   FROM [DW]..[D_Funcionario] AS b
								  WHERE b.Nome = @NomeChefe)

				-- Determina o ID do Chefe:
				IF @NomeChefe != @NomeFuncionario -- A pessoa não é o prorpio chefe (quem não tem chefe)
					BEGIN
						UPDATE [DW]..[D_Funcionario]
						   SET Id_Chefe = @Id_Chefe
						 WHERE Id_Funcionario = @Id_funcionario
					END

				FETCH NEXT FROM cur_AtualizaChefe
				INTO @Id_funcionario, @LoginFuncionario, @NomeFuncionario
			END
		CLOSE cur_AtualizaChefe

		DEALLOCATE cur_AtualizaChefe

	-- Faz o log do processo:
	 INSERT INTO [dbo].[Adm_Log]
	 VALUES (NEWID(),
	         GETDATE(),
			 'Importa Funcionario',
			 'S',
			 'Carga de D_Funcionario com sucesso.')
END TRY

BEGIN CATCH
	-- Faz o log do processo:
	 INSERT INTO [dbo].[Adm_Log]
	 VALUES (NEWID(),
	         GETDATE(),
			 'Importa Funcionario',
			 'F',
			 'Erro ao carregar D_Funcionario.')
END CATCH