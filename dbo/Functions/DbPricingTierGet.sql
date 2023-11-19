-- *****************************************************
-- Description  : Read the current performance/cost tier for this database
-- Notes        : Returns a single pricing tier value. eg. 'S2'
-- Used by		: DbScaleDown stored procedure.
--              : Example use:  SELECT dbo.DbPricingTierGet() as DbPricingTier
-- Contact      : John O'Neill
-- Date Created : 02/23/2021
-- Change hist. : 
-- *****************************************************
CREATE FUNCTION [dbo].[DbPricingTierGet]()
RETURNS varchar(50)
AS
BEGIN
    
	DECLARE @returnValue varchar(50);
	SET @returnValue = (SELECT TOP 1 ds.service_objective as ServiceTier FROM sys.database_service_objectives ds JOIN sys.databases db ON ds.database_id = db.database_id  WHERE DB.[name] =DB_NAME())
	RETURN @returnValue;
END
GO