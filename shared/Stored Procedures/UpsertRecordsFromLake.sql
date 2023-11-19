
-- Uses an input file list of the format:
--[ "staging/contracts/current/000d8dff-365c-4e12-9ce4-13773e82bd75.json",
--  "legal/staging/contracts/current/000f9aaa-45f7-4a3a-b477-2096513113ac.json",
--  "legal/staging/contracts/current/00169df6-eb62-47e7-84ad-a571a01e5f86.json" ]
-- To merge the json data in the files in the lake into the warehouse tables.
-- The @dataDomain field is used to decide what stored procedure to call to handle the data in those files
CREATE PROCEDURE shared.UpsertRecordsFromLake
(
    @fileList varchar(MAX),
    @dataDomain varchar(300),  
    @returnCode int OUTPUT,
    @returnMessage VARCHAR(1000) OUTPUT
)


AS
BEGIN


    -- Drop temp tables used in sproc
    DROP TABLE IF EXISTS #Json
    DROP TABLE IF EXISTS #SummaryOfChanges


    -- Set default 0 return code
    SELECT @returnCode = 0;

    DECLARE 
        @fileName VARCHAR(MAX), 
        @BulkInsSQL NVARCHAR(MAX),
        @currentAction VARCHAR(200),
        @hasDataToLoad int;

    BEGIN TRY

    CREATE TABLE #Json (
        jsonData NVARCHAR(MAX)
    )

    CREATE TABLE #SummaryOfChanges (TableName VARCHAR(MAX), Deleted VARCHAR(MAX), ActionType VARCHAR(MAX), Inserted VARCHAR(MAX));  

    -- Set has results to false
    SELECT @hasDataToLoad = 0

    PRINT 'Starting Cursor for JSON Inserts'


    SELECT @currentAction = 'Create File List Cursor'
    DECLARE file_cursor CURSOR
    FOR SELECT DISTINCT
            lakeFileName
            FROM OPENJSON(@fileList)
            WITH (
                lakeFileName VARCHAR(250) '$'
            );



    OPEN file_cursor;   

    FETCH NEXT FROM file_cursor INTO 
        @fileName;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            
            PRINT @fileName

            SELECT @currentAction = 'Insert JSON into staging table'

            SET @BulkInsSQL = N'
            INSERT INTO #Json 
            SELECT BulkColumn as jsonData
            FROM OPENROWSET (BULK ''' + @fileName + ''',
                DATA_SOURCE = ''ionis_lake'', SINGLE_CLOB
                ) AS json
            ';

            PRINT @BulkInsSQL

                EXECUTE (@BulkInsSQL);

                
                -- Set has results to true if there are no errors
                SELECT @hasDataToLoad = @hasDataToLoad + 1
                INSERT INTO #SummaryOfChanges VALUES ('Insert JSON', 'File ', 'Inserted', @fileName)
            

            FETCH NEXT FROM file_cursor INTO 
                @fileName;
        END;


    CLOSE file_cursor;

    DEALLOCATE file_cursor;

    END TRY
    BEGIN CATCH

        SELECT @returnCode = ERROR_NUMBER();
        SELECT @returnMessage = 'Ubable to insert JSON into staging table. Action: ' + @currentAction + ' Error: ' + ERROR_MESSAGE();       
        
        INSERT INTO #SummaryOfChanges VALUES ('Insert JSON Error', @returnMessage, ' Error Number: ' +  CAST(ERROR_NUMBER() as varchar(100)), @fileName);
    END CATCH


    BEGIN TRY
        IF @hasDataToLoad > 0 AND @returnCode = 0
        BEGIN

            
            SELECT @currentAction = 'Starting Merge'
            PRINT @currentAction
            INSERT INTO #SummaryOfChanges VALUES (@currentAction, ' with ', @hasDataToLoad, ' file(s)')

            -- ADD NEW DATA HANDLERS HERE 
            -- Use the @dataDomain param to decide which stored procedure handles the data for that type of record
            IF @dataDomain = 'legal_contracts' 
                EXEC legal.UpsertContractsFromBlob @currentAction, @returnCode, @returnMessage;
            ELSE IF @dataDomain = 'employment_details'
                EXEC humanresources.LoadDimEmployee @currentAction, @returnCode, @returnMessage;
            ELSE IF @dataDomain = 'clinical_sites'
                EXEC clinical.UpsertClinicalSitesFromBlob @currentAction, @returnCode, @returnMessage;
            ELSE 
                BEGIN
                    DECLARE @errorMessage VARCHAR(MAX);
                    SELECT @errorMessage = N'Stored Procedure for @dataDomain: ' + @dataDomain + ' not found';  
                    THROW 600000, @errorMessage, 1;
                END

            
            SELECT @currentAction = 'Merge Complete'
            PRINT @currentAction
            INSERT INTO #SummaryOfChanges VALUES (@currentAction, ' of ', @hasDataToLoad, ' files')
        END

    END TRY
    BEGIN CATCH
    
    
        SELECT @returnCode = ERROR_NUMBER();
        SELECT @returnMessage = 'Ubable to parse JSON - Action: ' + @currentAction + '  Error: ' + ERROR_MESSAGE();    

        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() as varchar(100))
    
        INSERT INTO #SummaryOfChanges VALUES ('Lake File Merge Error ',  @returnMessage, ' Error Number: ' +  CAST(ERROR_NUMBER() as varchar(100)), 'Error ErrorLine: ' +  CAST(ERROR_LINE() as varchar(100)));

    END CATCH
            

    -- Return a summary of changes as a result set
    SELECT TableName, Deleted, ActionType, Inserted
    FROM #SummaryOfChanges;


END;
