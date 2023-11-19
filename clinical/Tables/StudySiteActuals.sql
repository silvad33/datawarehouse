CREATE TABLE [clinical].[StudySiteActuals] (
    [TotalSubjectsScreened]      INT          NULL,
    [MonthYear]                  DATETIME     NULL,
    [TotalScreenFailures]        INT          NULL,
    [TotalSubjectsEnrolled]      INT          NULL,
    [ClinicalStudy]              VARCHAR (50) NULL,
    [ClinicalSiteNumber]         VARCHAR (50) NULL,
    [ClinicalSiteCountry]        VARCHAR (50) NULL,
    [TotalSubjectStudyCompleted] INT          NULL,
    [TotalSubjectsEarlyDropout]  INT          NULL,
    [StudyCohort]                VARCHAR (50) NULL,
    [StudySiteActualsID]         INT          IDENTITY (1, 1) NOT NULL,
    [TotalSubjectEarlyTerm]      INT          NULL,
    [TotalSubjectsInScreening]   INT          NULL,
    CONSTRAINT [PK_StudySiteActuals] PRIMARY KEY CLUSTERED ([StudySiteActualsID] ASC)
);

