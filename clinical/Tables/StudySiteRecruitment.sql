CREATE TABLE [clinical].[StudySiteRecruitment] (
    [SiteRecruitmentDate]    DATETIME NULL,
    [NumberofSites]          INT      NULL,
    [StudySiteRecruitmentID] INT      IDENTITY (1, 1) NOT NULL,
    [StudyRecruitmentID]     INT      NULL,
    CONSTRAINT [PK_StudySiteRecruitment] PRIMARY KEY CLUSTERED ([StudySiteRecruitmentID] ASC),
    CONSTRAINT [FK_StudySiteRecruitment_StudyRecruitment] FOREIGN KEY ([StudyRecruitmentID]) REFERENCES [clinical].[StudyRecruitment] ([StudyRecruitmentID])
);

