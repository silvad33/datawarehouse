CREATE PROC [dbo].[spTotalingAccount]
AS

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spTotalingAccountExplosion')

EXEC [dbo].[spTotalingAccountExplosion]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spTotalAccountsCheck')

EXEC [dbo].[spTotalAccountsCheck]

Insert into mdr.RSMLogit (RunTS,RunProcess)
Values (getdate(),'spTotalingAccountInsert')

EXEC [dbo].[spTotalingAccountInsert]


