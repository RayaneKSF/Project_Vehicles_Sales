CREATE VIEW dbo.[view_dim_vehicle_features] AS 
	SELECT DISTINCT [interior]
		   ,[color]
		   ,[transmission]
		   ,[body]
		   ,[trim]
		   ,[model]
		   ,[make]
		   ,[year]
		   ,HASHBYTES('SHA1',
			CONCAT([interior]
					,[color]
					,[transmission]
					,[body]
					,[trim]
					,[model]
					,[make]
					,CAST([year] AS NVARCHAR(4)))) AS ID_features

	FROM [dbo].[Car_Prices]