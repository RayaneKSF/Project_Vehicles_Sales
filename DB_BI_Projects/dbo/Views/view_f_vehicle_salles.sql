

CREATE VIEW [dbo].[view_f_vehicle_salles] AS
	SELECT TRY_CONVERT(DATE, SUBSTRING(saledate,4,12)) AS [saledate]
		  ,[sellingprice]
		  ,[mmr]
		  ,[odometer]
		  ,[condition]
		  ,[vin]
		  ,[state]
		  ,HASHBYTES('MD5', seller) AS [id_seller]
		  ,HASHBYTES('SHA1',
			CONCAT([interior]
					,[color]
					,[transmission]
					,[body]
					,[trim]
					,[model]
					,[make]
					,CAST([year] AS NVARCHAR(4)))) AS [id_features]
	FROM [dbo].[Car_Prices]
	WHERE LEN(state) <= 2 
