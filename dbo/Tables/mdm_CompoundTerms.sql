CREATE TABLE [dbo].[mdm_CompoundTerms] (
    [compound_num] VARCHAR (50)  NOT NULL,
    [term]         VARCHAR (100) NOT NULL,
    [gene_symbol]  VARCHAR (50)  NOT NULL,
    [ensembl_id]   VARCHAR (100) NOT NULL,
    [species]      VARCHAR (100) NOT NULL,
    [term_type]    VARCHAR (50)  NOT NULL,
    [status]       VARCHAR (50)  NOT NULL,
    [DateCreated]  DATETIME      NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_gene_compoundtermsTbl]
    ON [dbo].[mdm_CompoundTerms]([gene_symbol] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idx_term_compoundtermsTbl]
    ON [dbo].[mdm_CompoundTerms]([term] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idx_status_compoundtermsTbl]
    ON [dbo].[mdm_CompoundTerms]([status] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idx_compoundNum_compoundtermsTbl]
    ON [dbo].[mdm_CompoundTerms]([compound_num] ASC) WITH (FILLFACTOR = 80);

