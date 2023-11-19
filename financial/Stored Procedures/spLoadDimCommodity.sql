CREATE PROCEDURE [financial].[spLoadDimCommodity]
AS
BEGIN TRY
    -- ***************DB Info ***************
    -- Description  : update the dbo.DimCommodity table with changes from Coupa
    -- Notes        : This routine will be called every day and will only update the records that have had a change
    -- Contact      : Daniel Silva
    -- Date Created : 06/24/2021
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
        SELECT CoupaCommodityId
            , CreatedAt
            , UpdatedAt
            , Active
            , Name
            , TranslatedName
            , Deductibility
            , Category
            , SubCategory
            , Account
            , Taxable
            , Project
            , Study
            , CreatedByCoupaId
            , UpdatedByCoupaId
            , [AuditCreatedAt]
            , [AuditCreatedBy]
            , [AuditUpdatedAt]
            , [AuditUpdatedBy]
        FROM dbo.DimCommodity
        )
    MERGE INTO TARGET AS TRG
    USING (
        SELECT scc.Id
    , scc.CreatedAt
    , scc.UpdatedAt
    , scc.Active
    , scc.Name
    , scc.TranslatedName
    , scc.Deductibility
    , scc.Category
    , scc.SubCategory
    , da.accountkey
    , scc.Taxable
    , dp.projectkey
    , scc.Study
    , du.CoupaUserId AS CreatedByCoupaId
    , du2.CoupaUserId AS UpdatedByCoupaId
FROM financial.StgCoupaCommodities AS scc
    LEFT JOIN dbo.dimuser AS du
    ON scc.createdById = du.CoupaUserId
    LEFT JOIN dbo.dimuser AS du2
    ON scc.createdById = du2.CoupaUserId
    LEFT JOIN dbo.DimAccount AS da
    ON scc.account = da.mainaccountnumber
    LEFT JOIN (
    SELECT projectkey
        , projectnumber
    FROM dbo.DimProject
    WHERE dataareaid = 'IONS'
    ) AS dp
    ON scc.Project = dp.projectnumber
        ) AS SRC
        ON SRC.Id = TRG.CoupaCommodityId
    WHEN MATCHED
        THEN
            UPDATE
            SET TRG.CreatedAt = SRC.CreatedAt
                , TRG.UpdatedAt = SRC.UpdatedAt
                , TRG.Active = SRC.Active
                , TRG.Name = SRC.Name
                , TRG.TranslatedName = SRC.TranslatedName
                , TRG.Deductibility = SRC.Deductibility
                , TRG.Category = SRC.Category
                , TRG.SubCategory = SRC.SubCategory
                , TRG.Account = SRC.AccountKey
                , TRG.Taxable = SRC.Taxable
                , TRG.Project = SRC.ProjectKey
                , TRG.Study = SRC.Study
                , TRG.CreatedByCoupaId = SRC.CreatedByCoupaId
                , TRG.UpdatedByCoupaId = SRC.UpdatedByCoupaId
                , TRG.[AuditUpdatedAt] = getdate()
                , TRG.[AuditUpdatedBy] = CURRENT_USER
    WHEN NOT MATCHED BY TARGET
        THEN
            INSERT (
                CoupaCommodityId
                , CreatedAt
                , UpdatedAt
                , Active
                , Name
                , TranslatedName
                , Deductibility
                , Category
                , SubCategory
                , Account
                , Taxable
                , Project
                , Study
                , CreatedByCoupaId
                , UpdatedByCoupaId
                , [AuditCreatedAt]
                , [AuditCreatedBy]
                )
            VALUES (
                SRC.Id
                , SRC.CreatedAt
                , SRC.UpdatedAt
                , SRC.Active
                , SRC.Name
                , SRC.TranslatedName
                , SRC.Deductibility
                , SRC.Category
                , SRC.SubCategory
                , SRC.accountkey
                , SRC.Taxable
                , SRC.ProjectKey
                , SRC.Study
                , SRC.CreatedByCoupaId
                , SRC.UpdatedByCoupaId
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
