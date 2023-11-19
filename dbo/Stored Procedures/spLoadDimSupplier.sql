CREATE PROCEDURE [dbo].[spLoadDimSupplier]
AS
BEGIN TRY
    -- ***************DB Info ***************
    -- Description  : update the dbo.DimSupplier table with changes from Coupa
    -- Notes        : This routine will be called every day and will only update the records that have had a change
    -- Contact      : Daniel Silva
    -- Date Created : 06/21/2021
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
        SELECT SupplierName
            , CoupaSupplierID
            , Entity
            , SupplierID
            , LastUpdated
            , D365SupplierId
            , LocationCode
            , FederalTaxId
            , InternationTaxId
            , StreetOne
            , StreetTwo
            , City
            , [State]
            , PostalCode
            , [Country]
            , [AuditCreatedAt]
            , [AuditCreatedBy]
            , [AuditUpdatedAt]
            , [AuditUpdatedBy]
        FROM [dbo].[DimSupplier]
        )
    MERGE INTO TARGET AS TRG
    USING (
        SELECT *
        FROM [dbo].[StgCoupaSuppliers]
        ) AS SRC
        ON SRC.CoupaSupplierID = TRG.CoupaSupplierID
            --When records are matched, update the records if there is any change
    WHEN MATCHED
        THEN
            UPDATE
            SET TRG.SupplierName = SRC.SupplierName
                , TRG.CoupaSupplierID = SRC.CoupaSupplierID
                , TRG.Entity = SRC.Entity
                , TRG.SupplierID = SRC.SupplierID
                , TRG.LastUpdated = SRC.LastUpdated
                , TRG.D365SupplierId = SRC.D365SupplierId
                , TRG.FederalTaxId = SRC.FederalTaxId
                , TRG.InternationTaxId = SRC.InternationTaxId
                , TRG.LocationCode = SRC.LocationCode
                , TRG.StreetOne = SRC.StreetOne
                , TRG.StreetTwo = SRC.StreetTwo
                , TRG.City = SRC.City
                , TRG.[State] = SRC.[State]
                , TRG.PostalCode = SRC.PostalCode
                , TRG.[Country] = SRC.[Country]
                , [AuditUpdatedAt] = getdate()
                , [AuditUpdatedBy] = CURRENT_USER
                --When no records are matched, insert the incoming records from source table to target table
    WHEN NOT MATCHED BY TARGET
        THEN
            INSERT (
                SupplierName
                , CoupaSupplierID
                , Entity
                , SupplierID
                , LastUpdated
                , D365SupplierId
                , FederalTaxId
                , InternationTaxId
                , LocationCode
                , StreetOne
                , StreetTwo
                , City
                , [State]
                , PostalCode
                , [Country]
                , [AuditCreatedAt]
                , [AuditCreatedBy]
                )
            VALUES (
                SRC.SupplierName
                , SRC.CoupaSupplierID
                , SRC.Entity
                , SRC.SupplierID
                , SRC.LastUpdated
                , SRC.D365SupplierId
                , FederalTaxId
                , InternationTaxId
                , SRC.LocationCode
                , SRC.StreetOne
                , SRC.StreetTwo
                , SRC.City
                , SRC.[State]
                , SRC.PostalCode
                , SRC.[Country]
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
