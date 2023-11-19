CREATE TABLE [clinical].[ClinicalStudyCohorts] (
    [CohortTitle]                VARCHAR (50) NULL,
    [CohortDosage]               INT          NULL,
    [CohortDoseUnits]            VARCHAR (50) NULL,
    [NumberOfSubjects]           INT          NULL,
    [EnrollmentPlannedStartDate] DATETIME     NULL,
    [ClinicalStudyCohortsID]     INT          IDENTITY (1, 1) NOT NULL,
    [ClinicalStudyID]            INT          NULL,
    CONSTRAINT [PK_ClinicalStudyCohorts] PRIMARY KEY CLUSTERED ([ClinicalStudyCohortsID] ASC),
    CONSTRAINT [FK_ClinicalStudyCohorts_ClinicalStudy] FOREIGN KEY ([ClinicalStudyID]) REFERENCES [clinical].[ClinicalStudy] ([ClinicalStudyID])
);

