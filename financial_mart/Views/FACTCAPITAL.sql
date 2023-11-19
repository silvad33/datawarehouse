CREATE VIEW [financial_mart].[FACTCAPITAL]
  AS 

SELECT
  CAP.EntityKey,
  E.EntityID,
  E.EntityDescription,
  CAP.DepartmentKey,
  D.DepartmentNumber,
  D.DepartmentDescription,
  D.DepartmentNumberDescription,
  CAP.CapitalID,
  CAP.AccountKey,
  A.MainAccountNumber,
  A.MainAccountDescription,
  A.MainAccountNumberDescription,
  P.ProjectKey,
  P.ProjectNumber,
  P.ProjectDescription,
  P.ProjectNumberDescription,
  T.TaskKey,
  T.TaskNumber,
  T.TaskDescription,
  T.TaskNumberDescription,
  CAP.SupplierKey,
  S.D365SupplierID,
  S.SupplierName,
  CAP.CaseName,
  CAP.Prioritization,
  CAP.[Description],
  CAP.Notes,
  CAP.Amount,
  CAP.PurchaseDate,
  CAP.[InServiceDate],
  CAP.[EULOverride]  
FROM [financial].[Capital] AS CAP
  INNER JOIN DimEntity AS E ON CAP.EntityKey = E.EntityKey
  INNER JOIN DimDepartment AS D ON CAP.DepartmentKey = D.DepartmentKey
  INNER JOIN DimAccount AS A ON CAP.AccountKey = A.AccountKey
  INNER JOIN DimProject AS P ON CAP.ProjectKey = P.ProjectKey
  INNER JOIN DimTask AS T ON CAP.TaskKey = T.TaskKey
  LEFT OUTER JOIN DimSupplier AS S ON CAP.SupplierKey = S.SupplierKey