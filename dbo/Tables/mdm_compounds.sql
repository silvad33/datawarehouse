CREATE TABLE [dbo].[mdm_compounds] (
    [compound_num]     VARCHAR (50) NOT NULL,
    [DateCreated]      DATETIME     DEFAULT (getdate()) NOT NULL,
    [IsisCreationDate] DATETIME     NULL,
    PRIMARY KEY CLUSTERED ([compound_num] ASC)
);

