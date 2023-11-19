--IF OBJECT_ID('dbo.spStartJob', 'P') IS NOT NULL
--    DROP PROCEDURE dbo.spStartJob;
--GO

CREATE PROCEDURE dbo.spStartJob
(
    @pi_job_name VARCHAR(4000),
    @po_job_hist_id INT OUT,
    @po_min_update_date DATETIME OUT,
    @po_max_update_date DATETIME OUT,
    @po_min_id INT OUT,
    @po_max_id INT OUT
)
AS
BEGIN
    BEGIN TRY
    /***********************************************************

  Description: This procedure creates a new job history record based on
               the job name passed in, and returns a unique job history
               ID, min/max update dates, and min/max IDs.  Jobs can choose
               to use either dates or IDs to track where they last left off.

  NOTE:        A "seed" record needs to be inserted for each new job name before
               the job calls this procedure for the first time. The job history id 
               should be 0 for this seed record.

  Revision History
  Date        Who               Description
  ---------------------------------------------------------------------------
2021-03-25    Daniel Silva      Initial deployment of stored procedure
2021-04-27    Daniel Silva      Changed temp table to use variables. 

******************************************************************************/
        -- DECLARE @pi_job_name VARCHAR(4000) = 'TEST'
        -- DECLARE @po_job_hist_id INT
        -- DECLARE @po_min_update_date DATETIME
        -- DECLARE @po_max_update_date DATETIME
        -- DECLARE @po_min_id INT
        -- DECLARE @po_max_id INT
        DECLARE @v_start_time DATETIME;/* Capture the start date of the Stored Procedure Run */
        --add a new column to enter the calling user
        /* Store the last successful run for this job in a temp table to use the data later */
        DECLARE @vEndTime DATETIME
        DECLARE @vErrorCode VARCHAR(max)
        DECLARE @vJobHistoryId INT
        DECLARE @vJobName VARCHAR(max)
        DECLARE @vMaxUpdateDate DATETIME
        DECLARE @vMaxId INT
        DECLARE @vMinUpdateDate DATETIME
        DECLARE @vMinId INT
        DECLARE @vStartTime DATETIME
        DECLARE @vJobStatus VARCHAR(Max)
        DECLARE @vJobRowCount INT

        SELECT @vEndTime = jh.EndTime
            , @vErrorCode = jh.ErrorCode
            , @vJobHistoryId = jh.JobHistoryId
            , @vJobName = jh.JobName
            , @vMaxUpdateDate = jh.MaxUpdateDate
            , @vMaxId = jh.MaxId
            , @vMinUpdateDate = jh.MinUpdateDate
            , @vMinId = jh.MinId
            , @vStartTime = jh.StartTime
            , @vJobStatus = jh.JobStatus
            , @vJobRowCount = jh.JobRowCount
        FROM dbo.JobHistory AS jh
        WHERE jh.jobname = @pi_job_name
            AND jh.JobStatus = 'C'
            AND jh.JobHistoryId = (
                SELECT MAX(jh2.JobHistoryId)
                FROM dbo.JobHistory AS jh2
                WHERE jh2.jobname = @pi_job_name
                    AND jh2.JobStatus = 'C'
                );

        SELECT @v_start_time = GETDATE();/* assign the current date to the start date variable */

        PRINT N'Start Time is ' + convert(VARCHAR, @v_start_time);

        SELECT @po_job_hist_id = (
                SELECT ISNULL(MAX(jh3.JobHistoryId) + 1, 1)
                FROM dbo.JobHistory AS jh3 /* if there is no seed record, then the first record will be 1. */
                );

        PRINT N'PO Job Hist Id is ' + convert(VARCHAR, @po_job_hist_id);

        --DANIEL 
        --add in the IDENTITY function
        SET @po_min_update_date = ISNULL((@vMaxUpdateDate), CONVERT(DATETIME, '2001-01-01 00:00:00'));

        PRINT N'PO Min update date is ' + convert(VARCHAR, @po_min_update_date);

        SET @po_max_update_date = CONVERT(DATETIME, '4000-01-01 00:00:00');

        PRINT N'PO Max update date is ' + convert(VARCHAR, @po_max_update_date);

        /* Set the po min id */
        SET @po_min_id = ISNULL((@vMaxId), 0);

        PRINT N'PO Min Id is ' + convert(VARCHAR, @po_min_id);

        /* insert the new record into the job history table */
        INSERT INTO dbo.JobHistory (
            JobHistoryId
            , JobName
            , StartTime
            , JobStatus
            , MinUpdateDate
            , MaxUpdateDate
            , MinId
            , CreatedBy
            )
        VALUES (
            @po_job_hist_id
            , @pi_job_name
            , @v_start_time
            , 'R'
            , @po_min_update_date
            , @po_max_update_date
            , @po_min_id
            , CURRENT_USER
            );
    END TRY

    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber
            , ERROR_SEVERITY() AS ErrorSeverity
            , ERROR_STATE() AS ErrorState
            , ERROR_LINE() AS ErrorLine
            , ERROR_PROCEDURE() AS ErrorProcedure
            , ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO