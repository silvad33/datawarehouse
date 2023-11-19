--EXECUTE [dbo].[spAdaptiveImportCapital] '2021 Budget Pass 5', '1/1/2021', '12/31/2021',''
--SELECT * FROM tmpExpenseInputCapitalFile
--SELECT * FROM [financial].Capital


/*
Purpose: Given an Adaptive Version Name, Scenario and SubScenario Name and Version Year, pull Adaptive data
         from blob storage and merge it to FactTransaction
NOTE: Due to error 'You do not have permission to use the bulk load statement' caused by inability for non-sysadmin to bulk insert to temp
      tables, converting temp tables to permanent tables even though dropped and created only for this import
*/
CREATE PROCEDURE [dbo].[spAdaptiveImportCapital]
  @VersionName VARCHAR(500), --Name of Version in Adaptive 
  @ScenarioStart AS DATE,
  @ScenarioEnd AS DATE,
  @ReturnData NVARCHAR(MAX) OUTPUT
AS

DROP TABLE IF EXISTS tmpExpenseInputCapitalFile;

--TO DO: Elegant way to handle period names to date
DECLARE @ScenarioYear CHAR(4)
DECLARE @Per1 VARCHAR(15), @Per2 VARCHAR(15), @Per3 VARCHAR(15), @Per4 VARCHAR(15), @Per5 VARCHAR(15), @Per6 VARCHAR(15)
DECLARE @Per7 VARCHAR(15), @Per8 VARCHAR(15), @Per9 VARCHAR(15), @Per10 VARCHAR(15), @Per11 VARCHAR(15), @Per12 VARCHAR(15)

SET @ScenarioYear = DATEPART(YEAR,@ScenarioEnd)


--Variables for Blob files
DECLARE @EIF VARCHAR(500)
DECLARE @FileStore VARCHAR(50)
DECLARE @DataSourceName VARCHAR(50)
DECLARE @FileBase VARCHAR(500)
DECLARE @TransactionDescription AS VARCHAR(50)
DECLARE @CRLF CHAR(2)

SET @FileBase = CONCAT('Staging/',@VersionName)
SET @EIF = CONCAT(@FileBase,'_Capital.csv')
SET @FileStore = 'ionis'
SET @DataSourceName = 'azure_finance_adaptive'
SET @TransactionDescription = 'Adaptive ' + @VersionName
SET @CRLF = CHAR(13) + CHAR(10)

--Create temp table to hold staged Expense Input File data
CREATE TABLE tmpExpenseInputCapitalFile (
	InternalID CHAR(10) NOT NULL,
	LevelName VARCHAR(100) NOT NULL,
  	CapitalID VARCHAR(50) NOT NULL,
  	Account VARCHAR(100) NOT NULL,
	Project VARCHAR(50),
	Task VARCHAR(50),
	Supplier VARCHAR(100),
	CaseName VARCHAR(100),
	Prioritization VARCHAR(100),
	[Description] VARCHAR(500),
	[Notes] VARCHAR(MAX),
  	Amount FLOAT,
  	PurchaseDate DATE,
  	InServiceDate DATE,
  	EULOverride VARCHAR(500)
)

