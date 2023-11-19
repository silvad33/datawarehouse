CREATE  PROCEDURE [clinical].[BaselinePlanAdjustment_Randomizations]

 @ScenarioName VARCHAR(2500),
 @ClinicalStudy VARCHAR(50),
 @Status VARCHAR(50),
 --@NewRandomizationRate INT,
 @ActivationDate DATE,
 @StatusDate DATETIME


AS
 
--DECLARE @CurrentRandomizationRate INT 
--DECLARE @AdjustedRandomizationRate NUMERIC(18,2)
 
--SET @CurrentRandomizationRate = (SELECT MAX(RandomizationRate_pct) FROM clinical.ScenarioParameters SP JOIN clinical.RecruitmentScenarios RS ON SP.ScenarioParametersID = RS.ScenarioParametersID WHERE RS.ClinicalStudyName = @ClinicalStudy)
--SET @AdjustedRandomizationRate = ((@CurrentRandomizationRate - @NewRandomizationRate)/100)
 
INSERT INTO clinical.ScenarioBuilderOutput
SELECT 
    CONCAT(CONCAT(@ClinicalStudy, '_'),@ScenarioName) AS ScenarioName
    ,@ScenarioName AS [Status]
    ,@StatusDate AS StatusDate
    ,CAST(ScenarioSiteName AS NVARCHAR(256)) AS ScenarioSiteName
    ,ActualSite
    ,PatientRecruitmentDate
    ,NumberofSubjects
    ,@ClinicalStudy AS ClinicalStudy 
FROM clinical.RecruitmentScenarios
WHERE
    --CAST(PatientRecruitmentDate AS DATE) >= @ActivationDate
    ClinicalStudyName = @ClinicalStudy
    AND [Status] = @Status
UNION ALL
SELECT
    CONCAT(CONCAT(@ClinicalStudy, '_'),@ScenarioName) AS ScenarioName
    ,@ScenarioName AS [Status]
    ,@StatusDate AS StatusDate
    ,CAST(ClinicalSiteNumber AS NVARCHAR(256)) AS ScenarioSiteName
    ,ActualSite = 1
    ,MonthYear AS PatientRecruitmentDate
    ,TotalSubjectsEnrolled AS NumberofSubjects
    ,@ClinicalStudy AS ClinicalStudy
FROM clinical.StudySiteActuals
WHERE
    ClinicalStudy = @ClinicalStudy 



