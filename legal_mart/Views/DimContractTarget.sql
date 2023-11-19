CREATE VIEW [legal_mart].[DimContractTarget]
AS
SELECT [IsEncumbred]
      ,[MTID]
      ,[ContractTargetID]
      ,[LegalContractsID]
FROM [legal].[ContractTarget]