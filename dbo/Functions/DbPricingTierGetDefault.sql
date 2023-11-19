-- *****************************************************
-- Description  : Read the default performance/cost tier for this database
-- Notes        : TODO: use an Azure csv file for default values.  Until then, use static values assgined to Db names
-- Used by      : Stored procedure DbScaleDown
--              : Example use:  SELECT dbo.DbPricingTierGetDefault() as DbPricingTierDefault
-- Contact      : John O'Neill
-- Date Created : 02/23/2021
-- Change hist. : 11/1/2021.  Modified default pricing tier for IoniDDW. Set to 'P2'
-- *****************************************************
CREATE FUNCTION [dbo].[DbPricingTierGetDefault]()
RETURNS varchar(50)
AS
BEGIN
    DECLARE @PricingTier Varchar(50) =''
	DECLARE @returnValue varchar(50);
	DECLARE @dbName varchar(50) = DB_Name()
	
    -- TODO:  read an Azure file to parse the default values set for database instances.

    -- If no values set from Azure file, use defaults base on datbase name assignments

IF (ISNULL(@PricingTier,'') ='')
BEGIN
    DECLARE @FoundTextPoint INT

    -- check for feature db
    SET @FoundTextPoint = (SELECT CHARINDEX('DW_Feature', @dbName))--  Feature
    IF(@FoundTextPoint > 0)
    SET @PricingTier = 'S1'
  
    IF (ISNULL(@PricingTier,'') ='')
    BEGIN
        IF(@dbName = 'IonisDW_Test' )
        SET @PricingTier = 'S2'
    END
    
    IF (ISNULL(@PricingTier,'') ='')
    BEGIN
        IF(@dbName = 'IonisDW_Dev' )
        SET @PricingTier = 'S2'
    END

    IF (ISNULL(@PricingTier,'') ='')
    BEGIN
        IF(@dbName = 'IonisDW_Copy' )
        SET @PricingTier = 'S0'
    END

    IF (ISNULL(@PricingTier,'') ='')
    BEGIN
        IF(@dbName = 'EA' )
        SET @PricingTier = 'S2'
    END

    IF (ISNULL(@PricingTier,'') ='')
    BEGIN
        IF(@dbName = 'IonisDW' )
        SET @PricingTier = 'P2'
    END

    -- Finally, if no other matches, set to S1 default
    IF (ISNULL(@PricingTier,'') ='')
    BEGIN
        SET @PricingTier = 'S1'
    END

END -- Block to set pricing tier from static logic, not Azure file

   	--SET @returnValue = @PricingTier + ' is the default for ' + @dbName 
    SET @returnValue = @PricingTier
	RETURN @returnValue;
END