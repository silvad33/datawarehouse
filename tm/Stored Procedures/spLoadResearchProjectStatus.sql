/*- =============================================
	-- Author:      Yassir Elyamani
	-- Create date: 04/28/2021
	-- Description: This proc will load data from stg view into ResearchProjectStatus table
	-- =============================================*/
	CREATE PROCEDURE [TM].[spLoadResearchProjectStatus] AS 
	BEGIN 
	
	--Add New Records ADD 
	insert into tm.ResearchProjectStatus(
		ResearchProjectStatusNameId
		,ResearchProjectId
		,startDate
		,EndDate
		,IsCurrent
		,CreatedBy
		,CreatedDate
		,LastModifiedBy
		,LastModifiedDate
	)
select sn.ResearchProjectStatusNameId,
	rp.ResearchProjectId,
	Getdate() as StartDate,
	'12-12-9999' as EndDate,
	1 as IsCurrent,
	SYSTEM_USER as CreatedBy,
	GETDATE() as CreatedDate,
	SYSTEM_USER as LastModifiedBy,
	GETDATE() as LastModifiedDate
from [TM].[StgResearchData] stg
	Inner join tm.ResearchProjectStatusNames sn on stg.CurrentStatus = sn.ResearchProjectStatusName
	left join tm.Franchise fr on isnull(stg.[Franchise], 'Unkown') = fr.FranchiseName
	left join tm.ResearchProject rp on stg.Target = rp.ionisTargetName
	and isnull(rp.FranchiseId, '') = isnull(
		fr.FranchiseId,
		(
			Select FranchiseId
			from tm.Franchise
			where FranchiseName = 'Unkown'
		)
	)
	Left join tm.ResearchProjectStatus trg on sn.ResearchProjectStatusNameId = trg.ResearchProjectStatusNameId
	and rp.ResearchProjectId = trg.ResearchProjectId
Where trg.ResearchProjectStatusId is null 

--Uddate Projects that changed status 
--Close Old Record
UPDATE trg
set trg.EndDate = 	Getdate(),
	IsCurrent = 0,
	LastModifiedBy = SYSTEM_USER ,
	LastModifiedDate  = GETDATE()  
--	select count(1)
from [TM].[StgResearchData] stg
	Inner join tm.ResearchProjectStatusNames sn on stg.CurrentStatus = sn.ResearchProjectStatusName
	left join tm.Franchise fr on isnull(stg.[Franchise], 'Unkown') = fr.FranchiseName
	left join tm.ResearchProject rp on stg.Target = rp.ionisTargetName
	and isnull(rp.FranchiseId, '') = isnull(
		fr.FranchiseId,
		(
			Select FranchiseId
			from tm.Franchise
			where FranchiseName = 'Unkown'
		)
	)
	Inner join tm.ResearchProjectStatus trg on rp.ResearchProjectId = trg.ResearchProjectId
Where  sn.ResearchProjectStatusNameId <> trg.ResearchProjectStatusNameId 
	and trg.IsCurrent = 1 

	--Records that dropped from source file 
	insert into tm.ResearchProjectStatus(
		ResearchProjectStatusNameId
		,ResearchProjectId
		,startDate
		,EndDate
		,IsCurrent
		,CreatedBy
		,CreatedDate
		,LastModifiedBy
		,LastModifiedDate
	)
select (Select ResearchProjectStatusNameId from tm.ResearchProjectStatusNames where ResearchProjectStatusName = 'Dropped from Research File'),
	rp.ResearchProjectId,
	Getdate() as StartDate,
	'12-12-9999' as EndDate,
	1 as IsCurrent,
	SYSTEM_USER as CreatedBy,
	GETDATE() as CreatedDate,
	SYSTEM_USER as LastModifiedBy,
	GETDATE() as LastModifiedDate
from tm.ResearchProjectStatus trg 
	Inner join tm.ResearchProject rp on trg.ResearchProjectId = rp.ResearchProjectId
	Inner join tm.ResearchProjectStatusNames sn on trg.ResearchProjectStatusNameId = sn.ResearchProjectStatusNameId
	Left join [TM].[StgResearchData] stg on rp.ionisTargetName = stg.[Target]
										and isnull(stg.Franchise,'Unkown') =  isnull(rp.FranchiseName, 'Unkown')
Where  stg.[Target] is null 
	and trg.IsCurrent = 1 
	and trg.ResearchProjectStatusNameId <> (Select ResearchProjectStatusNameId from tm.ResearchProjectStatusNames where ResearchProjectStatusName = 'Dropped from Research File')

UPDATE trg
set trg.EndDate = 	Getdate(),
	IsCurrent = 0,
	LastModifiedBy = SYSTEM_USER ,
	LastModifiedDate  = GETDATE()  
	--select count(1)
from tm.ResearchProjectStatus trg 
	Inner join tm.ResearchProject rp on trg.ResearchProjectId = rp.ResearchProjectId
	Inner join tm.ResearchProjectStatusNames sn on trg.ResearchProjectStatusNameId = sn.ResearchProjectStatusNameId
	Left join [TM].[StgResearchData] stg on rp.ionisTargetName = stg.[Target]
										and isnull(stg.Franchise,'Unkown') =  isnull(rp.FranchiseName, 'Unkown')
Where  stg.[Target] is null 
	and trg.IsCurrent = 1 
	and trg.ResearchProjectStatusNameId <> (Select ResearchProjectStatusNameId from tm.ResearchProjectStatusNames where ResearchProjectStatusName = 'Dropped from Research File')

END
GO

		