CREATE TABLE [research].[PubsApprovalTasks]
(
	[TaskID] int NOT NULL,
	[PubsKey] int NULL,
	[ApprovalRole] varchar(255) NOT NULL,
	[Status] varchar(255) NOT NULL,
	[AssignedToKey] int NULL,
	[TaskCompleted] varchar(50) NULL,
	[TaskOutcome] varchar(50) NULL,
	[DelegateAdded] varchar(50) NULL,
	[DelegateKey] int NULL,
	[TaskComments] varchar(max) NULL,
	[UserComments] varchar(max) NULL,
	[Created] datetime NULL,
	[Modified] datetime NULL,
	[DateCreated] datetime NOT NULL DEFAULT getdate(),
	[DateModified] datetime NULL,
	[PubsID] int NULL
)
GO

ALTER TABLE [research].[PubsApprovalTasks] 
 ADD CONSTRAINT [PK_PubsApprovalTasks]
	PRIMARY KEY CLUSTERED ([TaskID] ASC)
GO

CREATE NONCLUSTERED INDEX [idx_PubsKey_PubsApprovalTasks] 
 ON [research].[PubsApprovalTasks] ([PubsKey] ASC)
GO