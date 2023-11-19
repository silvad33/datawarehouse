CREATE view [dbo].[vwtotalingAccountExplosion] as
SELECT t.[DEFINITIONGROUP]
      ,t.[EXECUTIONID]
      ,t.[ISSELECTED]
      ,t.[TRANSFERSTATUS]
      ,t.[MAINACCOUNTID] as TOTALINGMAINACCOUNTID
	  ,m.name as TOTALINGACCOUNTNAME
      ,t.[CHARTOFACCOUNTS]
      ,t.[FROMVALUE]
      ,t.[TOVALUE]
      ,t.[INVERTTOTALSIGN]
      ,t.[PARTITION]
      ,t.[SYNCSTARTDATETIME]
      ,t.[RECID]
	  ,m2.MAINACCOUNTID as COMPONENTMAINACCOUNTID
	  , m2.NAME AS COMPONENTACCOUNTNAME
  FROM [dbo].[MainAccountTotalAccountIntervalEntityStaging] t
  JOIN MainAccountStaging m on m.MAINACCOUNTID=t.mainaccountid and m.PARTITION=t.partition
  join MainAccountStaging m2 on m2.MAINACCOUNTID>=t.fromvalue and m2.MAINACCOUNTID<=t.tovalue and m.PARTITION=t.partition
  WHERE ISNUMERIC(m2.MAINACCOUNTID) = 1
