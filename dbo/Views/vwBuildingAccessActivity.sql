CREATE VIEW [dbo].[vwBuildingAccessActivity]
AS
-- *************** View Info ***************
-- Date Created : 3/12/2020
-- Date Modified: 
-- Contact      : John O'Neill
-- Description  : Return MINIMUM daily badge acitivity information for each user - one entry for each day where the user swiped a card on a door access panel
--              :  We don't show which door, swipe times,etc.  This view is used to track whether or not somebody entered a building on a given day (for COVID-19 tracking)
-- Notes        : 
-- *************** /View Info ***************

WITH uniqueBadgesPerDay AS (
SELECT DISTINCT bat.BadgeNumber
,Convert(date,bat.ActivityDate) as BadgeActivityDate
FROM BuildingAccessActivity as bat
GROUP BY bat.BadgeNumber,Convert(date,bat.ActivityDate)
)

SELECT ubd.BadgeActivityDate, bau.* from vwBuildingAccessUser as bau
INNER JOIN uniqueBadgesPerDay as ubd on bau.BadgeNumber = ubd.BadgeNumber

