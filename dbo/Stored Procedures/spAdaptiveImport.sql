/*
Purpose: Given an Adaptive Version Name, Scenario and SubScenario Name and Version Year, pull Adaptive data
         from blob storage and merge it to FactTransaction
NOTE: Due to error 'You do not have permission to use the bulk load statement' caused by inability for non-sysadmin to bulk insert to temp
      tables, converting temp tables to permanent tables even though dropped and created only for this import
*/
CREATE PROCEDURE [dbo].[spAdaptiveImport]
  @VersionName VARCHAR(500), --Name of Version in Adaptive 
  @ScenarioName AS VARCHAR(50),
  @SubScenarioName AS VARCHAR(50),
  @ScenarioStart AS DATE,
  @ScenarioEnd AS DATE,
  @ReturnData NVARCHAR(MAX) OUTPUT
AS

DROP TABLE IF EXISTS tmpExpenseInputFile;
DROP TABLE IF EXISTS tmpDataExportFile;
DROP TABLE IF EXISTS tmpMergeData;

--TO DO: Elegant way to handle period names to date
DECLARE @ScenarioYear CHAR(4)
DECLARE @Per1 VARCHAR(15), @Per2 VARCHAR(15), @Per3 VARCHAR(15), @Per4 VARCHAR(15), @Per5 VARCHAR(15), @Per6 VARCHAR(15)
DECLARE @Per7 VARCHAR(15), @Per8 VARCHAR(15), @Per9 VARCHAR(15), @Per10 VARCHAR(15), @Per11 VARCHAR(15), @Per12 VARCHAR(15)

SET @ScenarioYear = DATEPART(YEAR,@ScenarioEnd)
SET @Per1 = '01/01/' + @ScenarioYear
SET @Per2 = '02/01/' + @ScenarioYear
SET @Per3 = '03/01/' + @ScenarioYear
SET @Per4 = '04/01/' + @ScenarioYear
SET @Per5 = '05/01/' + @ScenarioYear
SET @Per6 = '06/01/' + @ScenarioYear
SET @Per7 = '07/01/' + @ScenarioYear
SET @Per8 = '08/01/' + @ScenarioYear
SET @Per9 = '09/01/' + @ScenarioYear
SET @Per10 = '10/01/' + @ScenarioYear
SET @Per11 = '11/01/' + @ScenarioYear
SET @Per12 = '12/01/' + @ScenarioYear

--Variables for Blob files
DECLARE @EIF VARCHAR(500), @DEF VARCHAR(500)
DECLARE @FileStore VARCHAR(50)
DECLARE @DataSourceName VARCHAR(50)
DECLARE @FileBase VARCHAR(500)
DECLARE @TransactionDescription AS VARCHAR(500)
DECLARE @CRLF CHAR(2)

SET @FileBase = CONCAT('Staging/',@VersionName)
SET @EIF = CONCAT(@FileBase,'_EIF.csv')
SET @DEF = CONCAT(@FileBase,'_DEF.csv')
SET @FileStore = 'ionis'
SET @DataSourceName = 'azure_finance_adaptive'
SET @TransactionDescription = 'Adaptive ' + @VersionName
SET @CRLF = CHAR(13) + CHAR(10)

