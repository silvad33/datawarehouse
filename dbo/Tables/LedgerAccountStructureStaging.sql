CREATE TABLE [dbo].[LedgerAccountStructureStaging] (
    [DESCRIPTION]          NVARCHAR (60) NOT NULL,
    [STATUS]               INT           NOT NULL,
    [SEGMENTNAME01]        NVARCHAR (60) NOT NULL,
    [SEGMENTNAME02]        NVARCHAR (60) NOT NULL,
    [SEGMENTNAME03]        NVARCHAR (60) NOT NULL,
    [SEGMENTNAME04]        NVARCHAR (60) NOT NULL,
    [SEGMENTNAME05]        NVARCHAR (60) NOT NULL,
    [SEGMENTNAME06]        NVARCHAR (60) NOT NULL,
    [SEGMENTNAME07]        NVARCHAR (60) NOT NULL,
    [SEGMENTNAME08]        NVARCHAR (60) NOT NULL,
    [SEGMENTNAME09]        NVARCHAR (60) NOT NULL,
    [SEGMENTNAME10]        NVARCHAR (60) NOT NULL,
    [SEGMENTNAME11]        NVARCHAR (60) NOT NULL,
    [DEFINITIONGROUP]      NVARCHAR (60) NOT NULL,
    [EXECUTIONID]          NVARCHAR (90) NOT NULL,
    [ISSELECTED]           INT           NOT NULL,
    [TRANSFERSTATUS]       INT           NOT NULL,
    [ACCOUNTSTRUCTURENAME] NVARCHAR (60) NOT NULL,
    [PARTITION]            NVARCHAR (20) NOT NULL,
    [SYNCSTARTDATETIME]    DATETIME      NOT NULL,
    [RECID]                BIGINT        NOT NULL,
    CONSTRAINT [PK_LedgerAccountStructureStaging] PRIMARY KEY CLUSTERED ([STATUS] ASC, [EXECUTIONID] ASC, [ACCOUNTSTRUCTURENAME] ASC, [PARTITION] ASC)
);


GO


CREATE TRIGGER [dbo].[BYODAutomation]
   ON [dbo].[LedgerAccountStructureStaging]
   AFTER INSERT,UPDATE
AS 

BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Insert into mdr.RSMLogit (RunTS,RunProcess)
	Values (getdate(),'Kickoff Financial Model Load')

	EXECUTE spLoadFinacialModel

	Insert into mdr.RSMLogit (RunTS,RunProcess)
	Values (getdate(),'Completed Financial Model Load')

END

