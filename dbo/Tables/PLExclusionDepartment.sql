CREATE TABLE [dbo].[PLExclusionDepartment] (
    [DepartmentNumber] INT          NOT NULL,
    [DescriptionFPA]   VARCHAR (40) NOT NULL,
    [FSLI]             VARCHAR (3)  NOT NULL,
    [function_]        VARCHAR (15) NOT NULL,
    [Country]          VARCHAR (14) NOT NULL,
    [Region]           VARCHAR (6)  NOT NULL,
    [Include]          VARCHAR (1)  NOT NULL
);