--BULK INSERT CSV to STAGING TABLE
DECLARE @BulkInsertSQL AS NVARCHAR(MAX)
SET @BulkInsertSQL = CONCAT('BULK INSERT tmpExpenseInputCapitalFile FROM ''', @EIF, ''' WITH (DATA_SOURCE = ''', @DataSourceName,''', FORMAT = ''CSV'', FIRSTROW = 2, ROWTERMINATOR = ''0x0a'')')
PRINT @BulkInsertSQL
EXECUTE sp_executesql @BulkInsertSQL
SET @ReturnData = CONCAT('EIF Rows - ',@@ROWCOUNT,@CRLF)

;WITH Capital(InternalID, EntityKey, DepartmentKey, CapitalID,
	AccountKey, ProjectKey, TaskKey, SupplierKey, CaseName,
    Prioritization, [Description], Notes, Amount, PurchaseDate,
    InServiceDate, EULOverride
)
AS
(
	SELECT InternalID, EntityKey, DepartmentKey, CapitalID,
		AccountKey, ProjectKey, TaskKey, SupplierKey, CaseName,
    	Prioritization, [Description], Notes, Amount, PurchaseDate,
    	InServiceDate, EULOverride
	FROM [financial].[Capital]
)
,AdaptiveCapital(InternalID, EntityKey, DepartmentKey, CapitalID,
	AccountKey, ProjectKey, TaskKey, SupplierKey, CaseName,
    Prioritization, [Description], Notes, Amount, PurchaseDate,
    InServiceDate, EULOverride
)
AS
(
	SELECT
		CAP.InternalID,
		E.EntityKey,
		D.DepartmentKey,
		CAP.CapitalID,
		A.AccountKey,
		P.ProjectKey,
		T.TaskKey,
		S.SupplierKey,
		CAP.CaseName,
		CAP.Prioritization,
		CAP.[Description],
		CAP.Notes,
		CAP.Amount,
		CAP.PurchaseDate,
		CAP.InServiceDate,
		CAP.EULOverride
	FROM (
	SELECT 
		InternalID,
		RIGHT(LevelName,4) AS EntityID,
		LEFT(LevelName,3) AS DepartmentNumber,
		CapitalID,
		LEFT(Account,4) AS AccountNumber,
		ISNULL(LEFT(Project,3),'000') AS ProjectNumber,
		ISNULL(LEFT(Task,3),'000') AS TaskNumber,
		ISNULL(LEFT(Supplier,9),'') AS SupplierNumber,
		CaseName,
		Prioritization,
		[Description],
		Notes,
		Amount,
		PurchaseDate,
		InServiceDate,
		EULOverride
	FROM tmpExpenseInputCapitalFile) AS CAP
		INNER JOIN DimEntity AS E ON CAP.EntityID = E.EntityID
		INNER JOIN DimDepartment AS D ON CAP.DepartmentNumber = D.DepartmentNumber
		INNER JOIN DimAccount AS A ON CAP.AccountNumber = A.MainAccountNumber
		INNER JOIN DimProject AS P ON CAP.ProjectNumber = P.ProjectNumber AND CAP.EntityID = P.DataAreaID
		INNER JOIN DimTask AS T ON CAP.TaskNumber = T.TaskNumber AND CAP.EntityID = T.DataAreaID
		LEFT OUTER JOIN DimSupplier AS S ON CAP.SupplierNumber = S.D365SupplierID
)
MERGE Capital AS C
USING AdaptiveCapital AS A
ON (C.InternalID = A.InternalID)
WHEN MATCHED
	THEN UPDATE
	SET C.EntityKey = A.EntityKey,
		C.DepartmentKey = A.DepartmentKey,
		C.CapitalID = A.CapitalID,
		C.AccountKey = A.AccountKey,
		C.ProjectKey = A.ProjectKey,
		C.TaskKey = A.TaskKey,
		C.SupplierKey = A.SupplierKey,
		C.CaseName = A.CaseName,
		C.Prioritization = A.Prioritization,
		C.[Description] = A.[Description],
		C.Notes = A.Notes,
		C.Amount = A.Amount,
		C.PurchaseDate = A.PurchaseDate,
		C.InServiceDate = A.InServiceDate,
		C.EULOverride = A.EULOverride
WHEN NOT MATCHED BY TARGET
	THEN INSERT (InternalID, EntityKey, DepartmentKey, CapitalID,
		AccountKey, ProjectKey, TaskKey, SupplierKey, CaseName,
    	Prioritization, [Description], Notes, Amount, PurchaseDate,
    	InServiceDate, EULOverride)
	VALUES (A.InternalID, A.EntityKey, A.DepartmentKey, A.CapitalID,
		A.AccountKey, A.ProjectKey, A.TaskKey, A.SupplierKey, A.CaseName,
    	A.Prioritization, A.[Description], A.Notes, A.Amount, A.PurchaseDate,
    	A.InServiceDate, A.EULOverride)
WHEN NOT MATCHED BY SOURCE
	THEN DELETE;
SET @ReturnData = CONCAT(@ReturnData,'Facts - ',@@ROWCOUNT)

DROP TABLE tmpExpenseInputCapitalFile;

RETURN 0