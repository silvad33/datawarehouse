CREATE TABLE [dbo].[mdm_gene_symbols] (
    [ensembl_id]         VARCHAR (100) NOT NULL,
    [gene_symbol]        VARCHAR (50)  NOT NULL,
    [species]            VARCHAR (100) NOT NULL,
    [gene_symbol_status] VARCHAR (50)  NULL,
    [DateCreated]        DATETIME      DEFAULT (getdate()) NOT NULL,
    [DateModified]       DATETIME      NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_ensembl_id_genesymbols]
    ON [dbo].[mdm_gene_symbols]([ensembl_id] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_gene_symbol_genesymbols]
    ON [dbo].[mdm_gene_symbols]([gene_symbol] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_gene_symbol_status]
    ON [dbo].[mdm_gene_symbols]([gene_symbol_status] ASC);

