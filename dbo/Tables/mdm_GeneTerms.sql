CREATE TABLE [dbo].[mdm_GeneTerms] (
    [ensembl_id]    VARCHAR (100)  NOT NULL,
    [term]          VARCHAR (1024) NOT NULL,
    [primarysymbol] VARCHAR (100)  NULL,
    [primaryname]   VARCHAR (500)  NULL,
    [species]       VARCHAR (100)  NOT NULL,
    [status]        VARCHAR (50)   NOT NULL,
    [term_type]     VARCHAR (6)    NOT NULL,
    [DateCreated]   DATETIME       DEFAULT (getdate()) NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_ensembl_genetermsTbl]
    ON [dbo].[mdm_GeneTerms]([ensembl_id] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_primarysymbol_genetermstbl]
    ON [dbo].[mdm_GeneTerms]([primarysymbol] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_term_genetermsTbl]
    ON [dbo].[mdm_GeneTerms]([term] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_species_genetermsTbl]
    ON [dbo].[mdm_GeneTerms]([species] ASC);

