CREATE procedure [research].[CompoundGeneTerms_Create]
AS
BEGIN
-- SET NOCOUNT ON
/* Drop Indexes Tables */    
DROP INDEX IF EXISTS idx_CompoundTerm_CompoundGeneTerms ON research.CompoundGeneTerms
DROP INDEX IF EXISTS idx_CompoundNumber_CompoundGeneTerms ON research.CompoundGeneTerms
DROP INDEX IF EXISTS idx_EnsemblID_CompoundGeneTerms ON research.CompoundGeneTerms
DROP INDEX IF EXISTS idx_GeneTerm_CompoundGeneTerms ON research.CompoundGeneTerms
DROP INDEX IF EXISTS idx_GeneTermType_CompoundGeneTerms ON research.CompoundGeneTerms
DROP INDEX IF EXISTS idx_GeneTermStatus_CompoundGeneTerms ON research.CompoundGeneTerms
DROP INDEX IF EXISTS idx_Species_CompoundGeneTerms ON research.CompoundGeneTerms

-- IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[research].[CompoundGeneTerms]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [research].[CompoundGeneTerms]

DELETE FROM research.CompoundGeneTerms

/* Create Tables */

/* CREATE TABLE [research].[CompoundGeneTerms]
(
	[CompoundNumber] varchar(50) NULL,
	[CompoundTerm] varchar(50) NULL,
	[CompoundTermType] varchar(50) NULL,
	[CompoundTermStatus] varchar(50) NULL,
	[EnsemblID] varchar(50) NULL,
	[Species] varchar(50) NULL,
	[TargetType] varchar(50) NULL,
	[TargetObsolete] bit NULL,
	[GeneTerm] varchar(1000) NULL,
	[GeneTermType] varchar(50) NULL,
	[GeneTermStatus] varchar(50) NULL,
	[CompoundGeneTermsID] int IDENTITY(1,1) NOT NULL
)
*/
-- delete from research.CompoundGeneTerms
INSERT INTO research.CompoundGeneTerms (CompoundNumber
    , EnsemblID
    , Species
    , TargetType
    , TargetObsolete
    , CompoundTerm
    , CompoundTermType
    , CompoundTermStatus 
    , GeneTerm
    , GeneTermType
    , GeneTermStatus)
    (SELECT cgn.CompoundNumber
        , cgn.EnsemblID
        , cgn.Species
        , cgn.TargetType
        , cgn.TargetObsolete
        , cgn.CompoundTerm
        , cgn.CompoundTermType
        , cgn.CompoundTermStatus 
        , gss.GeneTerm
        , gss.GeneTermType
        , gss.GeneTermStatus
        FROM    
            (SELECT DISTINCT cg.CompoundNumber
                , cg.EnsemblID
                , cg.SpeciesName as Species
                , cg.TargetType
                , cg.Obsolete as TargetObsolete
                , cn.CompoundName as CompoundTerm
                , cn.CompoundNameType as CompoundTermType
                , cn.CompoundNameStatus as CompoundTermStatus
            FROM research.CompoundGenes as cg
            INNER JOIN
                research.CompoundNames as cn 
                ON cg.CompoundNumber = cn.CompoundNumber) as cgn
            LEFT JOIN 
                (SELECT gs.EnsemblID
                    , gs.GeneSymbol as GeneTerm
                    , 'GeneSymbol' as GeneTermType
                    , gs.GeneSymbolStatus as GeneTermStatus
                FROM research.GeneSymbols as gs
                WHERE GeneSymbol != 'No Synonyms'
                UNION
                SELECT gn.EnsemblID
                    , gn.GeneName as GeneTerm
                    , 'GeneName' as GeneTermType
                    , gn.GeneNameStatus as GeneTermStatus
                FROM research.GeneNames as gn) as gss
                ON gss.EnsemblID = cgn.EnsemblID)





/* Create Primary Keys, Indexes, Uniques, Checks */

CREATE NONCLUSTERED INDEX [idx_CompoundTerm_CompoundGeneTerms] 
 ON [research].[CompoundGeneTerms] ([CompoundTerm] ASC)


CREATE NONCLUSTERED INDEX [idx_CompoundNumber_CompoundGeneTerms] 
 ON [research].[CompoundGeneTerms] ([CompoundNumber] ASC)


CREATE NONCLUSTERED INDEX [idx_EnsemblID_CompoundGeneTerms] 
 ON [research].[CompoundGeneTerms] ([EnsemblID] ASC)


CREATE NONCLUSTERED INDEX [idx_GeneTerm_CompoundGeneTerms] 
 ON [research].[CompoundGeneTerms] ([GeneTerm] ASC)

CREATE NONCLUSTERED INDEX [idx_GeneTermType_CompoundGeneTerms]
 ON [research].[CompoundGeneTerms]([GeneTermType] ASC)

CREATE NONCLUSTERED INDEX [idx_Species_CompoundGeneTerms]
 ON [research].[CompoundGeneTerms]([Species] ASC)

CREATE NONCLUSTERED INDEX [idx_GeneTermStatus_CompoundGeneTerms]
 ON [research].[CompoundGeneTerms]([GeneTermStatus] ASC)

DELETE FROM research.CompoundGeneTerms 
WHERE CompoundGeneTermsID IN
    (select c.InferredID FROM
        (SELECT a.CompoundNumber
            , a.CompoundTerm
            , a.EnsemblID
            , a.TargetType
            , a.GeneTerm
            , a.GeneTermStatus
            , a.CompoundGeneTermsID
            , b.CompoundGeneTermsID InferredID
        FROM research.CompoundGeneTerms a 
        INNER JOIN research.CompoundGeneTerms b
        ON a.CompoundNumber = b.CompoundNumber AND 
            a.CompoundTerm = b.CompoundTerm AND
            a.EnsemblID = b.EnsemblID AND 
            a.GeneTerm = b.GeneTerm
        WHERE a.TargetType = 'intended'
            AND b.TargetType = 'inferred') c)

END

