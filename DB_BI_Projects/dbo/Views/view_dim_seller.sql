


CREATE VIEW [dbo].[view_dim_seller] AS
	SELECT DISTINCT [seller]
		,HASHBYTES('MD5', seller) AS [ID_seller]
FROM [dbo].[Car_Prices]
