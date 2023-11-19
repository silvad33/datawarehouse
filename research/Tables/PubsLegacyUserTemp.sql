CREATE TABLE [research].[PubsLegacyUserTemp]
(
	[FullName] varchar(100) NOT NULL,
	[DimUser_UserKey] int NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL
)
GO

ALTER TABLE [research].[PubsLegacyUserTemp] 
 ADD CONSTRAINT [PK_PubsLegacyUserTempPubsUserName]
	PRIMARY KEY CLUSTERED ([FullName] ASC)
GO