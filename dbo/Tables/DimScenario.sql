/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 13.0 		*/
/*  Created On : 22-Oct-2020 10:03:19 AM 				*/
/*  DBMS       : SQL Server 2012 						*/
/* ---------------------------------------------------- */

/* Create Tables */

CREATE TABLE [DimScenario]
(
	[ScenarioKey] int NOT NULL IDENTITY (1, 1),
	[ScenarioTypeKey] int NOT NULL,
	[SubScenario] varchar(50) NOT NULL,
	[Official] bit NOT NULL
)
GO

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE [DimScenario] 
 ADD CONSTRAINT [PK_DimScenario]
	PRIMARY KEY CLUSTERED ([ScenarioKey] ASC)
GO

ALTER TABLE [DimScenario] 
 ADD CONSTRAINT [OneOfficialByType] CHECK ((NOT (dbo.Scenario_CheckOfficialCount(ScenarioTypeKey) > 1)))
GO

/* Create Foreign Key Constraints */

ALTER TABLE [DimScenario] ADD CONSTRAINT [FK_DimScenario_DimScenarioType]
	FOREIGN KEY ([ScenarioTypeKey]) REFERENCES [DimScenarioType] ([ScenarioTypeKey]) ON DELETE No Action ON UPDATE No Action
GO