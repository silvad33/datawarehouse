
/*
    -- *************************************
    --  Saves PubsRecordCompound.CoumpoundNumber
    --  Additionally, if the ensembl_id parameter value is not 'No Isis Data',also insert a new PubsRecordTarget record (saving Ensembl_ID and Selected gene term)
    --  Intended use:  Boomi's import from Pubs changed records
    --  Contact     :  John O'Neill
    --  Modified    :  4/21/2020.  Initial save
    -- *************************************
*/
CREATE Procedure  [dbo].[PubsRecordCompoundsAndTargetsWrite]
(
     @pubsKey int
   , @ensembl_id VARCHAR(50)
    ,@compound_number VARCHAR(50)
    ,@geneTerm VARCHAR(50)
)
WITH EXECUTE AS N'dbo'
	AS
 BEGIN


 SET NOCOUNT ON
 
-- Save new compound value
IF NOT Exists(SELECT TOP 1 * from dbo.PubsRecordCompound where PubsKey = @pubsKey AND CompoundNumber = @compound_number)
BEGIN
    INSERT INTO dbo.PubsRecordCompound (PubsKey, CompoundNumber) VALUES (@pubsKey,TRIM(@compound_number))
END


-- If the ensembl_id is not 'No Isis Data', create a PusbRecordTarget record
IF (@ensembl_id !='No Isis Data')--  OR @geneTerm like 'No Symbol%')
BEGIN
    IF NOT Exists(SELECT TOP 1 * from dbo.PubsRecordTarget where PubsKey = @pubsKey AND Ensembl_Id = @ensembl_id)
    BEGIN
        INSERT INTO dbo.PubsRecordTarget(PubsKey, Ensembl_Id, SelectedTerm) VALUES(@pubsKey, @ensembl_id, @geneTerm)
    END
END-- Ensembl_id was not No Isis Data


END 
