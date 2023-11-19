/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 15.2 		*/
/*  Created On : 20-Jul-2021 9:42:23 AM 				*/
/*  DBMS       : SQL Server 2012 						*/
/* ---------------------------------------------------- */

/* Create Tables */

CREATE TABLE [clinical].[StudyAdverseEvents]
(
	[StudyAdverseEventsID] int NOT NULL IDENTITY (1, 1),
	[StudySiteSubjectsID] int NULL,
	[AESequenceNumber] varchar(500) NOT NULL,
	[AEOutcome] varchar(500) NULL,
	[AEDecodedTerm] varchar(500) NULL,
	[AEDescription] varchar(1000) NOT NULL,
	[AEHighLevelGroupTermCode] varchar(500) NULL,
	[AEHighLevelGroupTerm] varchar(500) NULL,
	[AEHighLevelTermCode] varchar(500) NULL,
	[AEHighLevelTerm] varchar(500) NULL,
	[AELowLevelTermCode] varchar(500) NULL,
	[AELowLevelTerm] varchar(500) NULL,
	[AEComment] varchar(1000) NULL,
	[AEStartDate] date NULL,
	[AEEndDate] date NULL,
	[AESeverity] varchar(500) NOT NULL,
	[AESerious] bit NOT NULL,
	[AEConcominantTreatment] bit NOT NULL,
	[AEDrugRelated] varchar(500) NOT NULL
)
GO

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE [clinical].[StudyAdverseEvents] 
 ADD CONSTRAINT [PK_StudyAdverseEvents]
	PRIMARY KEY CLUSTERED ([StudyAdverseEventsID] ASC)
GO