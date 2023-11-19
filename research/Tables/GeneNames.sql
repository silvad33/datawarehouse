/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 15.2 		*/
/*  Created On : 12-Feb-2021 3:13:30 PM 				*/
/*  DBMS       : SQL Server 2012 						*/
/* ---------------------------------------------------- */

/* Create Tables */

CREATE TABLE [research].[GeneNames]
(
	[EnsemblID] varchar(50) NULL,
	[GeneName] varchar(1000) NULL,
	[Species] varchar(50) NULL,
	[GeneNameStatus] varchar(50) NULL,
	[DateCreated] datetime NULL DEFAULT getdate(),
	[DateModified] datetime NULL,
	[GeneNamesID] int NOT NULL IDENTITY (1, 1)
)
GO

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE [research].[GeneNames] 
 ADD CONSTRAINT [PK_GeneNames]
	PRIMARY KEY CLUSTERED ([GeneNamesID] ASC)
GO

ALTER TABLE [research].[GeneNames] 
 ADD CONSTRAINT [unique_EnsemblIDName] UNIQUE NONCLUSTERED ([EnsemblID] ASC,[GeneName] ASC)
GO

CREATE NONCLUSTERED INDEX [INDX_EnsemblID_GeneNames] 
 ON [research].[GeneNames] ([EnsemblID] ASC)
GO

CREATE NONCLUSTERED INDEX [INDX_GeneName_GeneNames] 
 ON [research].[GeneNames] ([GeneName] ASC)
GO

CREATE NONCLUSTERED INDEX [INDX_Species_GeneNames] 
 ON [research].[GeneNames] ([Species] ASC)
GO