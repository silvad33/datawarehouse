/*
Purpose: <enter a purpose here...>
*/

CREATE VIEW [financial_mart].[POSecurity] AS

SELECT [ReportsToEMail],
	[EmployeeFullName],
	[Department_Number],
	[SecurityKey]
FROM [dbo].[EmployeeHierarchy]
GO