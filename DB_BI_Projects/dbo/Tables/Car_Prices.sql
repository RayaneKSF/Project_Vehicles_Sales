CREATE TABLE [dbo].[Car_Prices] (
    [year]         SMALLINT       NOT NULL,
    [make]         NVARCHAR (50)  NULL,
    [model]        NVARCHAR (50)  NULL,
    [trim]         NVARCHAR (50)  NULL,
    [body]         NVARCHAR (50)  NULL,
    [transmission] NVARCHAR (50)  NULL,
    [vin]          NVARCHAR (50)  NULL,
    [state]        NVARCHAR (50)  NOT NULL,
    [condition]    TINYINT        NULL,
    [odometer]     INT            NULL,
    [color]        NVARCHAR (50)  NULL,
    [interior]     NVARCHAR (50)  NULL,
    [seller]       NVARCHAR (100) NOT NULL,
    [mmr]          INT            NULL,
    [sellingprice] INT            NULL,
    [saledate]     NVARCHAR (50)  NULL
);

