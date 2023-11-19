CREATE VIEW [dbo].[vwEmployeeVaccinatedStatus] AS 
-- ***************Developer Info ***************
-- Date Created : 6/21/2021
-- Date Modified: 6/21/2021
-- Contact      : Harry Chen
-- Note         : covi-19 new form updated since 6/18/2021
-- *************** /Developer Info ***************

   SELECT distinct er.[FullName]
      , LOWER(er.Email) as Email
	  , CASE
         WHEN  er.Email in (SELECT distinct [Email] FROM [dbo].[CovidEmployeeResponse] 
		 where CreatedDateTime >= '2021-06-18 00:00:00.000' 
		 AND  ResponseId = 1
			
		 )	 
		 THEN 'Yes'
         ELSE 'No'
		END AS 'Vaccinated'

  FROM [dbo].[CovidEmployeeResponse]  as er
  where CreatedDateTime >= '2021-06-18 00:00:00.000'
  
GO