--Create temp table to hold staged Expense Input File data
CREATE TABLE tmpExpenseInputFile (
	InternalID CHAR(10) NOT NULL,
	LevelName VARCHAR(100) NOT NULL,
	Entity VARCHAR(100) NOT NULL,
	GeographyName VARCHAR(100),
	InternalPL VARCHAR(100),
	ManagementLevel VARCHAR(100),
	ControllableCorporate VARCHAR(100),
	AccountName VARCHAR(500) NOT NULL,
	Project VARCHAR(50),
	Task VARCHAR(50),
	Supplier VARCHAR(100),
	CaseName VARCHAR(100),
	Prioritization VARCHAR(100),
	[Description] VARCHAR(500),
	[Notes] VARCHAR(MAX),
	[StartDate] VARCHAR(50),
	[EndDate] VARCHAR(50),
	[PONumber] VARCHAR(50),
	[TotalStudyCost] VARCHAR(50),
	[Instructions] VARCHAR(50),
	Per1 FLOAT,
	Per2 FLOAT,
	Per3 FLOAT,
	Q1 FLOAT,
	Per4 FLOAT,
	Per5 FLOAT,
	Per6 FLOAT,
	Q2 FLOAT,
	Per7 FLOAT,
	Per8 FLOAT,
	Per9 FLOAT,
	Q3 FLOAT,
	Per10 FLOAT,
	Per11 FLOAT,
	Per12 FLOAT,
	Q4 FLOAT,
	[Year] FLOAT
)

