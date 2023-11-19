create view clinical_mart.ScenarioData as 

SELECT CONCAT(CONCAT(ClinicalStudy, '_'),'Actual')ScenarioName
,[Status] = 'Actual'
,StatusDate = GETDATE()
,ClinicalSiteNumber AS ScenarioSiteName
,ActualSite = 1
,MonthYear AS PatientRecruitmentDate
,TotalSubjectsEnrolled AS NumberofSubjects
,ClinicalStudy as ClinicalStudyName
,RequiredSubjects
FROM clinical.studysiteactuals SSA
JOIN 
(SELECT DISTINCT ClinicalStudyName
,MAX(TotalSubjectsRequired) AS RequiredSubjects
FROM clinical.recruitmentscenarios RS
JOIN clinical.ScenarioParameters SP    
ON RS.ScenarioParametersID = SP.ScenarioParametersID
GROUP BY ClinicalStudyName) RS    
ON SSA.ClinicalStudy = RS.ClinicalStudyName
UNION ALL
SELECT ScenarioName
,[Status]
,StatusDate
,ScenarioSiteName
,ActualSite
,PatientRecruitmentDate
,NumberofSubjects,ClinicalStudyName AS ClinicalStudy
,MAX(TotalSubjectsRequired) AS RequiredSubjects
FROM clinical.recruitmentscenarios RS JOIN clinical.ScenarioParameters SP    
ON RS.ScenarioParametersID = SP.ScenarioParametersID
GROUP BY ScenarioName,[Status],StatusDate,ScenarioSiteName,ActualSite,PatientRecruitmentDate,NumberofSubjects,ClinicalStudyName 
UNION ALL
SELECT ScenarioName,[Status],StatusDate,ScenarioSiteName,ActualSite,PatientRecruitmentDate,NumberofSubjects,ClinicalStudy,RS.RequiredSubjects
FROM clinical.ScenarioBuilderoutput SBO
JOIN 
(SELECT DISTINCT ClinicalStudyName,MAX(TotalSubjectsRequired) AS RequiredSubjects
FROM clinical.recruitmentscenarios RS 
JOIN clinical.ScenarioParameters SP    
ON RS.ScenarioParametersID = SP.ScenarioParametersID
GROUP BY ClinicalStudyName) RS    
ON SBO.ClinicalStudy = RS.ClinicalStudyName
WHERE [Status] IN (SELECT Distinct ScenarioName FROM Clinical.ScenarioBuilderInput)