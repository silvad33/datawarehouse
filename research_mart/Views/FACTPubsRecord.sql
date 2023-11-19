CREATE VIEW [research_mart].[FACTPubsRecord] AS 
-- ***************Developer Info ***************
-- Date Created : 4/11/2020
-- Date Modified: 10/18/2021
-- Contact      : John O'Neill
-- Note         : Changed PubsId to PubsKey in join
-- *************** /Developer Info ***************

SELECT pu.PubsKey 
,pu.PubsID
, pu.Title
, pu.PubsType
,ISNULL(CONVERT(varchar, pu.SubmissionDeadline,110),'') as 'Submission Deadline'
,ISNULL( duRp.FullName,'') as 'Responsible Party' 
,ISNULL( duCreatedBy.FullName,'') as 'Submitter' 
, 'Ionis Authors' = ISNULL( (SELECT  STUFF((
                Select ',' +  authUser.FullName 
                FROM  [dbo].[DIMUser] as authUser 
                INNER JOIN  [research].[PubsRecordIonisAuthor] as auths ON authUser.UserKey =  auths.IonisAuthorKey
                Where auths.PubsKey = pu.PubsKey 
                FOR XML PATH('')
                ) ,1,1,'')), '')
,ISNULL(pu.ExternalAuthors,'') as 'External Authors'
, 'Compounds' = ISNULL( (SELECT  STUFF((
                Select ',' +  prc.CompoundNumber
                FROM[research].[PubsRecordCompound]  as prc
                Where prc.PubsKey = pu.PubsKey 
                FOR XML PATH('')
                ) ,1,1,'')), '')
, 'Targets' = ISNULL( (SELECT  STUFF((
                Select ',' +  prt.SelectedTerm
                FROM[research].[PubsRecordTarget]  as prt
                Where prt.PubsKey = pu.PubsKey 
                FOR XML PATH('')
                ) ,1,1,'')), '')
, ISNULL(pu.UserComments,'') as 'Comments'
, ISNULL(sc.SubmissionContent,'') as 'Submission Content Type'
, 'Content Data Type' = ISNULL( (SELECT  STUFF((
                Select ',' +  scd.Title 
                FROM [research].[PubsSubmissionContentDataType] as scd
                INNER JOIN [research].[PubsRecordSubmissinContentDataType] as pscd ON scd.PubsSubmissionContentDataTypeID =  pscd.PubsSubmissionContentDataTypeID
                Where pscd.PubsKey = pu.PubsKey 
                FOR XML PATH('')
                ) ,1,1,'')), '')
, 'Franchise' = ISNULL( (SELECT  STUFF((
                Select ',' +  fr.Franchise 
                FROM [research].[PubsFranchise] as fr
                INNER JOIN [research].[PubsRecordFranchise] as prf ON fr.PubsFranchiseID =  prf.PubsFranchiseID
                Where prf.PubsKey = pu.PubsKey 
                FOR XML PATH('')
                ) ,1,1,'')), '')
, 'Functional Area' = ISNULL( (SELECT  STUFF((
                Select ',' +  fa.Functional 
                FROM [research].[PubsFunctionalArea] as fa
                INNER JOIN [research].[PubsRecordFunctionalArea] as prfa ON fa.PubsFunctionalAreaID =  prfa.PubsFunctionalAreaID
                Where prfa.PubsKey = pu.PubsKey 
                FOR XML PATH('')
                ) ,1,1,'')), '')
, ISNULL(pu.IonisClinicalStudyCSNum,'') as  'Ionis Clinical Study Num'
, ISNULL (pu.ClinicalTrialRegistryIDNCTNum,'') as  'Clinical Trial Reg Num'
, ISNULL (pu.BookTitle,'') as  'Book Title'
, ISNULL (pu.BookChapter,'') as  'Book Chapter'
, ISNULL (pu.Editor,'') as  'Editor'
, ISNULL (pu.Edition,'') as  'Edition'
, ISNULL (pu.Volume,'') as  'Volume'
, ISNULL (pu.PresentationType,'') as  'Presentation Type'
, ISNULL (pu.Explain,'') as  'Explanation'
, ISNULL(m.MeetingTitle,'') as 'Meeting'
, CASE
    WHEN  pu.NeedAbstract = 'true' THEN 'Yes'
    ELSE 'No'
END AS 'Needs Abstract'
, ISNULL(pu.Presenters,'') as 'Presenters'
, ISNULL(pu.ComplianceRelated,'') as 'ComplianceRelated'
, ISNULL(pu.SubmissionStatus,'') as 'SubmissionStatus'
, ISNULL(j.JournalTItle,'') as 'Journal'
,ISNULL(pu.ApprovalStatus,'Not Started') as 'Approval Status'
, ISNULL(Convert(Varchar,pu.LastWfStartTime,110),'') as 'Approval Started'
, ISNULL(Convert(Varchar,pu.CompletedTime,110),'') as 'Approval Ended'
, ISNULL(pu.Comments,'') as 'Approval Comments'
, CASE
    WHEN  pu.Expedited = 'true' THEN 'Yes'
    ELSE 'No'
END AS 'Expedited Workflow'

, ISNULL(assocR.Title,'') as 'Associated Record'
, pu.Version as 'Pubs Version'
,CONVERT(varchar, pu.Created,110) as 'Created on'
,pu.CompletedTime
,m.PubsMeetingID
,j.JournalID
,duCreatedBy.UserKey as 'Submitter User Key'
,pu.ResponsiblePartyKey
,CASE 
    when pu.[Version] = 2 then CONCAT('https://isispharm.sharepoint.com/sites/pubs/SitePages/Publication-Detail.aspx?itemid=',pu.PubsID)
    else 
   CONCAT('https://isispharm.sharepoint.com/sites/pubs/Lists/PubsLegacy/DispForm.aspx?ID=',pll.SpLegacyListId)
END AS 'Pubs Link'
FROM[research].[PubsRecord] as pu 
LEFT JOIN[dbo].[DimUser] as duRp on pu.ResponsiblePartyKey = duRp.UserKey
LEFT JOIN[dbo].[DimUser] as duCreatedBy on pu.CreatedBy = duCreatedBy.UserKey
LEFT JOIN[research].[PubsRecord] as assocR on pu.AssociatedRecordKey = assocR.PubsKey
LEFT JOIN[research].[PubsSubmissionContent] as sc ON pu.SubmissionContentID = sc.SubmissionContentKey
LEFT JOIN[research].[PubsJournals] as j on pu.JournalLinkedID = j.JournalID
LEFT JOIN[research_mart].[PubsMeeting] as m on pu.MeetingLinkedID = m.PubsMeetingID
LEFT JOIN[research].[PubsLegacyLookup] as pll ON pu.PubsKey = pll.PubsKey
GO
