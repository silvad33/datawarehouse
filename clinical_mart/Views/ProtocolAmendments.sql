create view clinical_mart.ProtocolAmendments as
SELECT  [DocumentType]
      ,[Comments]
      ,[Country]
      ,[ApprovedDate]
      ,[ClinicalStudyDocumentsID]
      ,[ClinicalStudyDocumentNumber]
      ,b.ClinicalStudyName
  FROM [clinical].[ClinicalStudyDocuments] a
  inner join
[clinical].[ClinicalStudy] b
on a.ClinicalStudyID = b.ClinicalStudyID 