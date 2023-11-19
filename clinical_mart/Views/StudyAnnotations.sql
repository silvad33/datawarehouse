/****** Object:  View [clinical_mart].[StudyAnnotations]    Script Date: 4/29/2021 7:10:52 AM ******/

create view [clinical_mart].[StudyAnnotations] as 

SELECT
ClinicalStudyName
,sa.[Annotations]
      ,sa.[AnnotationType]
      ,sa.[StudyAnnotationsID]
      ,sa.[StudyRecruitmentID]
      ,sa.[CommentDate]

FROM Clinical.StudyAnnotations sa
inner join Clinical.StudyRecruitment sr
ON sa.StudyRecruitmentID = sr.StudyRecruitmentID
inner join Clinical.ClinicalStudy cs
ON sr.ClinicalStudyID = cs.ClinicalStudyID

