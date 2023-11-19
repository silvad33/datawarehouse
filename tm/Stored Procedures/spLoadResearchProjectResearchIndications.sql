
-- =============================================
-- Author:      Yassir Elyamani
-- Create date: 04/28/2021
-- Description: This proc will load data from stg view into ResearchIndications table
-- =============================================
create PROCEDURE [TM].[spLoadResearchProjectResearchIndications]
AS
BEGIN


Merge tm.ResearchProjectResearchIndications tg 
	using (select distinct rp.ResearchProjectId,ri.ResearchIndicationId
            from [TM].[StgResearchData]  stg 
            Inner join tm.ResearchProject rp on stg.Target = rp.ionisTargetName
                                                and stg.Franchise = rp.FranchiseName
            Inner join ResearchIndications ri on stg.Indication = ri.ResearchIndicationName ) src
	on tg.ResearchProjectId = src.ResearchProjectId
   -- and tg.ResearchIndicationId = src.ResearchIndicationId
   WHEN MATCHED AND tg.ResearchIndicationId <> src.ResearchIndicationId
        THEN UPDATE 
            set tg.ResearchIndicationId = src.ResearchIndicationId
    WHEN NOT MATCHED
        THEN     INSERT
                 ( ResearchProjectId
                    ,ResearchIndicationId)
            VALUES
                (   src.ResearchProjectId
                    ,src.ResearchIndicationId				
                );

				
END
GO


