/*
 * Script 06
 *
 * Objetivo: comandos para criação da procedure de importação dos dados de venda
 */

USE [DS]
GO

Create procedure [dbo].[Importa_Vendas] as
    Declare @STR as nvarchar(1000)
    -- Apaga os dados da TbImp_Vendas caso existam para uma nova carga;
    truncate table TbImp_Vendas

    -- Renomeia arquivos existentes para um nome esperado:
    set @STR = 'Move C:\Arquivos\*.rpt C:\Arquivos\MassaDados.rpt'
    exec xp_cmdshell @STR

    --Importa os dados do arquivo para o SQL:
    bulk insert [dbo].[TbImp_Vendas]
    from 'C:\Arquivos\MassaDados.rpt'
    with (
        FIRSTROW = 3,
        FIELDTERMINATOR = '|',
        ROWTERMINATOR = '\n'
    )

    -- Faz o log do processo:
    insert into [dbo].[Adm_Log] values (newid(), getdate(), 'Importa MassaDados.rpt','S', 'Arquivo importado com sucesso')

    -- Copia o arquivo para a pasta "Historico", renomeando ele com a data da importação:
    declare @nomearquivo varchar(50)
    Set @nomearquivo = (Select cast(year(getdate())as char(4)) + right('00'+ cast(month(getdate())as varchar(2)),2)+ right('00'+ cast(day(getdate())as varchar(2)),2) +'_Vendas.rpt')

    Set @STR = 'move C:\Arquivos\MassaDados.rpt c:\Arquivos\Historico\' + @nomearquivo
    
    exec xp_cmdshell @STR