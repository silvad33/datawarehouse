/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 15.2 		*/
/*  Created On : 11-Feb-2021 10:26:11 AM 				*/
/*  DBMS       : SQL Server 2012 						*/
/* ---------------------------------------------------- */

/* Drop Tables */

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[legal].[CongaPerson]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [legal].[CongaPerson]
GO

/* Create Tables */

CREATE TABLE [legal].[CongaPerson]
(
	[DimUserID] int NULL,
	[ExternalFirstName] varchar(50) NULL,
	[ExternalLastName] varchar(50) NULL,
	[ExternalEmail] varchar(50) NULL,
	[LegalOrganizationID] int NULL,
	[CongaPersonID] int NOT NULL IDENTITY (1, 1)
)
GO

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE [legal].[CongaPerson] 
 ADD CONSTRAINT [PK_Congaperson]
	PRIMARY KEY CLUSTERED ()
GO

CREATE NONCLUSTERED INDEX [INDX_ExternalLastName] 
 ON [legal].[CongaPerson] ([ExternalLastName] ASC)
GO

CREATE NONCLUSTERED INDEX [INDX_ExternalFirstName] 
 ON [legal].[CongaPerson] ([ExternalFirstName] ASC)
GO

CREATE NONCLUSTERED INDEX [INDX_DimUserID] 
 ON [legal].[CongaPerson] ([DimUserID] ASC)
GO