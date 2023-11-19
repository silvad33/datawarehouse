CREATE TABLE [dbo].[CompoundsAndGeneSymbols] (
    [compound_num]       VARCHAR (50)  NOT NULL,
    [term]               VARCHAR (100) NOT NULL,
    [term_type]          VARCHAR (50)  NOT NULL,
    [target_type]        VARCHAR (50)  NULL,
    [status]             VARCHAR (50)  NOT NULL,
    [gene_symbol_status] VARCHAR (50)  NULL,
    [gene_symbol]        VARCHAR (50)  NOT NULL,
    [ensembl_id]         VARCHAR (100) NOT NULL,
    [species]            VARCHAR (256) NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_compoundNum_CompoundsAndGeneSymbols]
    ON [dbo].[CompoundsAndGeneSymbols]([compound_num] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_term_CompoundsAndGeneSymbols]
    ON [dbo].[CompoundsAndGeneSymbols]([term] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_termType_CompoundsAndGeneSymbols]
    ON [dbo].[CompoundsAndGeneSymbols]([term_type] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_targetType_CompoundsAndGeneSymbols]
    ON [dbo].[CompoundsAndGeneSymbols]([target_type] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_status_CompoundsAndGeneSymbols]
    ON [dbo].[CompoundsAndGeneSymbols]([status] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_geneSymbolStatus_CompoundsAndGeneSymbols]
    ON [dbo].[CompoundsAndGeneSymbols]([gene_symbol_status] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_ensumbl_CompoundsAndGeneSymbols]
    ON [dbo].[CompoundsAndGeneSymbols]([ensembl_id] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_species_CompoundsAndGeneSymbols]
    ON [dbo].[CompoundsAndGeneSymbols]([species] ASC);

