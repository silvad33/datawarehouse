--Return the first series of numbers found in the input string
CREATE FUNCTION udf_extractInteger(@string VARCHAR(2000))
RETURNS VARCHAR(2000)
    AS

    BEGIN
        DECLARE @count int
        DECLARE @intNumbers VARCHAR(1000)
        DECLARE @numberFound BIT
        SET @count = 0
        SET @intNumbers = ''
        SET @numberFound = 0

        WHILE @count <= LEN(@string)
        BEGIN 
            IF SUBSTRING(@string, @count, 1)>='0' and SUBSTRING (@string, @count, 1) <='9'
                BEGIN
                    SET @intNumbers = @intNumbers + SUBSTRING (@string, @count, 1)
                    SET @numberFound = 1
                END
            ELSE
                IF @numberFound = 1 BREAK
            SET @count = @count + 1
        END
        RETURN @intNumbers
    END
    GO