CREATE proc [dbo].[spLoadFinacialModel] as

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spLoadFinacialModel Start')

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spLoadDisplayValueExplosion')

exec [dbo].[spLoadDisplayValueExplosion]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spLoadOMOrganizationHierarchy')

exec [dbo].[spLoadOMOrganizationHierarchy]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spTotalingAccount')

exec spTotalingAccount

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spDimAccount')

exec [dbo].[spDimAccount]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spDimFinancialCalendar')

exec [dbo].[spDimFinancialCalendar]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spDimDepartment')

exec [dbo].[spDimDepartment]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spDimHierarchy')

exec [dbo].[spDimHierarchy]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spDimProject')

exec [dbo].[spDimProject]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spDimTask')

exec [dbo].[spDimTask]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spD365SecurityMaster')

-- Reloads the Security Master. One record for each unique combination of entity an department
exec spD365SecurityMaster

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spD365Security')

-- Reloads the D365 security table. A record for each Entity/Dept that a user has access to
exec spD365Security

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spDimFinancialDimensions')

EXEC spDimFinancialDimensions

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spFactAccountingSourceExplorer')

EXEC spFactAccountingSourceExplorer

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spFactTransaction')

exec [dbo].[spFactTransaction]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spFactTransactionPL')
exec  [dbo].[spFactTransactionPL]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spPLAllocation')
exec spPLAllocation

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spEmployeeHierarchy')

exec spEmployeeHierarchy

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'PLAllocation')

exec [dbo].[spPLAllocation]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'PLCrosswalk')

exec [dbo].[spPLCrosswalk]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'LoadPLStage')

exec [dbo].[sp_LoadPLStage]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spLoadFinacialModel Complete')

-- Clean up RSMLogit
DELETE FROM mdr.RSMLogit WHERE DATEDIFF(d,RunTS,GETDATE())>90 