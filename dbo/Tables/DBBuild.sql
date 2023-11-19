/*
Purpose: Capture current database build. DevOps Release script to populate/append on release
*/

CREATE TABLE [dbo].[DBBuild]
(
	[ReleaseId] VARCHAR(100) NOT NULL,
	[ReleaseName] VARCHAR(100) NOT NULL,
	[BuildNumber] VARCHAR(100) NOT NULL,
	[SourceBranch] VARCHAR(100) NOT NULL,
	[UpdatedAt] DATETIME NOT NULL
)
