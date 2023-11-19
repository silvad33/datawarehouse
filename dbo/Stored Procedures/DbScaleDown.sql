-- *****************************************************
-- Description  : Reset the current database pricing tier from high performance/cost to a lower tier
-- Notes        : Expects a optional @PricingTier param value. If no value was supplied, look up this db's default, and if none found, use 'S2'
--              : This procedure will not wait for database rescale to complete.Rescale can take multiple minutes to complete.
--              : Unlike the DbScaleUp procedure, the calling process will immediately receive execution.
--              :  Example call.  EXECUTE dbo.DbScaleDown ''
-- Contact      : John O'Neill
-- Date Created : 01/29/2021
-- Change hist. : 
-- *****************************************************
CREATE PROCEDURE [dbo].[DbScaleDown]
@PricingTier NVarchar(100) --= ''
AS
BEGIN TRY
DECLARE @dbName      NVARCHAR(100) = DB_Name()

DECLARE @SQL      NVARCHAR(1000) --Command to change Service Objective

IF (ISNULL(@PricingTier,'') ='')
BEGIN
    -- SET my default pricing iter.
    SET @PricingTier = (SELECT [dbo].DbPricingTierGetDefault())
     
    IF (ISNULL(@PricingTier,'') ='')
    BEGIN
        SET @PricingTier= 'S2'
        PRINT N'No pricing tier parameter provided, will set the default value of ' + @PricingTier
    END
    
END
SET @PricingTier = UPPER(@PricingTier)

DECLARE @CurrentDWServiceObjective Varchar(50) = (SELECT TOP 1 ISNULL(ds.service_objective,'') as ServiceTier FROM sys.database_service_objectives ds JOIN sys.databases db ON ds.database_id = db.database_id  WHERE DB.[name] =@dbName)
IF (@PricingTier =UPPER( @CurrentDWServiceObjective))
BEGIN
    -- desired service tier is already set
    PRINT N'The current pricing tier is already set to ' + @PricingTier + ' for ' + @dbName + '. No DbScaleDown changes  will be applied.'
END
ELSE-- Need to apply a change
BEGIN
    IF(SUBSTRING(@PricingTier,1,1)= 'S')
    BEGIN
    SET @sql = 'ALTER DATABASE ' + @dbname + ' MODIFY(EDITION=''Standard'', SERVICE_OBJECTIVE= ''' + @PricingTier + ''')'
    END
    IF(SUBSTRING(@PricingTier,1,1)= 'P')
    BEGIN
    SET @sql = 'ALTER DATABASE ' + @dbname + ' MODIFY(EDITION=''Premium'', SERVICE_OBJECTIVE= ''' + @PricingTier + ''')'
    END

    EXEC(@SQL)
    PRINT N'Scheduled pricing tier assignment of ' + @PricingTier
END


END TRY
BEGIN CATCH

    SELECT ERROR_NUMBER() AS ErrorNumber,
           ERROR_STATE() AS ErrorState,
           ERROR_SEVERITY() AS ErrorSeverity,
           ERROR_PROCEDURE() AS ErrorProcedure,
           ERROR_LINE() AS ErrorLine,
           ERROR_MESSAGE() AS ErrorMessage;
END CATCH