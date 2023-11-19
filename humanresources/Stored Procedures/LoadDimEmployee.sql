CREATE PROCEDURE humanresources.LoadDimEmployee (
    @currentAction VARCHAR(1000) OUTPUT
    , @returnCode INT OUTPUT
    , @returnMessage VARCHAR(1000) OUTPUT
    )
AS
BEGIN
    -- ***************DB Info ***************
    -- Description  : update the financial.DimEmployee table from the data lake. This data is sourced using UKG Rest APIs
    -- Notes        : This routine will be called every day and will only update the records that have had a change
    -- Contact      : Daniel Silva
    -- Date Created : 09/20/2021
    -- Change hist.	: 
    -- *************** /DB Info ***************
    DECLARE @pi_job_name VARCHAR(4000) = OBJECT_NAME(@@PROCID)
        , @po_job_hist_id INT
        , @po_min_update_date DATETIME
        , @po_max_update_date DATETIME
        , @po_min_id INT
        , @po_max_id INT

    EXECUTE spStartJob @pi_job_name
        , @po_job_hist_id OUTPUT
        , @po_min_update_date OUT
        , @po_max_update_date OUT
        , @po_min_id OUT
        , @po_max_id OUT;

    --Drop temp tables used in sproc
    DROP TABLE IF EXISTS #EmploymentDetails;
        SELECT @currentAction = 'Loading JSON data into a logical table structure'

    PRINT @currentAction

    CREATE TABLE #EmploymentDetails (
        [CompanyID] [varchar](20) NULL
        , [UltiproEmployeeID] [varchar](20) NULL
        , [FirstName] [varchar](100) NULL
        , [LastName] [varchar](100) NULL
        , [PrefferedName] [varchar](100) NULL
        , [FullName] [varchar](200) NULL
        , [Email] [varchar](100) NULL
        , [WorkPhone] [varchar](50) NULL
        , [CompanyCode] [varchar](15) NULL
        , [FTE] [int] NULL
        , [EmployeeNumber] [varchar](15) NULL
        , [SupervisorCompanyCode] [varchar](15) NULL
        , [SupervisorEmployeeNumber] [varchar](15) NULL
        -- , [ManagerKey] [int] NULL
        , [Department] [varchar](50) NULL
        , [DepartmentKey] [int] NULL
        , [WorkPlaceLocation] [varchar](15) NULL
        , [WorkPlaceName] [varchar](100) NULL
        , [StockLevelCode] [varchar](15) NULL
        , [JobCode] [varchar](50) NULL
        , [EmploymentStatus] [char](1) NULL
        , [Active] [int] NULL
        , [ExemptStatus] [varchar](3) NULL
        , [ScheduledHours] [float] NULL
        , [JobTitle] [varchar](250) NULL
        , [StatusStartDate] [date] NULL
        , [OriginalHireDate] [date] NULL
        , [LastHireDate] [date] NULL
        , [TerminationDate] [date] NULL
        , [FullOrPartTime] [char](1) NULL
        , [EmployeeType] [varchar](50) NULL
        , [SourceCreatedDate] [datetime] NULL
        , [SourceUpdatedDate] [datetime] NULL
        , [RowHash] [varbinary](8000) NULL
        )

    INSERT INTO #EmploymentDetails (
        CompanyID
        , UltiproEmployeeID
        , FirstName
        , LastName
        , PrefferedName
        , FullName
        , Email
        , WorkPhone
        , CompanyCode
        , FTE
        , EmployeeNumber
        , SupervisorCompanyCode
        , SupervisorEmployeeNumber
        -- , ManagerKey
        , Department
        , DepartmentKey
        , WorkPlaceLocation
        , WorkPlaceName
        , StockLevelCode
        , JobCode
        , EmploymentStatus
        , Active
        , ExemptStatus
        , ScheduledHours
        , JobTitle
        , StatusStartDate
        , OriginalHireDate
        , LastHireDate
        , TerminationDate
        , FullOrPartTime
        , EmployeeType
        , SourceCreatedDate
        , SourceUpdatedDate
        , RowHash
        )
    SELECT JSON_VALUE(j.jsonData, '$.companyID') AS CompanyID
        , JSON_VALUE(j.jsonData, '$.employeeID') AS UltiproEmployeeID
        , JSON_VALUE(j.jsonData, '$.firstName') AS FirstName
        , JSON_VALUE(j.jsonData, '$.lastName') AS LastName
        , JSON_VALUE(j.jsonData, '$.preferredName') AS PrefferedName
        , CONCAT (
            JSON_VALUE(j.jsonData, '$.firstName')
            , ' '
            , JSON_VALUE(j.jsonData, '$.lastName')
            ) AS FullName
        , JSON_VALUE(j.jsonData, '$.emailAddress') AS Email
        , JSON_VALUE(j.jsonData, '$.workPhoneNumber') AS WorkPhone
        , CASE 
            WHEN CHARINDEX('ionis', JSON_VALUE(j.jsonData, '$.emailAddress')) > 0
                AND TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) = 'TEMP'
                THEN 'IONS'
            WHEN CHARINDEX('akcea', JSON_VALUE(j.jsonData, '$.emailAddress')) > 0
                AND TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) = 'TEMP'
                THEN 'AKCEA'
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCCA', 'AKCCN')
                THEN 'AKCA'
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCCY')
                THEN 'AKCY'
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCDE', 'AKCGR')
                THEN 'AKDE'
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCSP', 'AKSE', 'AKSP', 'AKCSE')
                THEN 'AKES'
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCFR')
                THEN 'AKFR'
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCIE')
                THEN 'AKIE'
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCIT')
                THEN 'AKIT'
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCPT')
                THEN 'AKPT'
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCSC')
                THEN 'AKSC'
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCUK', 'AKDR', 'AKUK', 'AKCDR', 'AKCEA')
                THEN 'AKUK'
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCEM')
                THEN 'EAKC'
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('ISIS', 'ISIS2')
                THEN 'IONS'
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCCH')
                THEN 'AKCH'
            ELSE TRIM(JSON_VALUE(j.jsonData, '$.companyCode'))
            END AS CompanyCode
        , CASE 
            WHEN cast(JSON_VALUE(j.jsonData, '$.scheduledWorkHrs') AS DECIMAL(8, 2)) IN (80, 160, 86.670000)
                THEN 1
            WHEN JSON_VALUE(j.jsonData, '$.scheduledWorkHrs') IS NULL
                THEN NULL
            ELSE round(cast(JSON_VALUE(j.jsonData, '$.scheduledWorkHrs') AS DECIMAL(8, 2)) / 80, 2)
            END AS FTE
        , JSON_VALUE(j.jsonData, '$.employeeNumber') AS EmployeeNumber
        , JSON_VALUE(j.jsonData, '$.supervisorCompanyCode') AS SupervisorCompanyCode
        , JSON_VALUE(j.jsonData, '$.supervisorEmployeeNumber') AS SupervisorEmployeeNumber
        -- , DE.EmployeeKey AS ManagerKey
        , JSON_VALUE(j.jsonData, '$.orgLevel2Code') AS Department
        , dd.DepartmentKey
        , JSON_VALUE(j.jsonData, '$.mailstop') AS WorkPlaceLocation
        , JSON_VALUE(j.jsonData, '$.employeeAddress2') AS WorkPlaceName
        , [humanresources].[fnGetStockLevelCode](JSON_VALUE(j.jsonData, '$.jobDescription')) AS StockLevelCode
        , JSON_VALUE(j.jsonData, '$.primaryJobCode') AS JobCode
        , JSON_VALUE(j.jsonData, '$.employeeStatusCode') AS EmploymentStatus
        , CASE 
            WHEN TRIM(JSON_VALUE(j.jsonData, '$.employeeStatusCode')) IN ('A', 'L')
                THEN 1
            ELSE 0
            END AS Active
        , CASE 
            WHEN UPPER(JSON_VALUE(j.jsonData, '$.salaryOrHourly')) = 'S'
                THEN 'EX'
            ELSE 'NE'
            END AS ExemptStatus
        , round(JSON_VALUE(j.jsonData, '$.scheduledWorkHrs'), 2) AS ScheduledHours
        , JSON_VALUE(j.jsonData, '$.jobTitle') AS JobTitle
        , JSON_VALUE(j.jsonData, '$.statusStartDate') AS StatusStartDate
        , JSON_VALUE(j.jsonData, '$.originalHireDate') AS OriginalHireDate
        , JSON_VALUE(j.jsonData, '$.lastHireDate') AS LastHireDate
        , JSON_VALUE(j.jsonData, '$.terminationDate') AS TerminationDate
        , JSON_VALUE(j.jsonData, '$.fullTimeOrPartTimeCode') AS FullOrPartTime
        , JSON_VALUE(j.jsonData, '$.employeeTypeCode') AS EmployeeType
        , JSON_VALUE(j.jsonData, '$.dateTimeCreated') AS dateTimeCreated
        , JSON_VALUE(j.jsonData, '$.dateTimeChanged') AS dateTimeChanged
        , HASHBYTES('MD5', CONCAT (
                JSON_VALUE(j.jsonData, '$.companyID')
                , JSON_VALUE(j.jsonData, '$.employeeID')
                , JSON_VALUE(j.jsonData, '$.firstName')
                , JSON_VALUE(j.jsonData, '$.lastName')
                , JSON_VALUE(j.jsonData, '$.preferredName')
                , CONCAT (
                    JSON_VALUE(j.jsonData, '$.firstName')
                    , ' '
                    , JSON_VALUE(j.jsonData, '$.lastName')
                    )
                , JSON_VALUE(j.jsonData, '$.emailAddress')
                , JSON_VALUE(j.jsonData, '$.workPhoneNumber')
                , CASE 
                    WHEN CHARINDEX('ionis', JSON_VALUE(j.jsonData, '$.emailAddress')) > 0
                        AND TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) = 'TEMP'
                        THEN 'IONS'
                    WHEN CHARINDEX('akcea', JSON_VALUE(j.jsonData, '$.emailAddress')) > 0
                        AND TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) = 'TEMP'
                        THEN 'AKCEA'
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCCA', 'AKCCN')
                        THEN 'AKCA'
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCCY')
                        THEN 'AKCY'
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCDE', 'AKCGR')
                        THEN 'AKDE'
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCSP', 'AKSE', 'AKSP', 'AKCSE')
                        THEN 'AKES'
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCFR')
                        THEN 'AKFR'
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCIE')
                        THEN 'AKIE'
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCIT')
                        THEN 'AKIT'
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCPT')
                        THEN 'AKPT'
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCSC')
                        THEN 'AKSC'
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCUK', 'AKDR', 'AKUK', 'AKCDR', 'AKCEA')
                        THEN 'AKUK'
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCEM')
                        THEN 'EAKC'
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('ISIS', 'ISIS2')
                        THEN 'IONS'
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.companyCode')) IN ('AKCCH')
                        THEN 'AKCH'
                    ELSE TRIM(JSON_VALUE(j.jsonData, '$.companyCode'))
                    END
                , CASE 
                    WHEN cast(JSON_VALUE(j.jsonData, '$.scheduledWorkHrs') AS DECIMAL(8, 2)) IN (80, 160, 86.670000)
                        THEN 1
                    WHEN JSON_VALUE(j.jsonData, '$.scheduledWorkHrs') IS NULL
                        THEN NULL
                    ELSE cast(JSON_VALUE(j.jsonData, '$.scheduledWorkHrs') AS DECIMAL(8, 2)) / 80
                    END
                , JSON_VALUE(j.jsonData, '$.employeeNumber')
                , JSON_VALUE(j.jsonData, '$.supervisorCompanyCode')
                , JSON_VALUE(j.jsonData, '$.supervisorEmployeeNumber')
                -- , DE.EmployeeKey
                , JSON_VALUE(j.jsonData, '$.orgLevel2Code')
                , dd.DepartmentKey
                , JSON_VALUE(j.jsonData, '$.mailstop')
                , JSON_VALUE(j.jsonData, '$.employeeAddress2')
                , [humanresources].[fnGetStockLevelCode](JSON_VALUE(j.jsonData, '$.jobDescription'))
                , JSON_VALUE(j.jsonData, '$.primaryJobCode')
                , JSON_VALUE(j.jsonData, '$.employeeStatusCode')
                , CASE 
                    WHEN TRIM(JSON_VALUE(j.jsonData, '$.employeeStatusCode')) IN ('A', 'L')
                        THEN 1
                    ELSE 0
                    END
                , CASE 
                    WHEN UPPER(JSON_VALUE(j.jsonData, '$.salaryOrHourly')) = 'S'
                        THEN 'EX'
                    ELSE 'NE'
                    END
                , JSON_VALUE(j.jsonData, '$.scheduledWorkHrs')
                , JSON_VALUE(j.jsonData, '$.jobTitle')
                , JSON_VALUE(j.jsonData, '$.statusStartDate')
                , JSON_VALUE(j.jsonData, '$.originalHireDate')
                , JSON_VALUE(j.jsonData, '$.lastHireDate')
                , JSON_VALUE(j.jsonData, '$.terminationDate')
                , JSON_VALUE(j.jsonData, '$.fullTimeOrPartTimeCode')
                , JSON_VALUE(j.jsonData, '$.employeeTypeCode')
                , JSON_VALUE(j.jsonData, '$.dateTimeCreated')
                , JSON_VALUE(j.jsonData, '$.dateTimeChanged')
                )) AS RowHash
    FROM #Json j
    LEFT JOIN DimDepartment AS DD
        ON JSON_VALUE(j.jsonData, '$.orgLevel2Code') = dd.DepartmentNumber

    -- LEFT JOIN select max employeenumber from financial.DimEmployee AS DE
    -- ON JSON_VALUE(j.jsonData, '$.supervisorEmployeeNumber') = DE.EmployeeNumber
    SELECT @currentAction = 'Merge Records into DimEmployee';

    PRINT @currentAction;

    --DECLARE @Data_as_xml XML

    --SET @Data_as_xml = (
    --        SELECT *
    --        FROM #EmploymentDetails
    --        FOR XML PATH('')
    --        )

    --PRINT convert(VARCHAR(max), @Data_as_xml);

    WITH IOTARGET
    AS (
        SELECT *
        FROM [financial].[DimEmployee]
        WHERE [EFF_END_DT] IS NULL
        )
    MERGE IOTARGET AS [TRG]
    USING (
        SELECT *
        FROM #EmploymentDetails
        ) AS [SRC]
        ON 
                --[TRG].[SourceEmployeeId] = [SRC].[UltiproEmployeeID]
             [TRG].[EmployeeNumber] = [SRC].[EmployeeNumber]
            --AND [TRG].[CompanyID] = [SRC].[CompanyID]
            AND [TRG].[RowHash] <> [SRC].[RowHash]
    WHEN MATCHED
        THEN
            UPDATE
            SET [TRG].[EFF_END_DT] = GetDate()
                , [TRG].[AuditUpdatedAt] = GetDate()
                , [TRG].[AuditUpdatedBy] = CURRENT_USER
    OUTPUT 'DimEmployee'
        , CONVERT(VARCHAR, DELETED.[SourceEmployeeId])
        , $ACTION
        , CONVERT(VARCHAR, INSERTED.[SourceEmployeeId])
    INTO #SummaryOfChanges;

    MERGE [financial].[DimEmployee] AS [TRG]
    USING (
        SELECT *
        FROM #EmploymentDetails
        ) AS [SRC]
        ON [TRG].[SourceEmployeeId] = [SRC].[UltiproEmployeeID]
            AND [TRG].[EmployeeNumber] = [SRC].[EmployeeNumber]
            AND [TRG].[CompanyID] = [SRC].[CompanyID]
            AND [TRG].[RowHash] = [SRC].[RowHash]
    WHEN NOT MATCHED BY Target
        THEN
            INSERT (
                [CompanyID]
                , [SourceEmployeeId]
                , [FirstName]
                , [LastName]
                , [PrefferedName]
                , [FullName]
                , [Email]
                , [WorkPhone]
                , [CompanyCode]
                , [FTE]
                , [EmployeeNumber]
                , [SupervisorCompanyCode]
                , [SupervisorEmployeeNumber]
                -- , [ManagerKey]
                , [Department]
                , [DepartmentKey]
                , [WorkPlaceLocation]
                , [WorkPlaceName]
                , [StockLevelCode]
                , [JobCode]
                , [EmploymentStatus]
                , [Active]
                , [ExemptStatus]
                , [ScheduledHours]
                , [JobTitle]
                , [StatusStartDate]
                , [OriginalHireDate]
                , [LastHireDate]
                , [TerminationDate]
                , [FullOrPartTime]
                , [EmployeeType]
                , [SourceCreatedDate]
                , [SourceUpdatedDate]
                , [EFF_START_DT]
                , [RowHash]
                , [AuditUpdatedAt]
                , [AuditUpdatedBy]
                , [AuditCreatedAt]
                , [AuditCreatedBy]
                )
            VALUES (
                [SRC].[CompanyID]
                , [SRC].[UltiproEmployeeID]
                , [SRC].[FirstName]
                , [SRC].[LastName]
                , [SRC].[PrefferedName]
                , [SRC].[FullName]
                , [SRC].[Email]
                , [SRC].[WorkPhone]
                , [SRC].[CompanyCode]
                , [SRC].[FTE]
                , [SRC].[EmployeeNumber]
                , [SRC].[SupervisorCompanyCode]
                , [SRC].[SupervisorEmployeeNumber]
                -- , [SRC].[ManagerKey]
                , [SRC].[Department]
                , [SRC].[DepartmentKey]
                , [SRC].[WorkPlaceLocation]
                , [SRC].[WorkPlaceName]
                , [SRC].[StockLevelCode]
                , [SRC].[JobCode]
                , [SRC].[EmploymentStatus]
                , [SRC].[Active]
                , [SRC].[ExemptStatus]
                , [SRC].[ScheduledHours]
                , [SRC].[JobTitle]
                , [SRC].[StatusStartDate]
                , [SRC].[OriginalHireDate]
                , [SRC].[LastHireDate]
                , [SRC].[TerminationDate]
                , [SRC].[FullOrPartTime]
                , [SRC].[EmployeeType]
                , [SRC].[SourceCreatedDate]
                , [SRC].[SourceUpdatedDate]
                , GetDate()
                , [SRC].[RowHash]
                , GetDate()
                , CURRENT_USER
                , GetDate()
                , CURRENT_USER
                )
    OUTPUT 'DimEmployee'
        , CONVERT(VARCHAR, DELETED.[SourceEmployeeId])
        , $ACTION
        , CONVERT(VARCHAR, INSERTED.[SourceEmployeeId])
    INTO #SummaryOfChanges;

    EXECUTE spEndJob @pi_job_name = @pi_job_name
        , @pi_job_hist_id = @po_job_hist_id
        , @pi_max_update_date = @po_max_update_date
        , @pi_max_id = @po_max_id
        , @pi_status = 'C'
        , @pi_row_count = @@rowcount
        , @pi_error_code = NULL
END
