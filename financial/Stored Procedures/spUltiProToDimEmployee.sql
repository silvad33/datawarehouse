CREATE PROCEDURE [financial].[spUltiProToDimEmployee]
AS
/*
DROP TABLE IF EXISTS ztmpRLCDimEmployee_Stage;

DECLARE @xmlJobs XML
SELECT @xmlJobs=X.BulkColumn
FROM OPENROWSET(
    BULK 'Staging/ActiveEmployeeJobs.xml',
    DATA_SOURCE = 'azure_finance_adaptive'
    , SINGLE_CLOB
    --,FORMAT = 'XML'--, FIRSTROW = 2, ROWTERMINATOR = '0x0a'
) AS X;

DECLARE @xmlEmployment XML
SELECT @xmlEmployment=X.BulkColumn
FROM OPENROWSET(
    BULK 'Staging/ActiveEmployeesEmployment.xml',
    DATA_SOURCE = 'azure_finance_adaptive'
    , SINGLE_CLOB
    --,FORMAT = 'XML'--, FIRSTROW = 2, ROWTERMINATOR = '0x0a'
) AS X;

DECLARE @xmlPerson XML
SELECT @xmlPerson=X.BulkColumn
FROM OPENROWSET(
    BULK 'Staging/ActiveEmployeePerson.xml',
    DATA_SOURCE = 'azure_finance_adaptive'
    , SINGLE_CLOB
    --,FORMAT = 'XML'--, FIRSTROW = 2, ROWTERMINATOR = '0x0a'
) AS X;

SELECT CompanyCode, EmployeeNumber, SupervisorCompanyCode, SupervisorEmployeeNumber
    , Department, FirstName, LastName, JobCode, EmploymentStatus
    , ScheduledHours, JobTitle, StatusStartDate, OriginalHireDate
    , LastHireDate, FullOrPartTime, EmployeeType
    , RowHash
INTO ztmpRLCDimEmployee_Stage
FROM (
    SELECT JOBS.CompanyCode, JOBS.EmployeeNumber, JOBS.SupervisorCompanyCode, JOBS.SupervisorEmployeeNumber
        , JOBS.Department
        , CASE WHEN ISNULL(PERSON.PreferredFirstName,'') = '' THEN JOBS.FirstName ELSE PERSON.PreferredFirstName END AS FirstName
        , JOBS.LastName, EMPLOYMENT.JobCode, EMPLOYMENT.EmploymentStatus
        , JOBS.ScheduledHours, JOBS.JobTitle, EMPLOYMENT.StatusStartDate, EMPLOYMENT.OriginalHireDate
        , EMPLOYMENT.LastHireDate, JOBS.FullOrPartTime, JOBS.EmployeeType
        , HASHBYTES('MD5',CONCAT(JOBS.CompanyCode, JOBS.EmployeeNumber, JOBS.SupervisorCompanyCode, JOBS.SupervisorEmployeeNumber
                    , JOBS.Department, JOBS.FirstName, JOBS.LastName, EMPLOYMENT.JobCode, EMPLOYMENT.EmploymentStatus
                    , JOBS.ScheduledHours, JOBS.JobTitle, EMPLOYMENT.StatusStartDate, EMPLOYMENT.OriginalHireDate
                    , EMPLOYMENT.LastHireDate, JOBS.FullOrPartTime, JOBS.EmployeeType)) AS RowHash
        , ROW_NUMBER() OVER (
                            PARTITION BY JOBS.CompanyCode, JOBS.EmployeeNumber
                            ORDER BY EMPLOYMENT.EmploymentStatus DESC
                            ) AS RowNumber
    FROM (
        SELECT node.dt.value('CompanyCode[1]','VARCHAR(5)') AS CompanyCode
            , node.dt.value('EmployeeNumber[1]','CHAR(5)') AS EmployeeNumber
            , node.dt.value('FirstName[1]','VARCHAR(50)') AS FirstName
            , node.dt.value('LastName[1]','VARCHAR(50)') AS LastName
            , node.dt.value('Jobs[1]/Job[1]/AlternateTitle[1]','VARCHAR(50)') AS JobTitle
            , node.dt.value('Jobs[1]/Job[1]/EmployeeType[1]','VARCHAR(50)') AS EmployeeType
            , node.dt.value('Jobs[1]/Job[1]/FullOrPartTime[1]','CHAR(1)') AS FullOrPartTime
            , node.dt.value('Jobs[1]/Job[1]/JobCode[1]','VARCHAR(50)') AS JobCode
            , node.dt.value('Jobs[1]/Job[1]/OrgLevel1[1]','VARCHAR(50)') AS OrgLevel1
            , node.dt.value('Jobs[1]/Job[1]/OrgLevel2[1]','VARCHAR(50)') AS Department
            , node.dt.value('Jobs[1]/Job[1]/OrgLevel3[1]','VARCHAR(50)') AS OrgLevel3
            , node.dt.value('Jobs[1]/Job[1]/OrgLevel4[1]','VARCHAR(50)') AS OrgLevel4
            , node.dt.value('Jobs[1]/Job[1]/ScheduledHours[1]','FLOAT') AS ScheduledHours
            , node.dt.value('Jobs[1]/Job[1]/Supervisor[1]/CompanyCode[1]','VARCHAR(5)') AS SupervisorCompanyCode
            , node.dt.value('Jobs[1]/Job[1]/Supervisor[1]/EmployeeNumber[1]','CHAR(5)') AS SupervisorEmployeeNumber
        --node.dt.value('@CompanyCode','VARCHAR(20)')
        FROM @xmlJobs.nodes('/Results/EmployeeJob') node(dt)
    ) AS JOBS INNER JOIN (
        SELECT node.dt.value('CompanyCode[1]','VARCHAR(5)') AS CompanyCode
            , node.dt.value('EmployeeNumber[1]','CHAR(5)') AS EmployeeNumber
            , node.dt.value('EmploymentInformations[1]/EmploymentInformation[1]/EmploymentStatus[1]','CHAR(1)') AS EmploymentStatus
            , node.dt.value('EmploymentInformations[1]/EmploymentInformation[1]/Job[1]','VARCHAR(50)') AS JobCode
            , node.dt.value('EmploymentInformations[1]/EmploymentInformation[1]/LastHire[1]','DATE') AS LastHireDate
            , node.dt.value('EmploymentInformations[1]/EmploymentInformation[1]/OriginalHire[1]','DATE') AS OriginalHireDate
            , node.dt.value('EmploymentInformations[1]/EmploymentInformation[1]/StatusStartDate[1]','DATE') AS StatusStartDate
        --node.dt.value('@CompanyCode','VARCHAR(20)')
        FROM @xmlEmployment.nodes('/Results/EmployeeEmploymentInformation') node(dt)
    ) AS EMPLOYMENT ON JOBS.EmployeeNumber = EMPLOYMENT.EmployeeNumber AND JOBS.CompanyCode = EMPLOYMENT.CompanyCode
      INNER JOIN (
        SELECT node.dt.value('CompanyCode[1]','VARCHAR(5)') AS CompanyCode
            , node.dt.value('EmployeeNumber[1]','CHAR(5)') AS EmployeeNumber
            , node.dt.value('People[1]/Person[1]/PreferredFirstName[1]','VARCHAR(50)') AS PreferredFirstName
        --node.dt.value('@CompanyCode','VARCHAR(20)')
        FROM @xmlPerson.nodes('/Results/EmployeePerson') node(dt)
      ) AS PERSON ON JOBS.EmployeeNumber = PERSON.EmployeeNumber AND JOBS.CompanyCode = PERSON.CompanyCode
) AS QRY
WHERE RowNumber = 1

INSERT INTO financial.DimEmployee (
    CompanyCode, EmployeeNumber, SupervisorCompanyCode, SupervisorEmployeeNumber
    , Department, FirstName, LastName, JobCode, EmploymentStatus
    , ScheduledHours, JobTitle, StatusStartDate, OriginalHireDate
    , LastHireDate, FullOrPartTime, EmployeeType
    , RowHash, EFF_START_DT
)
SELECT CompanyCode, EmployeeNumber, SupervisorCompanyCode, SupervisorEmployeeNumber
    , Department, FirstName, LastName, JobCode, EmploymentStatus
    , ScheduledHours, JobTitle, StatusStartDate, OriginalHireDate
    , LastHireDate, FullOrPartTime, EmployeeType
    , RowHash, GETDATE()
FROM (
    MERGE financial.DimEmployee AS TARGET
    USING (
        SELECT CompanyCode, EmployeeNumber, SupervisorCompanyCode, SupervisorEmployeeNumber
        , Department, FirstName, LastName, JobCode, EmploymentStatus
        , ScheduledHours, JobTitle, StatusStartDate, OriginalHireDate
        , LastHireDate, FullOrPartTime, EmployeeType
        , RowHash
        FROM ztmpRLCDimEmployee_Stage
        ) AS SOURCE
    ON (TARGET.CompanyCode = SOURCE.CompanyCode AND TARGET.EmployeeNumber = SOURCE.EmployeeNumber AND TARGET.EFF_END_DT IS NULL)
    WHEN MATCHED AND TARGET.RowHash <> SOURCE.RowHash THEN
        UPDATE SET TARGET.EFF_END_DT = GETDATE()
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (
            CompanyCode, EmployeeNumber, SupervisorCompanyCode, SupervisorEmployeeNumber
            , Department, FirstName, LastName, JobCode, EmploymentStatus
            , ScheduledHours, JobTitle, StatusStartDate, OriginalHireDate
            , LastHireDate, FullOrPartTime, EmployeeType
            , RowHash, EFF_START_DT
        )
        VALUES (
            SOURCE.CompanyCode, SOURCE.EmployeeNumber, SOURCE.SupervisorCompanyCode, SOURCE.SupervisorEmployeeNumber
            , SOURCE.Department, SOURCE.FirstName, SOURCE.LastName, SOURCE.JobCode, SOURCE.EmploymentStatus
            , SOURCE.ScheduledHours, SOURCE.JobTitle, SOURCE.StatusStartDate, SOURCE.OriginalHireDate
            , SOURCE.LastHireDate, SOURCE.FullOrPartTime, SOURCE.EmployeeType
            , SOURCE.RowHash, GETDATE()
        )
    OUTPUT $Action, SOURCE.*, GETDATE()
) AS i([Action], CompanyCode, EmployeeNumber, SupervisorCompanyCode, SupervisorEmployeeNumber
            , Department, FirstName, LastName, JobCode, EmploymentStatus
            , ScheduledHours, JobTitle, StatusStartDate, OriginalHireDate
            , LastHireDate, FullOrPartTime, EmployeeType
            , RowHash, EFF_END_DT)
WHERE [Action] = 'UPDATE'

DROP TABLE ztmpRLCDimEmployee_Stage;

/*
select *
from ztmpRLCDimEmployee
where EmployeeNumber = '80152'

select distinct(CompanyCode)
from ztmpRLCDimEmployee

truncate table ztmpRLCDimEmployee

UPDATE ztmpRLCDimEmployee
SET EFF_START_DT = '1/1/2019'
*/
*/
RETURN 0