CREATE VIEW [legal_mart].[DimContractTypes]
AS
SELECT [ContractContractTypesID]
      ,[LegalContractsID]
      ,[ContractType]
FROM [legal].[ContractContractTypes] cct, [legal].[ContractTypes] ct
WHERE cct.ContractTypesID = ct.ContractTypesID