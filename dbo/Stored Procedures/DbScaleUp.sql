﻿-- *****************************************************
-- Description  : Reset the current database to a high performance/cost tier.  
-- Notes        : Caller must have ALTER DATABASE (high level) access permission.
--		: Expects a @PricingTier param. If not provided, 'P4' is will be used.
--              : This procedure will wait for database rescale to complete.Rescale can take multiple minutes to complete.
--              : Example prameters include 'S6', 'P1', 'P2','P4'
--              : e.g. EXECUTE dbo.ScaleUp 'S6',  or EXECUTE db.ScaleUp ''
-- See also     : dbo.ScaleDown, dbo.ScaleUpNoWait
-- Contact      : Daniel Silva
-- Date Created : 01/29/2021
-- Change hist. : 03/22/2021.  Set default scale up tier to P4
-- *****************************************************
CREATE PROCEDURE [dbo].[DbScaleUp]
    @PricingTier NVarchar(100) 
AS
BEGIN TRY
DECLARE @dbName      NVARCHAR(100) = DB_Name()

DECLARE @CurrentDWServiceObjective NVARCHAR(100) = 'TBD'

DECLARE @DelayInSeconds    INT = 10  --must be between 0 and 59
DECLARE @CumulativeDelayInSeconds INT = 0
DECLARE @MaxDelayInSeconds   INT = 900  --> 15 minutes
DECLARE @DelayString    CHAR(8)   --WAITFOR uses a string (00:00:10)

DECLARE @SQL      NVARCHAR(1000) --Command to change Service Objective
DECLARE @Message     NVARCHAR(1000) --Used in error message

-- Create a delay string that can be used by SQL Server
SELECT @DelayString = '00:00:' + RIGHT('0' + CAST(@DelayInSeconds AS VARCHAR(2)), 2)

SET @CurrentDWServiceObjective = (SELECT TOP 1 ds.service_objective as ServiceTier FROM sys.database_service_objectives ds JOIN sys.databases db ON ds.database_id = db.database_id  WHERE DB.[name] =@dbName)

PRINT N'Service tier on ' + @dbName + ' was set to ' + @CurrentDWServiceObjective
IF (ISNULL(@PricingTier,'') ='')
BEGIN
    SET @PricingTier= 'P4'
    PRINT N'No pricing tier parameter provided, will set the default value of ' + @PricingTier
END
SET @PricingTier = UPPER(@PricingTier)
PRINT N'Will attempt to set pricing tier to ' + @PricingTier + '...'

IF(SUBSTRING(@PricingTier,1,1)= 'S')
BEGIN
  SET @sql = 'ALTER DATABASE ' + @dbname + ' MODIFY(EDITION=''Standard'', SERVICE_OBJECTIVE= ''' + @PricingTier + ''')'
END
IF(SUBSTRING(@PricingTier,1,1)= 'P')
BEGIN
  SET @sql = 'ALTER DATABASE ' + @dbname + ' MODIFY(EDITION=''Premium'', SERVICE_OBJECTIVE= ''' + @PricingTier + ''')'
END

EXEC(@sql)

WHILE (@CurrentDWServiceObjective <> @PricingTier) AND (@CumulativeDelayInSeconds <= @MaxDelayInSeconds)
BEGIN
    SET @CurrentDWServiceObjective = (SELECT TOP 1 ds.service_objective as ServiceTier FROM sys.database_service_objectives ds JOIN sys.databases db ON ds.database_id = db.database_id  WHERE DB.[name] =@dbName)
    
    --Initiate delay
    WAITFOR DELAY @DelayString

    --Increment cumulative delay
    SELECT @CumulativeDelayInSeconds += @DelayInSeconds
END

PRINT N'Pricing tier is ' + @CurrentDWServiceObjective
END TRY
BEGIN CATCH

    SELECT ERROR_NUMBER() AS ErrorNumber,
           ERROR_STATE() AS ErrorState,
           ERROR_SEVERITY() AS ErrorSeverity,
           ERROR_PROCEDURE() AS ErrorProcedure,
           ERROR_LINE() AS ErrorLine,
           ERROR_MESSAGE() AS ErrorMessage;
END CATCH