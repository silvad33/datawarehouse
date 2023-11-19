CREATE TABLE [clinical].[StudyAnnotations] (
    [Annotations]        VARCHAR (8000) NULL,
    [AnnotationType]     VARCHAR (50)   NULL,
    [StudyAnnotationsID] INT            IDENTITY (1, 1) NOT NULL,
    [StudyRecruitmentID] INT            NULL,
    [CommentDate]        DATE           NULL,
    CONSTRAINT [PK_StudyAnnotations] PRIMARY KEY CLUSTERED ([StudyAnnotationsID] ASC),
    CONSTRAINT [FK_StudyAnnotations_StudyRecruitment] FOREIGN KEY ([StudyRecruitmentID]) REFERENCES [clinical].[StudyRecruitment] ([StudyRecruitmentID])
);

