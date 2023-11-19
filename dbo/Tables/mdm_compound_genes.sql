CREATE TABLE [dbo].[mdm_compound_genes] (
    [compound_num] VARCHAR (50)  NOT NULL,
    [ensembl_id]   VARCHAR (100) NOT NULL,
    [species]      VARCHAR (256) NOT NULL,
    [species_name] VARCHAR (64)  NOT NULL,
    [target_type]  VARCHAR (50)  NULL,
    [release_num]  VARCHAR (16)  NOT NULL,
    [obsolete]     BIT           NOT NULL,
    [DateCreated]  DATETIME      DEFAULT (getdate()) NOT NULL,
    [DateModified] DATETIME      NULL,
    FOREIGN KEY ([compound_num]) REFERENCES [dbo].[mdm_compounds] ([compound_num])
);


GO
CREATE NONCLUSTERED INDEX [idx_compound_num_compoundgenes]
    ON [dbo].[mdm_compound_genes]([compound_num] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_ensembl_id_compoundgenes]
    ON [dbo].[mdm_compound_genes]([ensembl_id] ASC);

