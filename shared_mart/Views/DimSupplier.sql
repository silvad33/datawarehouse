/*
Purpose:
*/

CREATE VIEW [shared_mart].[DimSupplier] AS

SELECT [SupplierKey],
	[SupplierName],
	[CoupaSupplierID],
	[Entity],
	[SupplierID],
	[LastUpdated]
FROM [dbo].[DimSupplier]
GO
