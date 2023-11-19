CREATE VIEW [dbo].[vwBuildingAccessUser]
AS
-- ***************Developer Info ***************
-- Date Created : 4/11/2020
-- Date Modified: 
-- Contact      : John O'Neill
-- Description  : Use the DimUser email and name for BuildingAccessUser reocrds where possible, otherwise use the values provided by managed badge table.
-- Notes        : 
-- *************** /Developer Info ***************
 SELECT 
    bac.BadgeNumber
    , ISNULL(du.FirstName,bac.FirstName) as FirstName
    , ISNULL(du.LastName,bac.LastName) as LastName
    , case 
      WHEN du.FirstName IS NULL THEN bac.FirstName + ' ' + bac.LastName
      ELSE du.FullName 
      END as FullName
   , ISNULL(du.Email,'') as Email
   , ISNULL(bac.BadgeStatus,'') as BadgeStatus
   ,ISNULL(bac.Company,'') as Company
   
 FROM BuildingAccessUser as bac 
 LEFT JOIN DimUser as du on bac.DimUserKey = du.UserKey

