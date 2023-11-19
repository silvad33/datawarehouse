CREATE TABLE [clinical].[StudySitePerformance] (
    [ClinicalStudyName]      VARCHAR (256) NULL,
    [ClinicalSiteNumber]     INT           NULL,
    [CurrentDate]            DATETIME      NULL,
    [EnrollmentPlanToDate]   INT           NULL,
    [EnrollmentActualToDate] INT           NULL,
    [ActualsPctToPlan]       FLOAT (53)    NULL,
    [UnderPerformingSIte]    VARCHAR (50)  NULL,
    [OverPerformingSite]     VARCHAR (50)  NULL,
    [StudySitePerformanceID] INT           IDENTITY (1, 1) NOT NULL,
    [ClinicalStudySitesID]   INT           NULL,
    CONSTRAINT [PK_StudySitePerformance] PRIMARY KEY CLUSTERED ([StudySitePerformanceID] ASC),
    CONSTRAINT [FK_StudySitePerformance_ClinicalStudySites] FOREIGN KEY ([ClinicalStudySitesID]) REFERENCES [clinical].[ClinicalStudySites] ([ClinicalStudySitesID])
);

