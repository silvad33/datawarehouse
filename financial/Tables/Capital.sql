CREATE TABLE [financial].[Capital](
  CapitalKey INT NOT NULL IDENTITY (1, 1),
	InternalID CHAR(10) NOT NULL,
  EntityKey INT NOT NULL,
  DepartmentKey INT NOT NULL,
  CapitalID VARCHAR(50) NOT NULL,
  AccountKey INT NOT NULL,
	ProjectKey INT NOT NULL,
	TaskKey INT NOT NULL,
	SupplierKey INT,
	CaseName VARCHAR(100),
	Prioritization VARCHAR(100),
	[Description] VARCHAR(500),
	[Notes] VARCHAR(MAX),
  Amount FLOAT,
  PurchaseDate DATE,
  InServiceDate DATE,
  EULOverride VARCHAR(500)
)
GO
/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE [financial].[Capital]
 ADD CONSTRAINT [PK_Capital]
	PRIMARY KEY CLUSTERED ([CapitalKey] ASC)
GO