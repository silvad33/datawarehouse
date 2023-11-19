CREATE VIEW [legal_mart].[DimLegalOrganization]
AS
SELECT [CongaCompanyID]
      ,[OrganizationName]
      ,[OrganizationNumber]
      ,[CompanyGroup]
      ,[DunsNumber]
      ,[OrganizationType]
      ,[OrganizationCategory]
      ,[OrganizationStatus]
      ,lo.[LegalOrganizationID]
      ,[OrganizationID]
FROM [legal].[LegalOrganization] lo, [shared].[Organization] o
WHERE lo.LegalOrganizationID = o.LegalOrganizationID