CREATE PROCEDURE spDimFinancialDimensions AS

DROP TABLE DimFinancialDimensions
DECLARE @AttributeName varchar(1000),
	@SQLString varchar(max),
	@SQLString2 varchar(max)

SELECT @SQLString='CREATE TABLE DimFinancialDimensions(LedgerDimension bigint'
SELECT @SQLString2='INSERT INTO DimFinancialDimensions(LedgerDimension'

DECLARE AttributeCursor CURSOR FOR
SELECT Distinct Attributename
FROM [dbo].[RSMFinancialDimensionStaging]
WHERE NOT AttributeName like 'SystemGeneratedAttribute%'
ORDER BY AttributeName

OPEN AttributeCursor

FETCH NEXT FROM AttributeCursor INTO @AttributeName

WHILE @@FETCH_STATUS=0
BEGIN
	SELECT @SQLString=@SQLString+','+@AttributeName+'Value VARCHAR(1000), '+ @AttributeName+'Description VARCHAR(1000)'
	SELECT @SQLString2=@SQLString2+','+@AttributeName+'Value'
	FETCH NEXT FROM AttributeCursor INTO @AttributeName
END

CLOSE AttributeCursor
DEALLOCATE AttributeCursor

SELECT @SQLString=@SQLString+')'

EXEC (@SQLString)

SELECT @SQLString2=@SQLString2+') SELECT DISTINCT fc.LedgerDimension'

DECLARE LoadCursor CURSOR FOR
SELECT Distinct Attributename
FROM [dbo].[RSMFinancialDimensionStaging]
WHERE NOT AttributeName like 'SystemGeneratedAttribute%'
ORDER BY AttributeName

OPEN LoadCursor

FETCH NEXT FROM LoadCursor INTO @AttributeName

WHILE @@FETCH_STATUS=0
BEGIN
	SELECT @SQLString2=@SQLString2+',ISNULL((SELECT AttributeValue
	FROM RSMFinancialDimensionStaging fd
	WHERE fd.AttributeName='+''''+@AttributeName+''''+ ' and fc.LEDGERDIMENSION=fd.LEDGERDIMENSION),''''+'''') as '+ @AttributeName

	FETCH NEXT FROM LoadCursor INTO @AttributeName
END

CLOSE LoadCursor
DEALLOCATE LoadCursor

SELECT @SQLString2=@SQLString2+
	' FROM RSMFinancialDimensionStaging fc'

EXEC (@SQLString2)
--select @SQLString2

UPDATE DimFinancialDimensions
SET DepartmentDescription=
	(SELECT DESCRIPTION
	FROM FinancialDimensionValueEntityStaging fd
	WHERE fd.FINANCIALDIMENSION='Department' and 
		fd.DIMENSIONVALUE=DimFinancialDimensions.DepartmentValue)

UPDATE DimFinancialDimensions
SET ProjectDescription=
	(SELECT DESCRIPTION
	FROM FinancialDimensionValueEntityStaging fd
	WHERE fd.FINANCIALDIMENSION='PROJECT' and 
		fd.DIMENSIONVALUE=DimFinancialDimensions.ProjectValue)

UPDATE DimFinancialDimensions
SET TASKDescription=
	(SELECT DESCRIPTION
	FROM FinancialDimensionValueEntityStaging fd
	WHERE fd.FINANCIALDIMENSION='TASK' and 
		fd.DIMENSIONVALUE=DimFinancialDimensions.TaskValue)

UPDATE DimFinancialDimensions
SET LegalEntityDescription=
	(SELECT DESCRIPTION
	FROM FinancialDimensionValueEntityStaging fd
	WHERE fd.FINANCIALDIMENSION='LegalEntity' and 
		fd.DIMENSIONVALUE=DimFinancialDimensions.LegalEntityValue)