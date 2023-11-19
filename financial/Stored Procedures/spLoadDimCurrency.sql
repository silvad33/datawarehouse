CREATE PROCEDURE [dbo].[spLoadDimCurrency]
AS
BEGIN TRY
    -- ***************DB Info ***************
    -- Description  : update the dbo.DimCurrency table with changes from Coupa
    -- Notes        : This routine will be called every day and will only update the records that have had a change
    -- Contact      : Daniel Silva
    -- Date Created : 06/22/2021
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

    WITH TARGET
    AS (
        SELECT CoupaId
            , Code
            , Decimals
            , UpdatedByUserKey
            , [AuditCreatedAt]
            , [AuditCreatedBy]
            , [AuditUpdatedAt]
            , [AuditUpdatedBy]
        FROM [dbo].[DimCurrency]
        )
    MERGE INTO TARGET AS TRG
    USING (
        SELECT scc.coupaid
            , scc.code
            , scc.decimals
            , du.UserKey
        FROM [financial].[StgCoupaCurrencies] AS scc
        LEFT JOIN dbo.DimUser AS du
            ON scc.updatedbyid = du.coupauserid
        ) AS SRC
        ON SRC.CoupaId = TRG.CoupaId
            --When records are matched, update the records if there is any change
    WHEN MATCHED
        THEN
            UPDATE
            SET TRG.Code = SRC.Code
                , TRG.Decimals = SRC.Decimals
                , TRG.UpdatedByUserKey = SRC.UserKey
                , [AuditUpdatedAt] = getdate()
                , [AuditUpdatedBy] = CURRENT_USER
                --When no records are matched, insert the incoming records from source table to target table
    WHEN NOT MATCHED BY TARGET
        THEN
            INSERT (
                CoupaId
                , Code
                , Decimals
                , UpdatedByUserKey
                , [AuditCreatedAt]
                , [AuditCreatedBy]
                )
            VALUES (
                SRC.coupaid
                , SRC.Code
                , SRC.Decimals
                , SRC.UserKey
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