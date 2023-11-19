

CREATE PROCEDURE [dbo].[spDimFinancialCalendar] as 

--select * from DimFinancialCalendar


WITH gen AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num+1 FROM gen WHERE num+1<=31
)

SELECT * Into #TempNum FROM gen
option (maxrecursion 10000)
--drop table DimFinancialCalendar

truncate table DimFinancialCalendar
insert into DimFinancialCalendar
([FiscalMonth]
      ,[MonthNumer]
      ,[MonthName]
      ,[DayNumber]
      ,[Year]
      ,[FullDate]
      ,[Quarter]
      ,[FiscalYear]
      ,[PeriodName]
      ,[ShortName]
      ,[StartDate]
      ,[EndDate]
      ,[Type]
      ,[Calendar]
      ,[CalendarType]
      ,[Days]
	  ,OpenClosed
	  ,EntityKey
	--  ,FiscalPeriodKey
	  )
	  select distinct * from (
SELECT  [MONTH] FiscalMonth
	  ,Month(startDate) MonthNumer
	  , format(STARTDATE,'MMMM') MonthName
	  ,num DayNumber
	  ,year(startDate) Year
	  ,DATEFROMPARTS(year(startDate),Month(startDate),num) FullDate  
      ,case when [QUARTER] =0 then 'Q1'
			when [QUARTER] =1 then 'Q2'
			when [QUARTER] =2 then 'Q3'
			when [QUARTER] =3 then 'Q4' end Quarter
      ,[FISCALYEAR] FiscalYear
      ,f.[PERIODNAME] PeriodName
      ,[SHORTNAME] ShortName
      ,[STARTDATE] StartDate
	  ,[ENDDATE] EndDate
      ,[TYPE] Type
      ,f.[CALENDAR] Calendar
      ,[CALENDARTYPE] CalendarType
      ,[DAYS] Days
      --,[RECID] FiscalPeriodKey

	  ,case when periodstatus = 1 then 'Open' else 'Closed' end  OpenClosed
	  ,e.entitykey
--	  ,CONCAT(year(startDate),month(startDate),num,e.EntityKey)  FiscalPeriodKey
  FROM [dbo].[FiscalPeriodStaging] f
  left join #TempNum t on t.num >= Day(startdate)
		and t.num <= day(enddate)
	left join LedgerFiscalPeriodStaging lf on lf.periodname = f.periodname and lf.yearname = year(startdate)
  left join DimEntity e on e.EntityID = LEDGERNAME
  where f.PERIODNAME not in ('Period 13','Period 0')
	and DATEFROMPARTS(year(startDate),Month(startDate),num) not in (  select distinct fulldate from 
 DimFinancialCalendar
))z

  drop table #TempNum

  update DimFinancialCalendar
  set CYTDFlag = null

  update DimFinancialCalendar
  set CYTDFlag = 1
  where [Year] = year(getdate())
  and FullDate <=  format(getdate(),'yyyy-MM-dd')
  
  update DimFinancialCalendar
  set PYTDFlag = null

  update DimFinancialCalendar
  set PYTDFlag = 1
  where [Year] = year(getdate())-1
  and FullDate <=  format(DATEFROMPARTS(year(getdate())-1,month(getdate()),day(getdate())),'yyyy-MM-dd')


  update DimFinancialCalendar
  set CYQuarterToDate = null

  update DimFinancialCalendar
  set CYQuarterToDate = 1
  from(select distinct quarter from DimFinancialCalendar
	where format(getdate(),'yyyy-MM-dd') = fulldate) z
	where z.Quarter = DimFinancialCalendar.Quarter
	and year(getdate()) = DimFinancialCalendar.Year
	and FullDate <=  format(getdate(),'yyyy-MM-dd')
  
  update DimFinancialCalendar
  set PYQuarterToDate = null

  update DimFinancialCalendar
  set PYQuarterToDate = 1 
    from(select distinct quarter from DimFinancialCalendar
	where format(getdate(),'yyyy-MM-dd') = fulldate) z
	where z.Quarter = DimFinancialCalendar.Quarter
	and year(getdate()) -1 = DimFinancialCalendar.Year
	and FullDate <= datefromparts(year(getdate())-1,month(getdate()),day(getdate()))

update DimFinancialCalendar
set PQuarterToDate = null


update DimFinancialCalendar
set PQuarterToDate = 1
from( select distinct case when quarter = 'Q1' then 'Q4'
				when quarter = 'Q2' then 'Q1'
				when quarter = 'Q3' then 'Q2'
				when quarter = 'Q4' then 'Q3' end QT,
				case when quarter = 'Q1' then year(fulldate)-1
				when quarter = 'Q2' then year(fulldate)
				when quarter = 'Q3' then year(fulldate)
				when quarter = 'Q4' then year(fulldate) end YR
				  from DimFinancialCalendar
where fulldate = format(getdate(),'yyyy-MM-dd') )z
where z.QT = Quarter
and z.yr = Year

  update DimFinancialCalendar
  set CYMonthToDate = null

  update DimFinancialCalendar
  set CYMonthToDate = 1
  where month(fulldate) = month(getdate())
		and year(fulldate) = year(getdate())
	--	and day(fulldate) <= day(getdate())
  
  update DimFinancialCalendar
  set PYMonthToDate = null

  update DimFinancialCalendar
  set PYMonthToDate = 1
  where month(fulldate) = month(getdate())
		and year(fulldate) = year(getdate()) -1
	--	and day(fulldate) <= day(getdate())

update DimfinancialCalendar
set Rolling12Closed = 1
from (
--select max(fulldate)dte,datefromparts(year(max(fulldate))-1,month(max(fulldate)),day(max(fulldate)))mindte ,entitykey from DimFinancialCalendar
--where OpenClosed = 'closed' and FullDate <= getdate()
--group by entitykey
-- Some interesting logic to accommodate the last closed period being a leap year in February.
select max(fulldate)dte,
	datefromparts(year(max(fulldate))-1,month(max(fulldate)),
		case when day(max(fulldate))<>29 or month(max(fulldate)) <>2 then day(max(fulldate))
			 else 28 end 
		)
		mindte ,
	entitykey from DimFinancialCalendar
where OpenClosed = 'closed' and FullDate <= getdate()
group by entitykey
)z
where 
mindte < fulldate 
and OpenClosed = 'closed'
and z.EntityKey = DimFinancialCalendar.EntityKey

update DimfinancialCalendar 
set LastClosedMonth = null

update DimfinancialCalendar 
set LastClosedMonth = 1
from (select max(fulldate) fd,EntityKey ek from DimfinancialCalendar
		where  OpenClosed = 'closed'
		group by EntityKey)z
		where fd = FullDate 
		and ek = EntityKey

update DimfinancialCalendar 
set openclosed = 'closed'
where fulldate <= (select distinct dateadd(m,-1,max(fulldate)) MaxDate--,OpenClosed 
from DimFinancialCalendar

where openclosed = 'closed'
group by OpenClosed)

--select * from DimFinancialCalendar
update DimFinancialCalendar
set OpenClosed = 'Closed'
where EntityKey = 19
and month(fulldate) =6
and year(fulldate) =2020