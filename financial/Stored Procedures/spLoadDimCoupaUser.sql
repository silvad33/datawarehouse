CREATE PROCEDURE [financial].[spLoadDimCoupaUser]
AS
BEGIN TRY
    -- ***************DB Info ***************
    -- Description  : update the dbo.DimCoupaUser table with changes from Coupa
    -- Notes        : This routine will be called every day and will only update the records that have had a change
    -- Contact      : Daniel Silva
    -- Date Created : 08/05/2021
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

    /* The below merge statements uses the employee id as the key */
    WITH TARGET
    AS (
        SELECT CoupaId
            , CreatedAt
            , UpdatedAt
            , LOGIN
            , Email
            , PurchasingUser
            , ExpenseUser
            , SourcingUser
            , InventoryUser
            , ContractsUser
            , AnalyticsUser
            , AicUser
            , SpendGuardUser
            , CcwUser
            , ClmAdvancedUser
            , SupplyChainUser
            , DimUserKey
            , FirstName
            , LastName
            , FullName
            , ApiUser
            , Active
            , SalesforceId
            , AccountSecurityType
            , AuthenticationMethod
            , SsoIdentifier
            , DefaultLocale
            , BusinessGroupSecurityType
            , EditInvoiceOnQuickEntry
            , MentionName
            , EmployeePaymentChannel
            , DimDepartmentKey
            , ManagerDimUserKey
            , [AuditCreatedAt]
            , [AuditCreatedBy]
            , [AuditUpdatedAt]
            , [AuditUpdatedBy]
        FROM [financial].[DimCoupaUsers]
        )
    MERGE INTO TARGET AS TRG
    USING (
        SELECT scu.CoupaId
            , scu.CreatedAt
            , scu.UpdatedAt
            , scu.LOGIN
            , scu.Email
            , scu.PurchasingUser
            , scu.ExpenseUser
            , scu.SourcingUser
            , scu.InventoryUser
            , scu.ContractsUser
            , scu.AnalyticsUser
            , scu.AicUser
            , scu.SpendGuardUser
            , scu.CcwUser
            , scu.ClmAdvancedUser
            , scu.SupplyChainUser
            , du.UserKey
            , scu.FirstName
            , scu.LastName
            , scu.FullName
            , scu.ApiUser
            , scu.Active
            , scu.SalesforceId
            , scu.AccountSecurityType
            , scu.AuthenticationMethod
            , scu.SsoIdentifier
            , scu.DefaultLocale
            , scu.BusinessGroupSecurityType
            , scu.EditInvoiceOnQuickEntry
            , scu.MentionName
            , scu.EmployeePaymentChannel
            , dd.DepartmentKey
            , du2.UserKey AS managerKey
        FROM financial.StgCoupaUsers AS scu
        LEFT JOIN DimUser AS du
            ON scu.employeenumber = du.EmployeeNumber
        LEFT JOIN DimUser AS du2
            ON scu.ManagerCoupaId = du2.CoupaUserID
        LEFT JOIN DimDepartment AS dd
            ON scu.DepartmentCode = dd.DepartmentNumber
        ) AS SRC
        ON SRC.CoupaId = TRG.CoupaId
    WHEN MATCHED
        THEN
            UPDATE
            SET TRG.CreatedAt = SRC.CreatedAt
                , TRG.UpdatedAt = SRC.UpdatedAt
                , TRG.LOGIN = SRC.LOGIN
                , TRG.Email = SRC.Email
                , TRG.PurchasingUser = SRC.PurchasingUser
                , TRG.ExpenseUser = SRC.ExpenseUser
                , TRG.SourcingUser = SRC.SourcingUser
                , TRG.InventoryUser = SRC.InventoryUser
                , TRG.ContractsUser = SRC.ContractsUser
                , TRG.AnalyticsUser = SRC.AnalyticsUser
                , TRG.AicUser = SRC.AicUser
                , TRG.SpendGuardUser = SRC.SpendGuardUser
                , TRG.CcwUser = SRC.CcwUser
                , TRG.ClmAdvancedUser = SRC.ClmAdvancedUser
                , TRG.SupplyChainUser = SRC.SupplyChainUser
                , TRG.DimUserKey = SRC.UserKey
                , TRG.FirstName = SRC.FirstName
                , TRG.LastName = SRC.LastName
                , TRG.FullName = SRC.FullName
                , TRG.ApiUser = SRC.ApiUser
                , TRG.Active = SRC.Active
                , TRG.SalesforceId = SRC.SalesforceId
                , TRG.AccountSecurityType = SRC.AccountSecurityType
                , TRG.AuthenticationMethod = SRC.AuthenticationMethod
                , TRG.SsoIdentifier = SRC.SsoIdentifier
                , TRG.DefaultLocale = SRC.DefaultLocale
                , TRG.BusinessGroupSecurityType = SRC.BusinessGroupSecurityType
                , TRG.EditInvoiceOnQuickEntry = SRC.EditInvoiceOnQuickEntry
                , TRG.MentionName = SRC.MentionName
                , TRG.EmployeePaymentChannel = SRC.EmployeePaymentChannel
                , TRG.DimDepartmentKey = SRC.DepartmentKey
                , TRG.ManagerDimUserKey = SRC.managerKey
                , TRG.[AuditUpdatedAt] = getdate()
                , TRG.[AuditUpdatedBy] = CURRENT_USER
    WHEN NOT MATCHED BY TARGET
        THEN
            INSERT (
                CoupaId
                , CreatedAt
                , UpdatedAt
                , LOGIN
                , Email
                , PurchasingUser
                , ExpenseUser
                , SourcingUser
                , InventoryUser
                , ContractsUser
                , AnalyticsUser
                , AicUser
                , SpendGuardUser
                , CcwUser
                , ClmAdvancedUser
                , SupplyChainUser
                , DimUserKey
                , FirstName
                , LastName
                , FullName
                , ApiUser
                , Active
                , SalesforceId
                , AccountSecurityType
                , AuthenticationMethod
                , SsoIdentifier
                , DefaultLocale
                , BusinessGroupSecurityType
                , EditInvoiceOnQuickEntry
                , MentionName
                , EmployeePaymentChannel
                , DimDepartmentKey
                , ManagerDimUserKey
                , [AuditCreatedAt]
                , [AuditCreatedBy]
                )
            VALUES (
                SRC.CoupaId
                , SRC.CreatedAt
                , SRC.UpdatedAt
                , SRC.LOGIN
                , SRC.Email
                , SRC.PurchasingUser
                , SRC.ExpenseUser
                , SRC.SourcingUser
                , SRC.InventoryUser
                , SRC.ContractsUser
                , SRC.AnalyticsUser
                , SRC.AicUser
                , SRC.SpendGuardUser
                , SRC.CcwUser
                , SRC.ClmAdvancedUser
                , SRC.SupplyChainUser
                , SRC.UserKey
                , SRC.FirstName
                , SRC.LastName
                , SRC.FullName
                , SRC.ApiUser
                , SRC.Active
                , SRC.SalesforceId
                , SRC.AccountSecurityType
                , SRC.AuthenticationMethod
                , SRC.SsoIdentifier
                , SRC.DefaultLocale
                , SRC.BusinessGroupSecurityType
                , SRC.EditInvoiceOnQuickEntry
                , SRC.MentionName
                , SRC.EmployeePaymentChannel
                , SRC.DepartmentKey
                , SRC.ManagerKey
                , GETDATE()
                , CURRENT_USER
                );
END TRY

BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber
        , ERROR_STATE() AS ErrorState
        , ERROR_SEVERITY() AS ErrorSeverity
        , ERROR_PROCEDURE() AS ErrorProcedure
        , ERROR_LINE() AS ErrorLine
        , ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

IF @@ERROR = 0
BEGIN
    EXECUTE spEndJob @pi_job_name = @pi_job_name
        , @pi_job_hist_id = @po_job_hist_id
        , @pi_max_update_date = @po_max_update_date
        , @pi_max_id = @po_max_id
        , @pi_status = 'C'
        , @pi_row_count = @@rowcount
        , @pi_error_code = NULL
END;
ELSE
BEGIN
    EXECUTE spEndJob @pi_job_name = @pi_job_name
        , @pi_job_hist_id = @po_job_hist_id
        , @pi_max_update_date = @po_max_update_date
        , @pi_max_id = @po_max_id
        , @pi_status = 'C'
        , @pi_row_count = @@rowcount
        , @pi_error_code = NULL
END;
