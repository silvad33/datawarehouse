CREATE TABLE [clinical].[StudyPerformanceMetrics] (
    [ClinicalStudyName]         VARCHAR (256) NULL,
    [MetricStatus]              VARCHAR (50)  NULL,
    [Metric]                    VARCHAR (256) NULL,
    [StudyPerformanceMetricsID] INT           IDENTITY (1, 1) NOT NULL,
    [ClinicalStudyID]           INT           NOT NULL,
    [CurrentDate]               DATETIME      NULL,
    CONSTRAINT [PK_StudyPerformanceMetrics] PRIMARY KEY CLUSTERED ([StudyPerformanceMetricsID] ASC),
    CONSTRAINT [FK_StudyPerformanceMetrics_ClinicalStudy] FOREIGN KEY ([ClinicalStudyID]) REFERENCES [clinical].[ClinicalStudy] ([ClinicalStudyID])
);

