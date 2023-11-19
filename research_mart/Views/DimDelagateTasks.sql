CREATE VIEW [research_mart].[DimDelagateTasks] AS 
SELECT ats.[TaskID]
      ,ats.[PubsKey]
      ,ats.[ApprovalRole]
      ,ats.[Status]
      ,ats.[AssignedToKey]
      ,ISNULL(du.FullName,'') as 'Approver'
      ,ats.[TaskCompleted]
      ,ats.[TaskOutcome]
      ,ats.[DelegateAdded]
      ,ats.[DelegateKey]
      ,ISNULL(du2.FullName,'') as 'Delegator'
      ,ats.[TaskComments]
      ,ats.[UserComments]
      ,ats.[Created]
      ,ats.[Modified] as 'Completed'
      , CASE
    WHEN  ats.Created > pub.[Approval Started] THEN 'Yes'
    ELSE 'No'
    END AS 'LatestTask'

FROM [research].[PubsApprovalTasks]  as ats
LEFT JOIN [dbo].[DimUser] as du on du.UserKey=ats.AssignedToKey
LEFT JOIN [dbo].[DimUser] as du2 on du2.UserKey=ats.DelegateKey
LEFT JOIN [research_mart].[FACTPubsRecord] as pub on ats.PubsKey=pub.PubsKey
where [TaskOutcome]='Delegate'
GO
