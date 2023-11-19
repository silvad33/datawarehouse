CREATE PROCEDURE [humanresources].[spLoadDimUser]
AS
BEGIN TRY
    -- ***************DB Info ***************
    -- Description  : update the dbo.DimUser table with changes from Ultipro
    -- Notes        : This routine will be called every day and will only update the records that have had a change
    -- Contact      : Daniel Silva
    -- Date Created : 01/05/2021
    -- Change hist.	: 01/15/2021 added localcurrency
    -- *************** /DB Info ***************

    DECLARE @pi_job_name VARCHAR(4000) = OBJECT_NAME(@@PROCID),
            @po_job_hist_id INT,
            @po_min_update_date DATETIME,
            @po_max_update_date DATETIME,
            @po_min_id INT,
            @po_max_id INT

    EXECUTE spStartJob @pi_job_name,
                       @po_job_hist_id OUTPUT,
                       @po_min_update_date OUT,
                       @po_max_update_date OUT,
                       @po_min_id OUT,
                       @po_max_id OUT;

    /* The below merge statements uses the employee id as the key */
    WITH TARGET
    AS (SELECT *
        FROM dbo.DimUser
        WHERE EmployeeId IS NOT NULL)
    MERGE INTO TARGET AS TRG
    USING
    (
        SELECT *
        FROM humanresources.vwUltiproEmployeeStaged
        WHERE Employeeid IS NOT NULL
    ) AS SRC
    ON SRC.EmployeeId = TRG.EmployeeId
    WHEN MATCHED AND (
                         ISNULL(TRG.EmployeeNumber, '') <> ISNULL(SRC.EmployeeNumber, '')
                         OR ISNULL(TRG.ManagerKey, 0) <> ISNULL(SRC.ManagerKey, 0)
                         OR ISNULL(TRG.DepartmentKey, 0) <> ISNULL(SRC.DepartmentKey, 0)
                         OR ISNULL(TRG.FirstName, '') <> ISNULL(SRC.FirstName, '')
                         OR ISNULL(TRG.LastName, '') <> ISNULL(SRC.LastName, '')
                         OR ISNULL(TRG.FullName, '') <> ISNULL(SRC.FullName, '')
                         OR ISNULL(TRG.StockLevelCode, '') <> ISNULL(SRC.StockLevelCode, '')
                         OR ISNULL(TRG.UserType, '') <> ISNULL(SRC.UserType, '')
                         OR ISNULL(TRG.Active, '') <> ISNULL(SRC.Active, '')
                         OR ISNULL(TRG.CompanyCode, '') <> ISNULL(SRC.CompanyCode, '')
                         OR ISNULL(TRG.Notes, '') <> ISNULL(SRC.Notes, '')
                         OR ISNULL(TRG.FTE, 0) <> ISNULL(SRC.FTE, 0)
                         OR ISNULL(TRG.JobTitle, '') <> ISNULL(SRC.JobTitle, '')
                         OR ISNULL(TRG.TerminationDate, '') <> ISNULL(SRC.TerminationDate, '')
                         OR ISNULL(TRG.LatestHireDate, '') <> ISNULL(SRC.LatestHireDate, '')
                         OR ISNULL(TRG.FirstNameFormal, '') <> ISNULL(SRC.FirstNameFormal, '')
                         OR ISNULL(TRG.ExemptStatus, '') <> ISNULL(SRC.ExemptStatus, '')
                         OR ISNULL(TRG.WorkplaceName, '') <> ISNULL(SRC.WorkplaceName, '')
                         OR ISNULL(TRG.WorkplaceLocation, '') <> ISNULL(SRC.MailStop, '')
                         OR ISNULL(TRG.EmailUltiPro, '') <> ISNULL(SRC.EmailUltiPro, '')
                         OR ISNULL(TRG.WorkPhone, '') <> ISNULL(SRC.WorkPhone, '')
                         OR ISNULL(TRG.CellPhone, '') <> ISNULL(SRC.CellPhone, '')
                         OR ISNULL(TRG.CurrencyCode, '') <> ISNULL(SRC.CurrencyCode, '')
                     ) THEN
        UPDATE SET TRG.EmployeeNumber = SRC.EmployeeNumber,
                   TRG.ManagerKey = SRC.ManagerKey,
                   TRG.DepartmentKey = SRC.DepartmentKey,
                   TRG.FirstName = SRC.FirstName,
                   TRG.LastName = SRC.LastName,
                   TRG.FullName = SRC.FullName,
                   TRG.StockLevelCode = SRC.StockLevelCode,
                   TRG.UserType = SRC.UserType,
                   TRG.Active = SRC.Active,
                   TRG.CompanyCode = SRC.CompanyCode,
                   TRG.Notes = SRC.Notes,
                   TRG.FTE = SRC.FTE,
                   TRG.JobTitle = SRC.JobTitle,
                   TRG.TerminationDate = SRC.TerminationDate,
                   TRG.LatestHireDate = SRC.LatestHireDate,
                   TRG.FirstNameFormal = SRC.FirstNameFormal,
                   TRG.ExemptStatus = SRC.ExemptStatus,
                   TRG.WorkplaceName = SRC.WorkplaceName,
                   TRG.EmailUltiPro = SRC.EmailUltiPro,
                   TRG.WorkPhone = SRC.WorkPhone,
                   TRG.CellPhone = SRC.CellPhone,
                   TRG.DateModified = SRC.DateModified,
                   TRG.WorkplaceLocation = SRC.MailStop,
                   TRG.CurrencyCode = SRC.CurrencyCode
    OUTPUT $ACTION,
           INSERTED.EmployeeId AS Changes;

    /* The below merge statements uses the employee email as the key */
    WITH TARGET
    AS (SELECT *
        FROM dbo.DimUser
        WHERE EmployeeId IS NULL)
    MERGE INTO TARGET AS TRG
    USING
    (
        SELECT *
        FROM humanresources.vwUltiproEmployeeStaged
        WHERE emailaddress IS NOT NULL
    ) AS SRC
    ON TRG.userprincipalname = SRC.EmailAddress
    WHEN MATCHED AND (
                         ISNULL(TRG.EmployeeNumber, '') <> ISNULL(CONVERT(VARCHAR, SRC.EmployeeNumber), '')
                         OR ISNULL(TRG.ManagerKey, 0) <> ISNULL(SRC.ManagerKey, 0)
                         OR ISNULL(TRG.DepartmentKey, 0) <> ISNULL(SRC.DepartmentKey, 0)
                         OR ISNULL(TRG.FirstName, '') <> ISNULL(SRC.FirstName, '')
                         OR ISNULL(TRG.LastName, '') <> ISNULL(SRC.LastName, '')
                         OR ISNULL(TRG.FullName, '') <> ISNULL(SRC.FullName, '')
                         OR ISNULL(TRG.StockLevelCode, '') <> ISNULL(SRC.StockLevelCode, '')
                         OR ISNULL(TRG.UserType, '') <> ISNULL(SRC.UserType, '')
                         OR ISNULL(TRG.Active, '') <> ISNULL(SRC.Active, '')
                         OR ISNULL(TRG.CompanyCode, '') <> ISNULL(SRC.CompanyCode, '')
                         OR ISNULL(TRG.Notes, '') <> ISNULL(SRC.Notes, '')
                         OR ISNULL(TRG.FTE, 0) <> ISNULL(SRC.FTE, 0)
                         OR ISNULL(TRG.JobTitle, '') <> ISNULL(SRC.JobTitle, '')
                         OR ISNULL(TRG.TerminationDate, '') <> ISNULL(SRC.TerminationDate, '')
                         OR ISNULL(TRG.LatestHireDate, '') <> ISNULL(SRC.LatestHireDate, '')
                         OR ISNULL(TRG.FirstNameFormal, '') <> ISNULL(SRC.FirstNameFormal, '')
                         OR ISNULL(TRG.ExemptStatus, '') <> ISNULL(SRC.ExemptStatus, '')
                         OR ISNULL(TRG.WorkplaceName, '') <> ISNULL(SRC.WorkplaceName, '')
                         OR ISNULL(TRG.WorkplaceLocation, '') <> ISNULL(SRC.MailStop, '')
                         OR ISNULL(TRG.EmailUltiPro, '') <> ISNULL(SRC.EmailUltiPro, '')
                         OR ISNULL(TRG.WorkPhone, '') <> ISNULL(SRC.WorkPhone, '')
                         OR ISNULL(TRG.CellPhone, '') <> ISNULL(SRC.CellPhone, '')
                         OR ISNULL(TRG.Employeeid, '') <> ISNULL(SRC.EmployeeId, '')
                         OR ISNULL(TRG.CurrencyCode, '') <> ISNULL(SRC.CurrencyCode, '')
                     ) THEN
        UPDATE SET TRG.EmployeeNumber = SRC.EmployeeNumber,
                   TRG.ManagerKey = SRC.ManagerKey,
                   TRG.DepartmentKey = SRC.DepartmentKey,
                   TRG.FirstName = SRC.FirstName,
                   TRG.LastName = SRC.LastName,
                   TRG.FullName = SRC.FullName,
                   TRG.StockLevelCode = SRC.StockLevelCode,
                   TRG.UserType = SRC.UserType,
                   TRG.Active = SRC.Active,
                   TRG.CompanyCode = SRC.CompanyCode,
                   TRG.Notes = SRC.Notes,
                   TRG.FTE = SRC.FTE,
                   TRG.JobTitle = SRC.JobTitle,
                   TRG.TerminationDate = SRC.TerminationDate,
                   TRG.LatestHireDate = SRC.LatestHireDate,
                   TRG.FirstNameFormal = SRC.FirstNameFormal,
                   TRG.ExemptStatus = SRC.ExemptStatus,
                   TRG.WorkplaceName = SRC.WorkplaceName,
                   TRG.EmailUltiPro = SRC.EmailUltiPro,
                   TRG.WorkPhone = SRC.WorkPhone,
                   TRG.CellPhone = SRC.CellPhone,
                   TRG.DateModified = SRC.DateModified,
                   TRG.WorkplaceLocation = SRC.MailStop,
                   TRG.Employeeid = SRC.Employeeid,
                   TRG.CurrencyCode = SRC.CurrencyCode
    OUTPUT $ACTION,
           INSERTED.EmployeeId AS Changes;

    UPDATE ues
    SET ues.recordprocessed = 'Y'
    FROM UltiproEmployeeStaging ues
        INNER JOIN DimUser AS du
            ON ues.employeenumber = du.employeeid;

    /*Commented out the last section as we are no longer doing a fuzzy match */

    /*This last merge statement looks for records that have a longer email address in AD than in Ultipro */

    --WITH TARGET
    --AS (SELECT *
    --    FROM dbo.DimUser
    --    WHERE EmployeeId IS NULL)
    --MERGE INTO TARGET AS TRG
    --USING
    --(
    --    SELECT *
    --    FROM humanresources.vwUltiproEmployeeStaged
    --    WHERE emailaddress IS NOT NULL
    --          AND recordprocessed IS NULL
    --) AS SRC
    --ON (CASE
    --        WHEN LEN(SUBSTRING(trg.email, 0, CHARINDEX('@', trg.email))) <= 6 THEN
    --            SUBSTRING(trg.email, 0, CHARINDEX('@', trg.email))
    --        ELSE
    --            SUBSTRING(trg.email, 0, 7)
    --    END
    --   ) = (CASE
    --            WHEN LEN(SUBSTRING(src.emailaddress, 0, CHARINDEX('@', src.emailaddress))) <= 6 THEN
    --                SUBSTRING(src.emailaddress, 0, CHARINDEX('@', src.emailaddress))
    --            ELSE
    --                SUBSTRING(src.emailaddress, 0, 7)
    --        END
    --       )
    --WHEN MATCHED AND (
    --                     ISNULL(TRG.EmployeeNumber, '') <> ISNULL(CONVERT(VARCHAR, SRC.EmployeeNumber), '')
    --                     OR ISNULL(TRG.Email, '') <> ISNULL(SRC.EmailAddress, '')
    --                     OR ISNULL(TRG.ManagerKey, 0) <> ISNULL(SRC.ManagerKey, 0)
    --                     OR ISNULL(TRG.DepartmentKey, 0) <> ISNULL(SRC.DepartmentKey, 0)
    --                     OR ISNULL(TRG.FirstName, '') <> ISNULL(SRC.FirstName, '')
    --                     OR ISNULL(TRG.LastName, '') <> ISNULL(SRC.LastName, '')
    --                     OR ISNULL(TRG.FullName, '') <> ISNULL(SRC.FullName, '')
    --                     OR ISNULL(TRG.StockLevelCode, '') <> ISNULL(SRC.StockLevelCode, '')
    --                     OR ISNULL(TRG.UserType, '') <> ISNULL(SRC.UserType, '')
    --                     OR ISNULL(TRG.Active, '') <> ISNULL(SRC.Active, '')
    --                     OR ISNULL(TRG.CompanyCode, '') <> ISNULL(SRC.CompanyCode, '')
    --                     OR ISNULL(TRG.Notes, '') <> ISNULL(SRC.Notes, '')
    --                     OR ISNULL(TRG.FTE, 0) <> ISNULL(SRC.FTE, 0)
    --                     OR ISNULL(TRG.JobTitle, '') <> ISNULL(SRC.JobTitle, '')
    --                     OR ISNULL(TRG.TerminationDate, '') <> ISNULL(SRC.TerminationDate, '')
    --                     OR ISNULL(TRG.LatestHireDate, '') <> ISNULL(SRC.LatestHireDate, '')
    --                     OR ISNULL(TRG.FirstNameFormal, '') <> ISNULL(SRC.FirstNameFormal, '')
    --                     OR ISNULL(TRG.ExemptStatus, '') <> ISNULL(SRC.ExemptStatus, '')
    --                     OR ISNULL(TRG.WorkplaceName, '') <> ISNULL(SRC.WorkplaceName, '')
    --                     OR ISNULL(TRG.WorkplaceLocation, '') <> ISNULL(SRC.MailStop, '')
    --                     OR ISNULL(TRG.EmailUltiPro, '') <> ISNULL(SRC.EmailUltiPro, '')
    --                     OR ISNULL(TRG.WorkPhone, '') <> ISNULL(SRC.WorkPhone, '')
    --                     OR ISNULL(TRG.CellPhone, '') <> ISNULL(SRC.CellPhone, '')
    --                     OR ISNULL(TRG.Employeeid, '') <> ISNULL(SRC.EmployeeId, '')
    --                     OR ISNULL(TRG.CurrencyCode, '') <> ISNULL(SRC.CurrencyCode, '')
    --                 ) THEN
    --    UPDATE SET TRG.EmployeeNumber = SRC.EmployeeNumber,
    --               TRG.Email = SRC.EmailAddress,
    --               TRG.ManagerKey = SRC.ManagerKey,
    --               TRG.DepartmentKey = SRC.DepartmentKey,
    --               TRG.FirstName = SRC.FirstName,
    --               TRG.LastName = SRC.LastName,
    --               TRG.FullName = SRC.FullName,
    --               TRG.StockLevelCode = SRC.StockLevelCode,
    --               TRG.UserType = SRC.UserType,
    --               TRG.Active = SRC.Active,
    --               TRG.CompanyCode = SRC.CompanyCode,
    --               TRG.Notes = SRC.Notes,
    --               TRG.FTE = SRC.FTE,
    --               TRG.JobTitle = SRC.JobTitle,
    --               TRG.TerminationDate = SRC.TerminationDate,
    --               TRG.LatestHireDate = SRC.LatestHireDate,
    --               TRG.FirstNameFormal = SRC.FirstNameFormal,
    --               TRG.ExemptStatus = SRC.ExemptStatus,
    --               TRG.WorkplaceName = SRC.WorkplaceName,
    --               TRG.EmailUltiPro = SRC.EmailUltiPro,
    --               TRG.WorkPhone = SRC.WorkPhone,
    --               TRG.CellPhone = SRC.CellPhone,
    --               TRG.DateModified = SRC.DateModified,
    --               TRG.WorkplaceLocation = SRC.MailStop,
    --               TRG.Employeeid = SRC.Employeeid,
    --               TRG.CurrencyCode = SRC.CurrencyCode
    --OUTPUT $ACTION,
    --       INSERTED.EmployeeId AS Changes;


END TRY
BEGIN CATCH

    SELECT ERROR_NUMBER() AS ErrorNumber,
           ERROR_STATE() AS ErrorState,
           ERROR_SEVERITY() AS ErrorSeverity,
           ERROR_PROCEDURE() AS ErrorProcedure,
           ERROR_LINE() AS ErrorLine,
           ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

IF @@ERROR = 0
BEGIN
    EXECUTE spEndJob @pi_job_name = @pi_job_name,
                     @pi_job_hist_id = @po_job_hist_id,
                     @pi_max_update_date = @po_max_update_date,
                     @pi_max_id = @po_max_id,
                     @pi_status = 'C',
                     @pi_row_count = @@rowcount,
                     @pi_error_code = NULL
END;
ELSE
BEGIN
    EXECUTE spEndJob @pi_job_name = @pi_job_name,
                     @pi_job_hist_id = @po_job_hist_id,
                     @pi_max_update_date = @po_max_update_date,
                     @pi_max_id = @po_max_id,
                     @pi_status = 'C',
                     @pi_row_count = @@rowcount,
                     @pi_error_code = NULL
END;