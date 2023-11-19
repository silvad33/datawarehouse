CREATE PROCEDURE dbo.spEndJob
(
    @pi_job_name VARCHAR(4000),
    @pi_job_hist_id INT,
    @pi_max_update_date DATETIME,
    @pi_max_id INT,
    @pi_status VARCHAR(1),
    @pi_row_count INT,
    @pi_error_code VARCHAR(MAX)
)
AS

/*****************************************************************************

  Description: This procedure "ends" a job history record based on
               the job name and job history ID passed in.  It also
               updates the end time, status, max update date, max ID,
               and row count based on the values passed in.

  NOTE:    pi_status = 'C' should be passed in if the job completed
           successfully so that the next invocation of start_job
           will pick up the most recent date and ID values.

  Revision History
  Date        Who               Description
  ---------------------------------------------------------------------------
  2021-03-25 Daniel Silva       Intital Deployment

******************************************************************************/

BEGIN

    UPDATE dbo.JobHistory
    SET EndTime = GETDATE(),
        JobStatus = @pi_status,
        MaxUpdateDate = @pi_max_update_date,
        MaxId = @pi_max_id,
        JobRowCount = @pi_row_count,
        ErrorCode = @pi_error_code
    WHERE JobName = @pi_job_name
          AND JobHistoryId = @pi_job_hist_id;

;

END;
