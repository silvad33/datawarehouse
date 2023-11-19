-- =============================================
-- Author:      Yassir Elyamani
-- Create date: 04/27/2021
-- Description: This proc will load data from stg view into ResearchProject table
-- =============================================
create PROCEDURE [TM].[spLoadResearchProject]
AS
BEGIN


Merge tm.ResearchProject tg 
	using (select stg.[Target]
			, isnull(fr.FranchiseId,(Select FranchiseId from tm.Franchise where FranchiseName ='Unknown'))FranchiseId
			,stg.Franchise as FranchiseName
			, SYSTEM_USER as CreatedBy 
			,GETDATE()as CreatedDate
			,SYSTEM_USER as LastModifiedBy
			,GETDATE() as LastModifiedDate
		from [TM].[StgResearchData]  stg 
		left join tm.Franchise fr on isnull(stg.[Franchise],'Unkown') = fr.FranchiseName) src 
	on tg.ionisTargetName = src.[Target]
		and isnull(tg.franchiseId,'') = isnull(src.FranchiseId,'')
    WHEN NOT MATCHED
        THEN     INSERT
                 ( ionisTargetName
					,FranchiseId
					,FranchiseName
					,CreatedBy
					,CreatedDate
					,LastModifiedBy
					,LastModifiedDate )
            VALUES
                ( src.[Target]
                , src.FranchiseId
				,src.FranchiseName
				,src.CreatedBy
				,src.CreatedDate
				,src.LastModifiedBy
				,src.LastModifiedDate 				
                );

				
END
GO


