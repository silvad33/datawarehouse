CREATE TABLE [clinical].[ClinicalStudy] (
    [ClinicalStudyName]  VARCHAR (2000) NULL,
    [Description]        VARCHAR (2000) NULL,
    [Status]             VARCHAR (2000) NULL,
    [Phase]              VARCHAR (2000) NULL,
    [ClinicalStudyID]    INT            IDENTITY (1, 1) NOT NULL,
    [Indication]         VARCHAR (2000) NULL,
    [ClinicalProgramsID] INT            NULL,
    [ETMFStatus]         VARCHAR (2000) NULL,
    [ShortDescription]   VARCHAR (250)  NULL,
    [CTMSStatus]         VARCHAR (50)   NULL,
    CONSTRAINT [PK_ClinicalStudy] PRIMARY KEY CLUSTERED ([ClinicalStudyID] ASC),
    CONSTRAINT [FK_ClinicalStudy_ClinicalPrograms] FOREIGN KEY ([ClinicalProgramsID]) REFERENCES [clinical].[ClinicalPrograms] ([ClinicalProgramsID])
);

