CREATE procedure [research].[GeneTerms_Create]
AS
BEGIN
-- SET NOCOUNT ON
/* Drop Indexes Tables */    
DROP INDEX IF EXISTS idx_EnsemblID_GeneTerms ON research.GeneTerms
DROP INDEX IF EXISTS idx_GeneTerm_GeneTerms ON research.GeneTerms
DROP INDEX IF EXISTS idx_GeneTermType_GeneTerms ON research.GeneTerms
DROP INDEX IF EXISTS idx_Species_GeneTerms ON research.GeneTerms
DROP INDEX IF EXISTS idx_GeneTermStatus_GeneTerms ON research.GeneTerms
DROP INDEX IF EXISTS idx_PrimarySymbol_GeneTerms ON research.GeneTerms
DROP INDEX IF EXISTS idx_PrimaryName ON research.GeneTerms

-- IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[research].[GeneTerms]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
-- DROP TABLE [research].[GeneTerms]
DELETE FROM research.GeneTerms

/*
CREATE TABLE [research].[GeneTerms]
(
	[EnsemblID] varchar(50) NULL,	-- EnsemblID associated with the compound at time of design derived from ISIS.
	[Species] varchar(50) NULL,	-- Common name of species associated with ensembl ID
	[GeneTerm] varchar(1000) NULL,	-- A gene symbol or name derived from ensembl based on the ensembl id.
	[GeneTermType] varchar(50) NULL,	-- Description of the GeneTerm, either a GeneSymbol or GeneName.
	[GeneTermStatus] varchar(50) NULL,	-- Term status is 'primary' for GeneSymbols if it is the canonical name in the ensembl database, all other symbols are extracted from the ensembl synonyms list for that gene. All GeneNames are primary names, there are no synonyms
	[GeneTermsID] int NOT NULL IDENTITY (1, 1),
	[PrimarySymbol] varchar(1000) NULL,
	[PrimaryName] varchar(1000) NULL
)
*/

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE [research].[GeneTerms] 
 ADD CONSTRAINT [PK_GeneTerms]
	PRIMARY KEY CLUSTERED ([GeneTermsID] ASC)

CREATE NONCLUSTERED INDEX [idx_EnsemblID_GeneTerms] 
 ON [research].[GeneTerms] ([EnsemblID] ASC)


CREATE NONCLUSTERED INDEX [idx_GeneTerm_GeneTerms] 
 ON [research].[GeneTerms] ([GeneTerm] ASC)

CREATE NONCLUSTERED INDEX [idx_GeneTermType_GeneTerms] 
 ON [research].[GeneTerms] ([GeneTermType] ASC)


CREATE NONCLUSTERED INDEX [idx_Species_GeneTerms] 
 ON [research].[GeneTerms] ([Species] ASC)

CREATE NONCLUSTERED INDEX [idx_GeneTermStatus_GeneTerms] 
 ON [research].[GeneTerms] ([GeneTermStatus] ASC)

CREATE NONCLUSTERED INDEX [idx_PrimarySymbol_GeneTerms] 
 ON [research].[GeneTerms] ([PrimarySymbol] ASC)

CREATE NONCLUSTERED INDEX [idx_PrimaryName] 
 ON [research].[GeneTerms] ([PrimaryName] ASC)
 
INSERT INTO [research].[GeneTerms]
(
	EnsemblID,
	Species,
	GeneTerm,
	GeneTermType,
	GeneTermStatus,
	PrimarySymbol,
    PrimaryName
    )
   (SELECT DISTINCT
    	cgt.EnsemblID,
	    cgt.Species,
	    cgt.GeneTerm,
	    cgt.GeneTermType,
	    cgt.GeneTermStatus,
        ISNULL(gs1.PrimarySymbol, '') as PrimarySymbol,
        ISNULL(gn1.PrimaryName, '') as PrimaryName
    FROM research.CompoundGeneTerms as cgt
	LEFT JOIN 
		(SELECT gs.EnsemblID, 
			 gs.GeneSymbol as PrimarySymbol
		FROM research.GeneSymbols as gs
		WHERE gs.GeneSymbolStatus = 'primary') as gs1
	ON gs1.EnsemblID = cgt.EnsemblID
    LEFT JOIN 
		(SELECT gn.EnsemblID, 
			 gn.GeneName as PrimaryName
		FROM research.GeneNames as gn
		WHERE gn.GeneNameStatus = 'primary') as gn1
	ON gn1.EnsemblID = cgt.EnsemblID
)

END
GO
