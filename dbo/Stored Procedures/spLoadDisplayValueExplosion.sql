CREATE PROCEDURE [dbo].[spLoadDisplayValueExplosion] as
DECLARE @MainAccountID varchar(10), @Department varchar(10), @Project varchar(10), @Task varchar(10), @DisplayValue varchar(50),
	@DashPos1 int,@DashPos2 int,@DashPos3 int, @Partition varchar(20), @DataAreaID varchar(4)

--CREATE TABLE DisplayValueExplosion(
--	DisplayValue varchar(100),
--	MainAccount varchar(10),
--	Department varchar(10),
--	Project varchar(10),
--	Task varchar(10),
--	Partition varchar(20),
--	DataAreaID varchar(4))

-- select * from DisplayValueExplosion

TRUNCATE TABLE DisplayValueExplosion

DECLARE AccountDisplayCursor CURSOR FOR
SELECT DISTINCT ACCOUNTDISPLAYVALUE, PARTITION, DataAreaID
FROM GeneralJournalAccountEntryStaging
UNION
SELECT DISTINCT DIMENSIONDISPLAYVALUE, PARTITION, DataAreaID
FROM BudgetRegisterEntryStaging

OPEN AccountDisplayCursor
FETCH NEXT FROM AccountDisplayCursor INTO @DisplayValue, @Partition, @DataAreaID

WHILE @@FETCH_STATUS=0
BEGIN
	SELECT @DashPos1=CHARINDEX('-',@DisplayValue)
	SELECT @DashPos2=@DashPos1+CHARINDEX('-',SUBSTRING(@DisplayValue,@DashPos1+1,50))
	SELECT @DashPos3=@DashPos2+CHARINDEX('-',SUBSTRING(@DisplayValue,@DashPos2+1,50))
	--SELECT @DisplayValue,@DashPos1,@DashPos2,@DashPos3


	SELECT @MainAccountID=SUBSTRING(@DisplayValue, 1, @DashPos1-1)
	SELECT @Department=SUBSTRING(@DisplayValue, @DashPos1+1, @DashPos2-(@DashPos1+1))
	SELECT @Project=SUBSTRING(@DisplayValue, @DashPos2+1, @DashPos3-(@DashPos2+1))
	SELECT @Task=SUBSTRING(@DisplayValue, @DashPos3+1, 50)

	INSERT INTO DisplayValueExplosion
	SELECT @DisplayValue,@MainAccountID,@Department, @Project, @Task, @Partition, @DataAreaID

	FETCH NEXT FROM AccountDisplayCursor INTO @DisplayValue, @Partition, @DataAreaID
END
CLOSE AccountDisplayCursor
DEALLOCATE AccountDisplayCursor
