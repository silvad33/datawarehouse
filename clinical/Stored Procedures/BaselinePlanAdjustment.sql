CREATE  PROCEDURE [clinical].[BaselinePlanAdjustment]

 @ScenarioName VARCHAR(2500),
 @ClinicalStudy VARCHAR(50),
 @Status VARCHAR(50),
 @NewScreenFailRate INT,
 @ActivationDate DATE,
 @StatusDate DATETIME


AS


DECLARE @CurrentScreenFailRate INT 
DECLARE @AdjustedScreenFailRate NUMERIC(18,2)

SET @CurrentScreenFailRate = (SELECT MAX(ScreenFailureRate) FROM clinical.ScenarioParameters SP JOIN clinical.RecruitmentScenarios RS ON SP.ScenarioParametersID = RS.ScenarioParametersID WHERE RS.ClinicalStudyName = @ClinicalStudy)
SET @AdjustedScreenFailRate = ((@CurrentScreenFailRate*1.00 - @NewScreenFailRate*1.00)/100)

INSERT INTO clinical.ScenarioBuilderOutput
SELECT 
    CONCAT(CONCAT(@ClinicalStudy, '_'),@ScenarioName) AS ScenarioName
    ,@ScenarioName AS [Status]
    ,@StatusDate AS StatusDate
    ,CAST(ScenarioSiteName AS NVARCHAR(256)) AS ScenarioSiteName
    ,ActualSite
    ,PatientRecruitmentDate
    ,CASE
        WHEN @AdjustedScreenFailRate < 0 
        THEN NumberofSubjects - NumberofSubjects*ABS(@AdjustedScreenFailRate)
        WHEN @AdjustedScreenFailRate > 0 
        THEN NumberofSubjects + NumberofSubjects*ABS(@AdjustedScreenFailRate)
        WHEN @AdjustedScreenFailRate = 0 OR @AdjustedScreenFailRate IS NULL 
        THEN NumberofSubjects
    END AS NumberofSubjects
    ,@ClinicalStudy AS ClinicalStudy 
FROM clinical.RecruitmentScenarios
WHERE
    CAST(PatientRecruitmentDate AS DATE) >= @ActivationDate
    AND ClinicalStudyName = @ClinicalStudy
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
UNION ALL 
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
    CAST(PatientRecruitmentDate AS DATE) < @ActivationDate
    AND ClinicalStudyName = @ClinicalStudy
    AND [Status] = @Status


