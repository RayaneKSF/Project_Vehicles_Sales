CREATE PROCEDURE dbo.ImportCarPricesIncremental
    @FilePath NVARCHAR(255) -- Caminho do arquivo CSV a ser importado
AS
BEGIN
    SET NOCOUNT ON;

    -- Tabela temporária para armazenar dados importados
    CREATE TABLE #TempCarPrices (
        year SMALLINT NOT NULL,
        make NVARCHAR(50) NULL,
        model NVARCHAR(50) NULL,
        trim NVARCHAR(50) NULL,
        body NVARCHAR(50) NULL,
        transmission NVARCHAR(50) NULL,
        vin NVARCHAR(50) NOT NULL, -- Chave primária ou identificador único
        state NVARCHAR(50) NOT NULL,
        condition TINYINT NULL,
        odometer INT NULL,
        color NVARCHAR(50) NULL,
        interior NVARCHAR(50) NULL,
        seller NVARCHAR(100) NOT NULL,
        mmr INT NULL,
        sellingprice INT NULL,
        saledate NVARCHAR(50) NULL
    );

    -- Preparar o comando para BULK INSERT
    DECLARE @Sql NVARCHAR(MAX);
    SET @Sql = '
    BULK INSERT #TempCarPrices
    FROM ''' + @FilePath + '''
    WITH (
        FIELDTERMINATOR = '','',  -- Delimitador de campo
        ROWTERMINATOR = ''\n'',   -- Delimitador de linha
        FIRSTROW = 2,           -- Ignorar o cabeçalho (opcional)
        TABLOCK
    );';

    -- Executar o comando dinâmico
    EXEC sp_executesql @Sql;

    -- Inserir os novos registros na tabela de destino
    INSERT INTO dbo.Car_Prices (
        year,
        make,
        model,
        trim,
        body,
        transmission,
        vin,
        state,
        condition,
        odometer,
        color,
        interior,
        seller,
        mmr,
        sellingprice,
        saledate
    )
    SELECT 
        t.year,
        t.make,
        t.model,
        t.trim,
        t.body,
        t.transmission,
        t.vin,
        t.state,
        t.condition,
        t.odometer,
        t.color,
        t.interior,
        t.seller,
        t.mmr,
        t.sellingprice,
        t.saledate
    FROM #TempCarPrices t
    LEFT JOIN dbo.Car_Prices d
    ON t.vin = d.vin
    WHERE d.vin IS NULL; -- Insere apenas registros que não existem na tabela de destino

    -- Limpar tabela temporária
    DROP TABLE #TempCarPrices;

    SET NOCOUNT OFF;
END;
