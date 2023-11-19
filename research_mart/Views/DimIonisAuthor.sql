CREATE VIEW [research_mart].[DimIonisAuthor] AS 
(

  SELECT m.[PubsKey],m.[IonisAuthorKey],f.[FullName] as 'Author Name'
  , f.[UserName] as 'Author UserName', f.[CoupaUserID] as 'Author CoupaUserID'
  , f.[EmployeeNumber] as 'Author Employee Number'
  , f.[Email], f.[DepartmentKey], f2.[FullName] as 'Author Manager Name'
  , f2.[UserKey] as ManagerUserKey, d.DepartmentDescription as 'Author Dept. Description'
  , d.DepartmentNumber as 'Author Dept. #'
  , d.DepartmentNumberDescription as 'Author Dept. Number Description'
  FROM  [research].[PubsRecordIonisAuthor]  m
  LEFT JOIN 
    [dbo].[DimUser]  f
  ON
    m.[IonisAuthorKey]=f.[UserKey]
  LEFT JOIN 
	[dbo].[DimUser]  f2
  ON f.[ManagerKey]= f2.[UserKey]

  LEFT JOIN 
	[dbo].[DimDepartment]  d
  ON d.[DepartmentKey]= f.[DepartmentKey]
)
GO
