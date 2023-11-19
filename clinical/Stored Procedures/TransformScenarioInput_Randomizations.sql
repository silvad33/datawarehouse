CREATE PROCEDURE [clinical].[TransformScenarioInput_Randomizations] 
AS

DECLARE @ClinicalStudy VARCHAR(50)
DECLARE @Site NVARCHAR(256)
DECLARE @SiteID INT 
DECLARE @SitesAdded INT 
DECLARE @FirstMonth DATE 
DECLARE @MonthLoop INT 
DECLARE @NumberofMonths INT 
DECLARE @ScenarioName VARCHAR(256) 
DECLARE @PatientRunIn INT 
DECLARE @Residual NUMERIC(18,2) 
DECLARE @NumSub NUMERIC(18,2)
DECLARE @Plan NVARCHAR(256)
DECLARE @StatusDate DATETIME
DECLARE @CurrentScenarioBuilderID INT
--DECLARE @NewRandomizationRate INT
DECLARE @ActivationDate DATETIME

SET @CurrentScenarioBuilderID = (SELECT MAX(ScenarioBuilderID) FROM clinical.ScenarioBuilderInput)
--SET @NewRandomizationRate = (SELECT RandomizationRatePct FROM clinical.ScenarioBuilderInput WHERE ScenarioBuilderID = @CurrentScenarioBuilderID)
SET @ActivationDate = (SELECT DATEADD(m,DATEDIFF(m,0,ActivationDate),0) ActivationDate FROM clinical.ScenarioBuilderInput WHERE ScenarioBuilderID = @CurrentScenarioBuilderID)
SET @ClinicalStudy = (SELECT ClinicalStudy FROM clinical.ScenarioBuilderInput WHERE ScenarioBuilderID = @CurrentScenarioBuilderID)
SET @SiteID = 1
SET @SitesAdded = (SELECT NumberofSites FROM clinical.ScenarioBuilderInput WHERE ScenarioBuilderID = @CurrentScenarioBuilderID)
SET @FirstMonth = (SELECT DATEADD(m,DATEDIFF(m,0,ActivationDate),0) FROM   clinical.scenariobuilderinput WHERE  scenariobuilderid = @CurrentScenarioBuilderID) 
SET @MonthLoop = 0 
SET @NumberofMonths = (SELECT DATEDIFF(M, ActivationDate, EnrollmentCompletionDate) FROM clinical.ScenarioBuilderInput WHERE ScenarioBuilderID = @CurrentScenarioBuilderID)
SET @ScenarioName = (SELECT scenarioname FROM   clinical.scenariobuilderinput WHERE  scenariobuilderid = @CurrentScenarioBuilderID) 
SET @PatientRunIn = (SELECT patientrunin FROM   clinical.scenariobuilderinput WHERE  scenariobuilderid = @CurrentScenarioBuilderID) 
SET @Residual = 0  
SET @Plan = (SELECT BaselinePlan FROM clinical.ScenarioBuilderInput WHERE ScenarioBuilderID = @CurrentScenarioBuilderID)
SET @StatusDate = GETDATE()

DELETE FROM Clinical.ScenarioBuilderOutput WHERE [Status] = @ScenarioName

-- Loop through each site-month and insert into Recruitment Scenarios 
WHILE ( @SiteID <= @SitesAdded ) 
  BEGIN 
      WHILE ( @MonthLoop <= @NumberofMonths ) 
        BEGIN 
            SELECT @NumSub = NumberofPatients + @Residual
            FROM   clinical.scenariobuilderinput 
            WHERE  scenariobuilderid = (SELECT Max(scenariobuilderid) 
                                        FROM   clinical.scenariobuilderinput)  

            SET @Residual = @NumSub - ( @NumSub%1 ) 

          INSERT INTO Clinical.ScenarioBuilderOutput 
          SELECT 
                 Concat(Concat(@ClinicalStudy, '_'), @ScenarioName) AS ScenarioName, 
                 [Status] = @ScenarioName, 
                 StatusDate = @StatusDate, 
                 ScenarioSiteName = CONCAT('S', @SiteID), 
                 ActualSite = 0, 
                 PatientRecruitmentDate = Dateadd(MONTH, @MonthLoop, @FirstMonth), 
                 @Residual AS NumberofSubjects, 
                 ClinicalStudy = @ClinicalStudy
          FROM   clinical.scenariobuilderinput 
          WHERE  scenariobuilderid = (SELECT Max(scenariobuilderid) FROM clinical.scenariobuilderinput) 
      
          SET @MonthLoop = @Monthloop + 1
          SET @Residual = (@NumSub%1)
          SET @NumSub = 0

      END 

SET @MonthLoop = 0 
SET @SiteID = @SiteID + 1 
  
  END 



EXECUTE clinical.BaselinePlanAdjustment_Randomizations
    @ScenarioName,
    @ClinicalStudy,
    @Plan,
    --@NewRandomizationRate,
    @ActivationDate,
    @StatusDate








