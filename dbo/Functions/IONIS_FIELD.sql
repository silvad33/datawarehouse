CREATE FUNCTION IONIS_FIELD(@value varchar(500), @seperator char, @item int)
RETURNS varchar(500)
AS
BEGIN
	DECLARE @returnValue varchar(500);
	--EXEC @returnValue = spIONIS_FIELD @value, @seperator, @item;
	WITH Ordered AS (
	SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS RowNumber, value
	FROM STRING_SPLIT(@value, @seperator))
	SELECT @returnValue = value  
	FROM Ordered
	WHERE RowNumber = @item

	RETURN @returnValue;
END
