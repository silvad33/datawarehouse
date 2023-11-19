
CREATE  PROCEDURE [dbo].[CompoundsAndGeneSymbols_Recreate]
AS
/*
    -- *************************************
    --  Deletes the existing derived table CompoundsAndGeneSymbols if it exists, then recreates it.
    --  See also:  Stored procedure in DataMart db to apply indices after table copy from here
    --  Intended use:  Monthly refresh of uber table for compounds and genes. Derived from other base tables in this db.
    --  After running this procedure, the resulting table will need to copied to the DataMart db (replacing the existing table)
    --  Warning:  This procedure will run for many minutes, and will consume much of the database CPU/resources while running.
    --  Author:  John O'Neill
    --  Modified: 11/13/2019.
    -- *************************************
*/
IF EXISTS(SELECT 1 FROM sys.Objects 
    WHERE  Object_id = OBJECT_ID(N'dbo.CompoundsAndGeneSymbols') 
           AND Type = N'U')
BEGIN
  DROP TABLE dbo.CompoundsAndGeneSymbols
END
    SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON

/*
CREATE TABLE [dbo].[CompoundsAndGeneSymbols](
	[compound_num] [varchar](50) NOT NULL,
	[term] [varchar](100) NOT NULL,
	[term_type] [varchar](50) NOT NULL,
	[target_type] [varchar](50) NULL,
	[status] [varchar](50) NOT NULL,
	[gene_symbol_status] [varchar](50) NULL,
	[gene_symbol] [varchar](50) NOT NULL,
	[ensembl_id] [varchar](100) NOT NULL,
	[species] [varchar](256) NOT NULL
) ON [PRIMARY]
*/

-- Qu.  do we need to temporarily boost the Azure db resource setting to increase performance during this bulk load?

SELECT 
cg.compound_num
,ct.term
,CASE
    when term_type = 'aso_num' then 'aso_number'
    else term_type
end as term_type
, cg.target_type
,[status]
,gs.gene_symbol_status
,gs.gene_symbol
,cg.ensembl_id
, cg.species

 INTO CompoundsAndGeneSymbols

FROM   (SELECT sy.compound_num, sy.compound_name 'term', sy.compound_name_type 'term_type', sy.compound_name_status 'status'
    FROM dbo.mdm_compound_names sy
UNION 
    SELECT sy.compound_num, sy.compound_num 'term', 'aso_number' 'term_type', 'current' 'status'
    FROM dbo.mdm_compound_names sy) as ct 

INNER JOIN [dbo].mdm_compound_genes as cg  on ct.compound_num = cg.compound_num
INNER JOIN mdm_gene_symbols as gs on cg.ensembl_id = gs.ensembl_id


