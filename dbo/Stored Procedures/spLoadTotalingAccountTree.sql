CREATE PROCEDURE [dbo].[spLoadTotalingAccountTree]
AS
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

BEGIN
    DECLARE @LeafAccountID INT
        , @Level1AccountID INT
        , @Level2AccountID INT
        , @Level3AccountID INT

    --CREATE TABLE TotalingAccountTree(
    --LeafAccountID int,
    --Level1AccountID int,
    --Level2AccountID int,
    --Level3AccountID int)
    TRUNCATE TABLE TotalingAccountTree

    --SELECT * FROM TotalingAccountTree
    DECLARE AccountCursor CURSOR
    FOR
    SELECT COMPONENTMAINACCOUNTID
    FROM vwTotalingAccountExplosion
    WHERE COMPONENTMAINACCOUNTID < 10000

    OPEN AccountCursor

    FETCH NEXT
    FROM AccountCursor
    INTO @LeafAccountID

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @Level1AccountID = [TOTALINGMAINACCOUNTID]
        FROM vwTotalingAccountExplosion
        WHERE COMPONENTMAINACCOUNTID = @LeafAccountID

        SELECT @Level2AccountID = [TOTALINGMAINACCOUNTID]
        FROM vwTotalingAccountExplosion
        WHERE COMPONENTMAINACCOUNTID = @Level1AccountID

        SELECT @Level3AccountID = [TOTALINGMAINACCOUNTID]
        FROM vwTotalingAccountExplosion
        WHERE COMPONENTMAINACCOUNTID = @Level2AccountID

        INSERT INTO TotalingAccountTree
        SELECT @LeafAccountID
            , @Level1AccountID
            , @Level2AccountID
            , @Level3AccountID
            , NULL
            , NULL

        FETCH NEXT
        FROM AccountCursor
        INTO @LeafAccountID
    END

    CLOSE AccountCursor

    DEALLOCATE AccountCursor

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
END
    --select [TOTALINGMAINACCOUNTID]
    --from vwtotalingAccountExplosion
    --where COMPONENTMAINACCOUNTID=5000
    --select [TOTALINGMAINACCOUNTID]
    --from vwtotalingAccountExplosion
    --where COMPONENTMAINACCOUNTID=509999
    --select [TOTALINGMAINACCOUNTID]
    --from vwtotalingAccountExplosion
    --where COMPONENTMAINACCOUNTID=739999
