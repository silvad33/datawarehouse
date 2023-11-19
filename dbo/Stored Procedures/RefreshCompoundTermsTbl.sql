
CREATE  PROCEDURE [dbo].[RefreshCompoundTermsTbl]
AS
/*
    -- *************************************
    --  Deletes all rows in the derived 'mdm_compound_termsTbl' table (used in Pubs API lookups), and then repopulates rows from the underlying source tables.
    --  See also:  Stored procedure RefreshPubsApiTables.
    --  Intended use:  Usually called from the stored procedure RefreshPubsApiTables, which will check for last modification dates before runnning this long process.
    --  Author:  John O'Neill
    --  Modified: 10/30/2019.
    -- *************************************
*/
DELETE FROM dbo.mdm_compound_termsTbl;

INSERT INTO dbo.mdm_compound_termsTbl (compound_num,term,term_type, [status],[gene_symbol], ensembl_id, species)


SELECT
cg.compound_num
,ct.term
, cg.target_type as 'term_type'
,gs.gene_symbol_status as 'status'
,gs.gene_symbol
,cg.ensembl_id
, cg.species
FROM   (SELECT sy.compound_num, sy.compound_name 'term', sy.compound_name_type 'term_type', sy.compound_name_status 'status'
    FROM dbo.mdm_compound_names sy) as ct -- see view mdm_compound_terms

INNER JOIN [dbo].mdm_compound_genes as cg  on ct.compound_num = cg.compound_num --AND ct.[status] = 'current'

INNER JOIN mdm_gene_symbols as gs on cg.ensembl_id = gs.ensembl_id
