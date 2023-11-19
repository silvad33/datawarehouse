CREATE FUNCTION [dbo].[fnFindUnicode]
(
    @in_string nvarchar(max)
)
RETURNS @unicode_char TABLE(id INT IDENTITY(1,1), Char_ NVARCHAR(4), position BIGINT)
AS
BEGIN
    DECLARE @character nvarchar(1)
    DECLARE @index int
 
    SET @index = 1
    WHILE @index <= LEN(@in_string)
    BEGIN
        SET @character = SUBSTRING(@in_string, @index, 1)
        IF((UNICODE(@character) NOT BETWEEN 32 AND 127) AND UNICODE(@character) NOT IN (10,11))
        BEGIN
      INSERT INTO @unicode_char(Char_, position)
      VALUES(@character, @index)
    END
    SET @index = @index + 1
    END
    RETURN
END
GO