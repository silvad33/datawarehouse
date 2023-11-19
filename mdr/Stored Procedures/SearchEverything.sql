CREATE PROCEDURE [mdr].[SearchEverything] as
DECLARE @SEARCHSTRING VARCHAR(255), @notcontain Varchar(255)
SELECT @SEARCHSTRING = 'LedgerAccountStructureStaging', @notcontain = '' -- Change search screen to what you want to look for
SELECT DISTINCT sysobjects.name AS [Object Name] ,
case when sysobjects.xtype = 'P' then 'Stored Proc'
when sysobjects.xtype = 'TF' then 'Function'
when sysobjects.xtype = 'TR' then 'Trigger'
when sysobjects.xtype = 'V' then 'View'
end as [Object Type],*
FROM sysobjects,syscomments
WHERE sysobjects.id = syscomments.id
AND sysobjects.type in ('P','TF','TR','V') -- Limits where to look
AND sysobjects.category = 0
AND CHARINDEX(@SEARCHSTRING,syscomments.text)>0
AND ((CHARINDEX(@notcontain,syscomments.text)=0 
or CHARINDEX(@notcontain,syscomments.text)<>0)) 