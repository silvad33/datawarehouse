/****** Object:  View [clinical_mart].[Program]  ******/
CREATE view [clinical_mart].[Program] as 

with PublicCompound as (
SELECT CompoundNumber, max(CompoundName) as PublicCompound
  FROM [research].[CompoundNames]
  where CompoundNameType = 'Public' and CompoundNameStatus = 'current'
  group by CompoundNumber)

SELECT [ProgramName]
      ,[Compound]
      ,[Franchise]
      ,[Indication]
      ,[ClinicalProgramsID]
	  ,pc.PublicCompound
	  ,isnull(pc.PublicCompound,Compound) as DisplayCompund
  FROM [clinical].[ClinicalPrograms] cp
  left join
  PublicCompound pc
  on cast(cp.Compound as varchar(50)) = cast(pc.CompoundNumber as varchar(50))
GO


