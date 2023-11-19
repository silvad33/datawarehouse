CREATE TABLE [dbo].[mdm_gene_names] (
    [ensembl_id]       VARCHAR (100)  NOT NULL,
    [gene_name]        VARCHAR (1024) NULL,
    [species]          VARCHAR (100)  NOT NULL,
    [gene_name_status] VARCHAR (50)   NULL,
    [DateCreated]      DATETIME       DEFAULT (getdate()) NOT NULL,
    [DateModified]     DATETIME       NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_ensembl_id_genenames]
    ON [dbo].[mdm_gene_names]([ensembl_id] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_gene_name_genenames]
    ON [dbo].[mdm_gene_names]([gene_name] ASC);

