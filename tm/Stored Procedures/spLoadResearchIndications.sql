-- =============================================
-- Author:      Yassir Elyamani
-- Create date: 04/28/2021
-- Description: This proc will load data from stg view into ResearchIndications table
-- =============================================
create PROCEDURE [TM].[spLoadResearchIndications]
AS
BEGIN


Merge tm.ResearchIndications tg 
	using (select Distinct isnull(Indication,'Missing') ResearchIndicationName
			, SYSTEM_USER as CreatedBy 
			,GETDATE()as CreatedDate
			,SYSTEM_USER as LastModifiedBy
			,GETDATE() as LastModifiedDate
		    from [TM].[StgResearchData]  ) src
	on tg.ResearchIndicationName = src.ResearchIndicationName
    WHEN NOT MATCHED
        THEN     INSERT
                 ( ResearchIndicationName
                    ,CreatedBy
                    ,CreatedDate
                    ,LastModifiedBy
                    ,LastModifiedDate )
            VALUES
                (   src.ResearchIndicationName
                    ,src.CreatedBy
                    ,src.CreatedDate
                    ,src.LastModifiedBy
                    ,src.LastModifiedDate				
                );

				
END
GO


