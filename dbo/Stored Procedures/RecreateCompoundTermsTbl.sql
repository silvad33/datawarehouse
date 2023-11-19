
CREATE  PROCEDURE [dbo].[RecreateCompoundTermsTbl]
AS
/*
    -- *************************************
    --  Deletes all rows in the derived 'mdm_compound_termsTbl' table (used in Pubs API lookups), and then recreates it
    --  See also:  Stored procedure RefreshPubsApiTables.
    --  Intended use:  Usually called from the stored procedure RefreshPubsApiTables, which will check for last modification dates before runnning this long process.
    --  Author:  John O'Neill
    --  Modified: 11/13/2019.
    -- *************************************
*/
IF EXISTS(SELECT 1 FROM sys.Objects 
    WHERE  Object_id = OBJECT_ID(N'dbo.mdm_compound_termsTbl') 
           AND Type = N'U')
BEGIN
  DROP TABLE dbo.mdm_compound_termsTbl
END
    SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON

CREATE TABLE [dbo].[mdm_compound_termsTbl](
	[compound_num] [varchar](50) NOT NULL,
	[term] [varchar](100) NOT NULL,
	[gene_symbol] [varchar](50) NOT NULL,
	[ensembl_id] [varchar](100) NOT NULL,
	[species] [varchar](100) NOT NULL,
	[term_type] [varchar](50) NOT NULL,
	[status] [varchar](50) NOT NULL,
	[DateCreated] [datetime] NOT NULL
) ON [PRIMARY]

--SET ANSI_PADDING ON
--GO
--CREATE NONCLUSTERED INDEX [idx_compound_compoundtermsTbl] ON [dbo].[mdm_compound_termsTbl]
--(
--	[compound_num] ASC
--)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
--GO
--SET ANSI_PADDING ON
--GO
--CREATE NONCLUSTERED INDEX [idx_ensembl_compoundtermsTbl] ON [dbo].[mdm_compound_termsTbl]
--(
--	[ensembl_id] ASC
--)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
--GO
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [idx_gene_compoundtermsTbl] ON [dbo].[mdm_compound_termsTbl]
(
	[gene_symbol] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]

SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [idx_term_compoundtermsTbl] ON [dbo].[mdm_compound_termsTbl]
(
	[term] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]

--ALTER TABLE [dbo].[mdm_compound_termsTbl] ADD  DEFAULT (getdate()) FOR [DateCreated]









