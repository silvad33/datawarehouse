CREATE TABLE [dbo].[mdm_compound_names] (
    [compound_num]         VARCHAR (50)  NOT NULL,
    [compound_name]        VARCHAR (100) NOT NULL,
    [compound_name_type]   VARCHAR (50)  NOT NULL,
    [compound_name_status] VARCHAR (50)  NOT NULL,
    [DateCreated]          DATETIME      DEFAULT (getdate()) NOT NULL,
    [DateModified]         DATETIME      NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_compoundname_compoundnames]
    ON [dbo].[mdm_compound_names]([compound_num] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_compoundnum_compoundnames]
    ON [dbo].[mdm_compound_names]([compound_name] ASC);