--BULK INSERT CSV to STAGING TABLE
DECLARE @BulkInsertSQL AS NVARCHAR(MAX)
SET @BulkInsertSQL = CONCAT('BULK INSERT tmpExpenseInputFile FROM ''', @EIF, ''' WITH (DATA_SOURCE = ''', @DataSourceName,''', FORMAT = ''CSV'', FIRSTROW = 2, ROWTERMINATOR = ''0x0a'')')
PRINT @BulkInsertSQL
EXECUTE sp_executesql @BulkInsertSQL
SET @ReturnData = CONCAT('EIF Rows - ',@@ROWCOUNT,@CRLF)

CREATE TABLE tmpDataExportFile (
	AccountName VARCHAR(500) NOT NULL,
	AccountCode VARCHAR(50) NOT NULL,
	LevelName VARCHAR(100) NOT NULL,
	Project VARCHAR(50),
	Task VARCHAR(50),
	[Case] VARCHAR(50),
	Per1 FLOAT,
	Per2 FLOAT,
	Per3 FLOAT,
	Per4 FLOAT,
	Per5 FLOAT,
	Per6 FLOAT,
	Per7 FLOAT,
	Per8 FLOAT,
	Per9 FLOAT,
	Per10 FLOAT,
	Per11 FLOAT,
	Per12 FLOAT
)
SET @BulkInsertSQL = CONCAT('BULK INSERT tmpDataExportFile FROM ''', @DEF, ''' WITH (DATA_SOURCE = ''', @DataSourceName,''', FORMAT = ''CSV'', FIRSTROW = 2, ROWTERMINATOR = ''0x0a'')')
PRINT @BulkInsertSQL
EXECUTE sp_executesql @BulkInsertSQL
SET @ReturnData = CONCAT(@ReturnData,'DEF Row - ',@@ROWCOUNT,@CRLF)

--DO SOME IN-PLACE CLEAN UP
UPDATE tmpDataExportFile
SET Project = '000 - General Admin'
WHERE Project = 'Project' OR Project='000'

UPDATE tmpDataExportFile
SET Task = '000 - GENERAL'
WHERE Task = 'Task' OR Task='000'

--Create a merge table to merge Expense Input data through the Version's window with the Data Export data to fill in the rest
CREATE TABLE tmpMergeData (
	AccountDisplayValue VARCHAR(100) NOT NULL,
	LevelName VARCHAR(100) NOT NULL,
	AccountName VARCHAR(500) NOT NULL,
	Project VARCHAR(50),
	Task VARCHAR(50),
	Voucher VARCHAR(50),
	[Description] VARCHAR(500),
	[Notes] VARCHAR(500),
	Per1 FLOAT,
	Per2 FLOAT,
	Per3 FLOAT,
	Per4 FLOAT,
	Per5 FLOAT,
	Per6 FLOAT,
	Per7 FLOAT,
	Per8 FLOAT,
	Per9 FLOAT,
	Per10 FLOAT,
	Per11 FLOAT,
	Per12 FLOAT
)

--For Expense Input use only the periods that apply for a given version
DECLARE @Per1Mult INT, @Per2Mult INT, @Per3Mult INT, @Per4Mult INT, @Per5Mult INT, @Per6Mult INT,
	    @Per7Mult INT, @Per8Mult INT, @Per9Mult INT, @Per10Mult INT, @Per11Mult INT, @Per12Mult INT
SET @Per1Mult = CASE WHEN @Per1 >= @ScenarioStart THEN 1 ELSE 0 END
SET @Per2Mult = CASE WHEN @Per2 >= @ScenarioStart THEN 1 ELSE 0 END
SET @Per3Mult = CASE WHEN @Per3 >= @ScenarioStart THEN 1 ELSE 0 END
SET @Per4Mult = CASE WHEN @Per4 >= @ScenarioStart THEN 1 ELSE 0 END
SET @Per5Mult = CASE WHEN @Per5 >= @ScenarioStart THEN 1 ELSE 0 END
SET @Per6Mult = CASE WHEN @Per6 >= @ScenarioStart THEN 1 ELSE 0 END
SET @Per7Mult = CASE WHEN @Per7 >= @ScenarioStart THEN 1 ELSE 0 END
SET @Per8Mult = CASE WHEN @Per8 >= @ScenarioStart THEN 1 ELSE 0 END
SET @Per9Mult = CASE WHEN @Per9 >= @ScenarioStart THEN 1 ELSE 0 END
SET @Per10Mult = CASE WHEN @Per10 >= @ScenarioStart THEN 1 ELSE 0 END
SET @Per11Mult = CASE WHEN @Per11 >= @ScenarioStart THEN 1 ELSE 0 END
SET @Per12Mult = CASE WHEN @Per12 >= @ScenarioStart THEN 1 ELSE 0 END

INSERT INTO tmpMergeData (AccountDisplayValue, LevelName, AccountName, 
                         Project, Task, Voucher, [Description], [Notes],
						 Per1, Per2, Per3, Per4, Per5, Per6,
						 Per7, Per8, Per9, Per10, Per11, Per12)
SELECT CONCAT(LEFT(Entity,4),'-',LEFT(LevelName,3),'-',LEFT(AccountName,4),'-',LEFT(Project,3),'-',LEFT(Task,3)), LevelName, AccountName, 
       Project, Task, InternalID AS Voucher, LEFT(ISNULL([Description],''),500) AS [Description],
	   LEFT(ISNULL([Notes],''),500) AS [Notes],
	   ISNULL(Per1,0) * @Per1Mult, ISNULL(Per2,0) * @Per2Mult, ISNULL(Per3,0) * @Per3Mult,
	   ISNULL(Per4,0) * @Per4Mult, ISNULL(Per5,0) * @Per5Mult, ISNULL(Per6,0) * @Per6Mult,
	   ISNULL(Per7,0) * @Per7Mult, ISNULL(Per8,0) * @Per8Mult, ISNULL(Per9,0) * @Per9Mult,
	   ISNULL(Per10,0) * @Per10Mult, ISNULL(Per11,0) * @Per11Mult, ISNULL(Per12,0) * @Per12Mult
FROM tmpExpenseInputFile
WHERE ISNULL(CaseName,'') = '' OR ISNULL(CaseName,'') = 'Base' OR ISNULL(CaseName,'') = 'Case'
SET @ReturnData = CONCAT(@ReturnData,'EIF Merged - ',@@ROWCOUNT,@CRLF)

--For Data Export file, join to merged data and subtract out Expense Input data for periods in the Expense Input window
INSERT INTO tmpMergeData (AccountDisplayValue, LevelName, AccountName, 
                         Project, Task, Voucher, [Description], [NOTES],
						 Per1, Per2, Per3, Per4, Per5, Per6,
						 Per7, Per8, Per9, Per10, Per11, Per12)
SELECT CONCAT(RIGHT(DEF.LevelName,4),'-',LEFT(DEF.LevelName,3),'-',LEFT(DEF.AccountName,4),'-',LEFT(DEF.Project,3),'-',LEFT(DEF.Task,3)), DEF.LevelName, DEF.AccountName, 
       DEF.Project, DEF.Task, @VersionName AS Voucher, 'Adaptive Data Export' AS [Description], 'Adaptive data export' AS [Notes],
	   (DEF.Per1 - ISNULL(EIF.Per1,0)) AS Per1, (DEF.Per2 - ISNULL(EIF.Per2,0)) AS Per2, (DEF.Per3 - ISNULL(EIF.Per3,0)) AS Per3, 
	   (DEF.Per4 - ISNULL(EIF.Per4,0)) AS Per4, (DEF.Per5 - ISNULL(EIF.Per5,0)) AS Per5, (DEF.Per6 - ISNULL(EIF.Per6,0)) AS Per6,
	   (DEF.Per7 - ISNULL(EIF.Per7,0)) AS Per7, (DEF.Per8 - ISNULL(EIF.Per8,0)) AS Per8, (DEF.Per9 - ISNULL(EIF.Per9,0)) AS Per9,
	   (DEF.Per10 - ISNULL(EIF.Per10,0)) AS Per10, (DEF.Per11 - ISNULL(EIF.Per11,0)) AS Per11, (DEF.Per12 - ISNULL(EIF.Per12,0)) AS Per12
FROM (
		SELECT AccountName, AccountCode, LevelName, Project, Task,
			   SUM(Per1) AS Per1, SUM(Per2) AS Per2, SUM(Per3) AS Per3, SUM(Per4) AS Per4, SUM(Per5) AS Per5, SUM(Per6) AS Per6,
			   SUM(Per7) AS Per7, SUM(Per8) AS Per8, SUM(Per9) AS Per9, SUM(Per10) AS Per10, SUM(Per11) AS Per11, SUM(Per12) AS Per12
		FROM tmpDataExportFile
		WHERE ISNULL([Case],'') = '' OR ISNULL([Case],'') = 'Base' OR ISNULL([Case],'') = 'Case'
		GROUP BY AccountName, AccountCode, LevelName, Project, Task
	 ) AS DEF
  LEFT OUTER JOIN (
	  SELECT AccountDisplayValue, SUM(ISNULL(Per1,0)) AS Per1, SUM(ISNULL(Per2,0)) AS Per2, SUM(ISNULL(Per3,0)) AS Per3,
	         SUM(ISNULL(Per4,0)) AS Per4, SUM(ISNULL(Per5,0)) AS Per5, SUM(ISNULL(Per6,0)) AS Per6,
			 SUM(ISNULL(Per7,0)) AS Per7, SUM(ISNULL(Per8,0)) AS Per8, SUM(ISNULL(Per9,0)) AS Per9,
			 SUM(ISNULL(Per10,0)) AS Per10, SUM(ISNULL(Per11,0)) AS Per11, SUM(ISNULL(Per12,0)) AS Per12
		FROM tmpMergeData
		GROUP BY AccountDisplayValue
  		) AS EIF ON CONCAT(RIGHT(DEF.LevelName,4),'-',LEFT(DEF.LevelName,3),'-',LEFT(DEF.AccountName,4),'-',LEFT(DEF.Project,3),'-',LEFT(DEF.Task,3)) = EIF.AccountDisplayValue
SET @ReturnData = CONCAT(@ReturnData,'DEF Merged - ',@@ROWCOUNT,@CRLF)

--Use Scenario and SubScenario to determine which value field to populate
--Create variables for each of the 5 planning values, set to 0, then based on scenario/subscenario assign 1 variable a value of 1
--During update multiply PeriodAmount by multipler (either 1 or 0) to generate value for each field
DECLARE @FCSTQ1Mult INT, @FCSTQ2Mult INT, @FCSTQ3Mult INT, @FCSTQ4Mult INT, @BudMult INT
SELECT @FCSTQ1Mult = 0, @FCSTQ2Mult = 0, @FCSTQ3Mult = 0, @FCSTQ4Mult = 0, @BudMult = 0
IF @ScenarioName = 'Budget'
	SET @BudMult = 1
ELSE IF @SubScenarioName = 'FCSTQ1' SET @FCSTQ1Mult = 1
ELSE IF @SubScenarioName = 'FCSTQ2' Set @FCSTQ2Mult = 1
ELSE IF @SubScenarioName = 'FCSTQ3' Set @FCSTQ3Mult = 1
ELSE IF @SubScenarioName = 'FCSTQ4' Set @FCSTQ4Mult = 1

;WITH FactTransactionScenario (AccountString, TransactionDate, Scenario, SubScenario,
		   					   Voucher, AccountKey, DepartmentKey, ProjectKey, TaskKey,
		   					   FiscalPeriodKey, EntityKey, FCastQ1Amount, FCastQ2Amount, FCastQ3Amount, FCastQ4Amount, BudgetAmount, RecID, [Partition],
		   					   [TransactionDescription], [PostingTypeDescription])
AS
(
	SELECT AccountString, TransactionDate, Scenario, SubScenario,
		   Voucher, AccountKey, DepartmentKey, ProjectKey, TaskKey,
		   FiscalPeriodKey, EntityKey, FCastQ1Amount, FCastQ2Amount, FCastQ3Amount, FCastQ4Amount, BudgetAmount, RecID, [Partition],
		   [TransactionDescription], [PostingTypeDescription]
	FROM FactTransaction
	WHERE Scenario = @ScenarioName
	  AND SubScenario = @SubScenarioName
	  AND (TransactionDate >= CONCAT('1/1/',@ScenarioYear) AND TransactionDate <= CONCAT('12/31/',@ScenarioYear))
)
,
AdaptiveSource (AccountString, TransactionDate, Scenario, SubScenario,
		   		Voucher, AccountKey, DepartmentKey, ProjectKey, TaskKey,
		   		FiscalPeriodKey, EntityKey, FCastQ1Amount, FCastQ2Amount, FCastQ3Amount, FCastQ4Amount,
				BudgetAmount, RecID, [Partition],
		   		[Description], [Notes])
AS
(
	SELECT CONCAT(LEFT(AD.AccountName,4),'-',LEFT(AD.LevelName,3),'-',LEFT(AD.Project,3),'-',LEFT(AD.Task,3)) AS AccountString,
		AD.PeriodDate AS TransactionDate,
		@ScenarioName AS Scenario,
		@SubScenarioName AS SubScenario,
		AD.Voucher AS Voucher,
		A.AccountKey,
		D.DepartmentKey,
		P.ProjectKey,
		T.TaskKey,
		C.FiscalPeriodKey,
		E.EntityKey,
		PeriodAmount * @FCSTQ1Mult AS [FCastQ1Amount],
		PeriodAmount * @FCSTQ2Mult AS [FCastQ2Amount],
		PeriodAmount * @FCSTQ3Mult AS [FCastQ3Amount],
		PeriodAmount * @FCSTQ4Mult AS [FCastQ4Amount],
		PeriodAmount * @BudMult AS [BudgetAmount],
		407+ROW_NUMBER() OVER(ORDER BY AD.AccountName) AS RecID,
		'initial' as [Partition],
		AD.[Description] AS [Description],
		AD.[NOTES] AS [Notes]
	FROM
	(SELECT AccountName, LevelName, Project, Task, Voucher, LEFT(ISNULL([Description],@TransactionDescription), 500) AS [Description], LEFT([NOTES], 500) AS [Notes],
				CASE PeriodName
					WHEN 'Per1' THEN @Per1
					WHEN 'Per2' THEN @Per2
					WHEN 'Per3' THEN @Per3
					WHEN 'Per4' THEN @Per4
					WHEN 'Per5' THEN @Per5
					WHEN 'Per6' THEN @Per6
					WHEN 'Per7' THEN @Per7
					WHEN 'Per8' THEN @Per8
					WHEN 'Per9' THEN @Per9
					WHEN 'Per10' THEN @Per10
					WHEN 'Per11' THEN @Per11
					WHEN 'Per12' THEN @Per12
					END AS PeriodDate,
					PeriodAmount
			FROM 
				(SELECT AccountName, LevelName, Project, Task, Voucher, [Description], [Notes], Per1, Per2, Per3, Per4, Per5, Per6, Per7, Per8, Per9, Per10, Per11, Per12
				FROM tmpMergeData) p
				UNPIVOT
				(PeriodAmount FOR PeriodName IN
					(Per1, Per2, Per3, Per4, Per5, Per6, Per7, Per8, Per9, Per10, Per11, Per12)
				) AS unpvt
			) AS AD
		INNER JOIN DimAccount AS A ON LEFT(AD.AccountName,4) = A.MainAccountNumber
		INNER JOIN DimDepartment AS D ON LEFT(AD.LevelName,3) = D.DepartmentNumber
		INNER JOIN DimEntity AS E ON RIGHT(AD.LevelName,4) = E.EntityID
		INNER JOIN DimProject AS P ON LEFT(AD.Project,3) = P.ProjectNumber AND E.EntityID = P.DataAreaID
		INNER JOIN DimTask AS T ON LEFT(AD.Task,3) = T.TaskNumber AND E.EntityID = T.DataAreaID
		INNER JOIN DimFinancialCalendar AS C ON DATEPART(day,AD.PeriodDate) = C.DayNumber
											AND DATEPART(month,AD.PeriodDate) = C.MonthNumer 
											AND DATEPART(year,AD.PeriodDate) = C.FiscalYear
											AND E.EntityKey = C.EntityKey
											AND C.Calendar = 'FISCAL'
	WHERE AD.LevelName <> 'Consolidated'
)
MERGE FactTransactionScenario AS T
USING AdaptiveSource AS S
ON (T.AccountString = S.AccountString
	AND T.TransactionDate = S.TransactionDate
	AND T.Scenario = S.Scenario
	AND T.SubScenario = S.SubScenario
	AND T.EntityKey = S.EntityKey
	AND T.Voucher = S.Voucher
	AND T.[TransactionDescription] = S.[Description])
WHEN MATCHED
	THEN UPDATE
	SET	T.FCastQ1Amount = S.FCastQ1Amount,
	    T.FCastQ2Amount = S.FCastQ2Amount,
		T.FCastQ3Amount = S.FCastQ3Amount,
		T.FCastQ4Amount = S.FCastQ4Amount,
		T.BudgetAmount = S.BudgetAmount,
		T.[TransactionDescription] = S.[Description],
		T.[PostingTypeDescription] = S.[Notes]
WHEN NOT MATCHED BY TARGET
	THEN INSERT (AccountString, TransactionDate, Scenario, SubScenario,
				 Voucher, AccountKey, DepartmentKey, ProjectKey, TaskKey, 
				 FiscalPeriodKey, EntityKey, FCastQ1Amount, FCastQ2Amount, FCastQ3Amount, FCastQ4Amount, BudgetAmount,
				 RecID, [Partition], [TransactionDescription], [PostingTypeDescription])
		VALUES (S.AccountString, S.TransactionDate, S.Scenario, S.SubScenario,
				S.Voucher, S.AccountKey, S.DepartmentKey, S.ProjectKey, S.TaskKey, 
				S.FiscalPeriodKey, S.EntityKey, S.FCastQ1Amount, S.FCastQ2Amount, S.FCastQ3Amount, S.FCastQ4Amount, S.BudgetAmount,
				S.RecID, S.[Partition], S.[Description], [Notes])
WHEN NOT MATCHED BY SOURCE
	THEN DELETE;
SET @ReturnData = CONCAT(@ReturnData,'Facts - ',@@ROWCOUNT)


DROP TABLE tmpExpenseInputFile;
DROP TABLE tmpDataExportFile;
DROP TABLE tmpMergeData;

RETURN 0