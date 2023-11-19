
/* =============================================
-- Author:      Yassir Elyamani
-- Create date: 04/29/2021
-- Description: This proc will load data into spIonisResearchTargets

Change Date    Changed by       Description

-- =============================================*/
CREATE PROCEDURE [TM].[spLoadIonisResearchTargets]
AS
BEGIN


Merge [TM].[IonisResearchTargets] TARGET 
	using (select stg.Target
            , m.Symbol as GeneTarget
            , rp.ResearchProjectId
            ,SYSTEM_USER as CreatedBy
            ,GETDATE() as CreatedDate
            ,SYSTEM_USER as LastModifiedBy
            ,GETDATE() as LastModifiedDate
            from tm.StgResearchData stg 
            Inner join tm.ResearchProject rp on stg.Target = rp.ionisTargetName and rp.FranchiseName = stg.Franchise
            left join tm.stgTargetSymbolMapping m on stg.Target = m.ResearchTarget
        ) Source
	on target.ResearchProjectId = source.ResearchProjectId
	--will  be managing updates from sharepoint instead
  --  WHEN MATCHED and TARGET.geneTarget <> source.GeneTarget
  --  THEN 
	 -- UPDATE SET 
		--TARGET.geneTarget = source.GeneTarget,
		--LastModifiedDate=getdate(), 
		--LastModifiedBy=system_user
    WHEN NOT MATCHED
        THEN     INSERT
                 ( IonisTargetName
                   , GeneTarget
                   , ResearchProjectId
                   , CreatedBy
                   , CreatedDate
                   , LastModifiedBy
                   , LastModifiedDate)
            VALUES
                (    source.Target
                   , source.GeneTarget
                   , source.ResearchProjectId
                   , source.CreatedBy
                   , source.CreatedDate
                   , source.LastModifiedBy
                   , source.LastModifiedDate				
                );

	
END
