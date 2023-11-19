/*User Defined Function: fnGetStockLevelCode
Author: Daniel Silva
Date: 2021-11-10
Parameters:
Job Description
Returns:
Stock level code
Purpose:
The stock level code is appended to the end of the job description in UKG
*/
CREATE FUNCTION [humanresources].[fnGetStockLevelCode] (@JobDescription VARCHAR(200))
RETURNS VARCHAR(200)

BEGIN
    DECLARE @value AS VARCHAR(10);
    DECLARE @startindex AS INT = PATINDEX('%[0-9]%', @JobDescription);
    DECLARE @length AS INT = len(@JobDescription);

    SELECT @value = CASE 
            WHEN try_cast(substring(@JobDescription, @startindex, 1) AS INT) IS NULL
                THEN '0'
            WHEN try_cast(substring(@JobDescription, @startindex, 1) AS INT) = ''
                THEN '0'
            ELSE CASE 
                    WHEN len(substring(@JobDescription, @startindex, len(CHARINDEX('-', substring(@JobDescription, @startindex, @length - 1))))) = 1
                        THEN CONCAT (
                                '0'
                                , substring(@JobDescription, @startindex, @length - 1)
                                )
                    WHEN len(substring(@JobDescription, @startindex, @length - 1)) = 1
                        THEN CONCAT (
                                '0'
                                , substring(@JobDescription, @startindex, @length - 1)
                                )
                    ELSE substring(@JobDescription, @startindex, @length - 1)
                    END
            END

    RETURN @value
END
GO