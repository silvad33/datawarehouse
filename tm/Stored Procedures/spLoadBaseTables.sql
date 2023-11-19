-- =============================================
-- Author:      Yassir Elyamani
-- Create date: 05/04/2021
-- Description: This proc will Orchestrate the execution of the rest of the stored procedures
-- =============================================

CREATE PROCEDURE [tm].[spLoadBaseTables]
AS
	
	Exec [tm].[spPostStgTransform];
	Exec [tm].[spLoadStgResearchData];

	--Load Base tables 
	Exec [TM].[spLoadResearchProject];
	Exec [TM].[spLoadResearchProjectStatus];
	Exec [TM].[spLoadResearchIndications];
	exec [TM].[spLoadResearchProjectResearchIndications];
	Exec [TM].[spLoadIonisResearchTargets];
	Exec [TM].[spLoadResearchProjectMilestones];

RETURN 0
