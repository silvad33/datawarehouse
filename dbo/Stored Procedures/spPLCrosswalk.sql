
CREATE proc [dbo].[spPLCrosswalk]
as 
truncate table PL_Crosswalk 
insert into PL_Crosswalk
select ta.*
from(
SELECT DISTINCT TotalingAccount
	,TotalingAccountDescription
	,mainAccount
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'External GAAP' PLType
	,CASE 
		WHEN totalingAccount = 491001
			THEN totalingAccountDescription
		WHEN totalingAccount = 491002
			THEN totalingAccountDescription
		WHEN totalingAccount = 491003
			THEN totalingAccountDescription
		WHEN totalingAccount = 491999
			THEN totalingAccountDescription
		WHEN totalingAccount = 492999
			THEN totalingAccountDescription
		WHEN totalingAccount = 493999
			THEN totalingAccountDescription
		WHEN totalingAccount = 499999
			THEN totalingAccountDescription
		WHEN totalingAccount = 732999
			THEN 'Cost of Sales'
		WHEN totalingAccount = 999999 -- need
			AND DepartmentNumber = 170
			THEN 'Cost of Sales'
		WHEN (
				totalingAccount = 999999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 399
				)
			OR (
				totalingAccount = 999999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
			THEN 'R&D'
		WHEN totalingAccount = 999999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 599
			THEN 'SG&A'
		WHEN totalingAccount = 410000
			THEN totalingAccountDescription
		WHEN totalingAccount = 981999
			THEN totalingAccountDescription
		WHEN totalingAccount = 983999
			THEN totalingAccountDescription
		WHEN totalingAccount = 984999
			THEN totalingAccountDescription
		WHEN totalingAccount = 985999
			THEN totalingAccountDescription
		WHEN totalingAccount = 986999
			THEN totalingAccountDescription
		WHEN totalingAccount = 988999
			THEN totalingAccountDescription
		WHEN totalingAccount = 987999
			THEN totalingAccountDescription
		WHEN totalingAccount = 982999
			THEN 'Net Income (Loss)'
		WHEN totalingAccount = 400000
			THEN 'Net Income (Loss)'
		ELSE NULL
		END PLGroup
	,CASE 
		WHEN totalingAccount = 491001
			THEN 1
		WHEN totalingAccount = 491002
			THEN 2
		WHEN totalingAccount = 491003
			THEN 3
		WHEN totalingAccount = 491999
			THEN 5
		WHEN totalingAccount = 492999
			THEN 6
		WHEN totalingAccount = 493999
			THEN 7
		WHEN totalingAccount = 499999
			THEN 8
		WHEN totalingAccount = 732999
			THEN 12
		WHEN totalingAccount = 999999
			AND DepartmentNumber = 170
			THEN 12
		WHEN (
				totalingAccount = 999999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 399
				)
			OR (
				totalingAccount = 999999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
			THEN 15
		WHEN totalingAccount = 999999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 599
			THEN 16
		WHEN totalingAccount = 410000
			THEN 20
		WHEN totalingAccount = 981999
			THEN 22
		WHEN totalingAccount = 983999
			THEN 23
		WHEN totalingAccount = 984999
			THEN 24
		WHEN totalingAccount = 985999
			THEN 25
		WHEN totalingAccount = 986999
			THEN 26
		WHEN totalingAccount = 988999
			THEN 27
		WHEN totalingAccount = 987999
			THEN 28
		WHEN totalingAccount = 982999
			THEN 29
		WHEN totalingAccount = 400000
			THEN 29
		ELSE NULL
		END PLOrder
	,case when totalingAccount = 400000 
			then -1
		when totalingAccount = 983999 then -1 
		WHEN totalingAccount = 984999
			THEN -1
		WHEN totalingAccount = 985999
			THEN -1
		WHEN totalingAccount = 410000
			THEN -1
		WHEN totalingAccount = 491001
			THEN 1
		WHEN totalingAccount = 491002
			THEN -1
		WHEN totalingAccount = 491003
			THEN -1
		WHEN totalingAccount = 491999
			THEN -1
		WHEN totalingAccount = 492999
			THEN -1
		WHEN totalingAccount = 493999
			THEN -1
		WHEN totalingAccount = 499999
			THEN -1
		WHEN totalingAccount = 986999
			THEN -1
		else 1 end Factor 
FROM PLStage


union all

SELECT DISTINCT TotalingAccount
	,TotalingAccountDescription
	,mainAccount
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'External GAAP' PLType
	,CASE 		WHEN totalingAccount = 999999
			THEN totalingAccountDescription
		WHEN totalingAccount = 982999
			THEN totalingAccountDescription
		WHEN totalingAccount = 400000
			THEN totalingAccountDescription
		END PLGroup
	,CASE 
		WHEN totalingAccount = 999999
			THEN 18
		WHEN totalingAccount = 982999
			THEN 31
		WHEN totalingAccount = 400000
			THEN 32
		ELSE NULL
		END PLOrder
	,case  WHEN totalingAccount = 400000
			THEN -1 else 1 end Factor
FROM PLStage


union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal GAAP' PLType
	,CASE 
		WHEN totalingAccount = 491001
			THEN totalingAccountDescription
		WHEN totalingAccount = 491002
			THEN totalingAccountDescription
		WHEN totalingAccount = 491003
			THEN totalingAccountDescription
		WHEN totalingAccount = 491999
			THEN totalingAccountDescription
		WHEN totalingAccount = 492999
			THEN totalingAccountDescription
		WHEN totalingAccount = 493999
			THEN totalingAccountDescription
		WHEN totalingAccount = 499999
			THEN totalingAccountDescription
		WHEN totalingAccount = 732999
			THEN 'Supply Chain - NC'
		WHEN totalingAccount = 739999
			AND DepartmentNumber = 170
			THEN 'Supply Chain - C'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 200
			AND DepartmentNumber <= 280
			THEN 'Antisense'
		WHEN totalingAccount = 731999
			AND DepartmentNumber = 290
			THEN 'Translational Medicine'
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 700
				AND DepartmentNumber <= 799
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 685
				)
			THEN 'Development'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 610
			AND DepartmentNumber <= 699
			AND DepartmentNumber != 685
			THEN 'Mfg and Operations'
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 800
				AND DepartmentNumber <= 890
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 899
				)
			THEN 'R&D Support'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 304
			AND DepartmentNumber <= 399
			THEN 'Medical Affairs'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 499
			THEN 'Commercial'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 500
			AND DepartmentNumber <= 599
			THEN 'SG&A'
		WHEN totalingAccount = 892999
			THEN 'Corporate Expenses'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 901
			AND DepartmentNumber <= 930
			THEN 'Corporate Expenses'
		WHEN totalingAccount = 891999
			THEN totalingAccountDescription
		WHEN totalingAccount = 999999
			THEN totalingAccountDescription
		WHEN totalingAccount = 410000
			THEN totalingAccountDescription
		WHEN totalingAccount = 891999
			THEN totalingAccountDescription
		WHEN totalingAccount = 983999
			THEN totalingAccountDescription
		WHEN totalingAccount = 984999
			THEN totalingAccountDescription
		WHEN totalingAccount = 985999
			THEN totalingAccountDescription
		WHEN totalingAccount = 986999
			THEN totalingAccountDescription
		WHEN totalingAccount = 988999
			THEN totalingAccountDescription
		WHEN totalingAccount = 987999
			THEN totalingAccountDescription
		WHEN totalingAccount = 982999
			THEN totalingAccountDescription
		WHEN totalingAccount = 400000
			THEN totalingAccountDescription
		ELSE NULL
		END PLGroup
	,CASE 
		WHEN totalingAccount = 491001
			THEN 33
		WHEN totalingAccount = 491002
			THEN 34
		WHEN totalingAccount = 491003
			THEN 35
		WHEN totalingAccount = 491999
			THEN 37
		WHEN totalingAccount = 492999
			THEN 39
		WHEN totalingAccount = 493999
			THEN 40
		WHEN totalingAccount = 499999
			THEN 42
		WHEN totalingAccount = 732999
			THEN 45
		WHEN totalingAccount = 739999
			AND DepartmentNumber = 170
			THEN 46
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 200
			AND DepartmentNumber <= 280
			THEN 48
		WHEN totalingAccount = 731999
			AND DepartmentNumber = 290
			THEN 49
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 700
				AND DepartmentNumber <= 799
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 685
				)
			THEN 50
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 610
			AND DepartmentNumber <= 699
			AND DepartmentNumber != 685
			THEN 51
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 800
				AND DepartmentNumber <= 890
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 899
				)
			THEN 52
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 304
			AND DepartmentNumber <= 399
			THEN 53
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 499
			THEN 54
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 500
			AND DepartmentNumber <= 599
			THEN 55
		WHEN totalingAccount = 892999
			THEN 56
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 901
			AND DepartmentNumber <= 930
			THEN 56
		WHEN totalingAccount = 891999
			THEN 59
		WHEN totalingAccount = 999999
			THEN 61
		WHEN totalingAccount = 410000
			THEN 63
		WHEN totalingAccount = 891999
			THEN 65
		WHEN totalingAccount = 983999
			THEN 66
		WHEN totalingAccount = 984999
			THEN 67
		WHEN totalingAccount = 985999
			THEN 68
		WHEN totalingAccount = 986999
			THEN 69
		WHEN totalingAccount = 988999
			THEN 70
		WHEN totalingAccount = 987999
			THEN 71
		WHEN totalingAccount = 982999
			THEN 74
		WHEN totalingAccount = 400000
			THEN 76
		ELSE NULL
		END PLGroup
	
	,case WHEN totalingAccount = 491001
			THEN -1
		WHEN totalingAccount = 400000
			THEN -1
		WHEN totalingAccount = 491002
			THEN -1
		WHEN totalingAccount = 491003
			THEN -1
		WHEN totalingAccount = 491999
			THEN -1
		WHEN totalingAccount = 492999
			THEN -1
		WHEN totalingAccount = 493999
			THEN -1
		WHEN totalingAccount = 499999
			THEN -1
		WHEN totalingAccount = 410000
			THEN -1
		WHEN totalingAccount = 983999
			THEN -1
		WHEN totalingAccount = 984999
			THEN -1
		WHEN totalingAccount = 985999
			THEN -1
		WHEN totalingAccount = 986999
			THEN -1
			 else 1 end Factor
FROM PLStage


union all


SELECT DISTINCT TotalingAccount
	,TotalingAccountDescription
	,mainAccount
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal GAAP' PLType
	,CASE WHEN totalingAccount = 982999
			THEN 'Net Income (Loss)'
		WHEN totalingAccount = 400000
			THEN 'Net Income (Loss)'
		END PLGroup
	,CASE 
		WHEN totalingAccount = 982999
			THEN 73
		WHEN totalingAccount = 400000
			THEN 73
		ELSE NULL
		END PLOrder
	,case when totalingAccount = 400000 then -1 else 1 end Factor 
FROM PLStage


union all


SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'ExternalProForma' PLType
	,CASE 
		WHEN totalingAccount = 491001
			THEN totalingAccountDescription
		WHEN totalingAccount = 491002
			THEN totalingAccountDescription
		WHEN totalingAccount = 491003
			THEN totalingAccountDescription
		WHEN totalingAccount = 491999
			THEN totalingAccountDescription
		WHEN totalingAccount = 492999
			THEN totalingAccountDescription
		WHEN totalingAccount = 493999
			THEN totalingAccountDescription
		WHEN totalingAccount = 499999
			THEN totalingAccountDescription
		WHEN totalingAccount = 732999
			THEN 'Cost of Sales'

--GOOD

		WHEN totalingAccount = 999999
			AND DepartmentNumber = 170
			THEN 'Cost of Sales'
		WHEN totalingAccount = 891999 
			AND DepartmentNumber = 170 --NEG
			THEN 'Cost of Sales'
		WHEN (
				totalingAccount = 999999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 399
				)
			OR (
				totalingAccount = 999999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
			THEN 'R&D'
		WHEN (
				totalingAccount = 891999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
				OR (
				totalingAccount = 891999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 299
				) --NEG
			THEN 'R&D'
		WHEN totalingAccount = 999999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 599
			THEN 'SG&A'
		WHEN (
				totalingAccount = 891999
				AND DepartmentNumber >= 400
				AND DepartmentNumber <= 599
				) --NEG
			THEN 'SG&A'
		WHEN totalingAccount = 981999
			THEN totalingAccountDescription
		WHEN totalingAccount = 983999
			THEN totalingAccountDescription
		WHEN totalingAccount = 984999
			THEN totalingAccountDescription
		WHEN totalingAccount = 985999
			THEN totalingAccountDescription
		WHEN totalingAccount = 986999
			THEN totalingAccountDescription
		WHEN totalingAccount = 988999
			THEN totalingAccountDescription
		WHEN totalingAccount = 987999
			THEN totalingAccountDescription
		ELSE NULL
		END PLGroup
	,CASE 
		WHEN totalingAccount = 491001
			THEN 77
		WHEN totalingAccount = 491002
			THEN 78
		WHEN totalingAccount = 491003
			THEN 79
		WHEN totalingAccount = 491999
			THEN 81
		WHEN totalingAccount = 492999
			THEN 82
		WHEN totalingAccount = 493999
			THEN 83
		WHEN totalingAccount = 499999
			THEN 85
		WHEN totalingAccount = 732999
			THEN 88

--GOOD

		WHEN totalingAccount = 999999
			AND DepartmentNumber = 170
			THEN 88
		WHEN totalingAccount = 891999 
			AND DepartmentNumber = 170 --NEG
			THEN 88
		WHEN (
				totalingAccount = 999999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 399
				)
			OR (
				totalingAccount = 999999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
			THEN 91
		WHEN (
				totalingAccount = 891999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
				OR (
				totalingAccount = 891999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 299
				) --NEG
			THEN 91
		WHEN totalingAccount = 999999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 599
			THEN 92
		WHEN (
				totalingAccount = 891999
				AND DepartmentNumber >= 400
				AND DepartmentNumber <= 599
				) --NEG
			THEN 92
		WHEN totalingAccount = 981999
			THEN 98
		WHEN totalingAccount = 983999
			THEN 99
		WHEN totalingAccount = 984999
			THEN 100
		WHEN totalingAccount = 985999
			THEN 101
		WHEN totalingAccount = 986999
			THEN 102
		WHEN totalingAccount = 988999
			THEN 103
		WHEN totalingAccount = 987999
			THEN 104
		ELSE NULL
		END PLOrder
	
	,CASE 
		WHEN totalingAccount = 891999 
			AND DepartmentNumber = 170 --NEG
			THEN -1
		WHEN (
				totalingAccount = 891999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
				OR (
				totalingAccount = 891999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 299
				) --NEG
			THEN -1
		WHEN (
				totalingAccount = 891999
				AND DepartmentNumber >= 400
				AND DepartmentNumber <= 599
				) --NEG
			THEN -1
		WHEN totalingAccount = 491001
			THEN -1
		WHEN totalingAccount = 491002
			THEN -1
		WHEN totalingAccount = 491003
			THEN -1
		WHEN totalingAccount = 491999
			THEN -1
		WHEN totalingAccount = 492999
			THEN -1
		WHEN totalingAccount = 493999
			THEN -1
		WHEN totalingAccount = 499999
			THEN -1
		WHEN totalingAccount = 983999
			THEN -1
		WHEN totalingAccount = 984999
			THEN -1
		WHEN totalingAccount = 985999
			THEN -1
		WHEN totalingAccount = 986999
			THEN -1
		WHEN totalingAccount = 988999
			THEN -1
		WHEN totalingAccount = 987999
			THEN -1
		ELSE 1
		END Factor
FROM PLStage


union all


SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'ExternalProForma' PLType
	,CASE when totalingAccount = 999999
			then 'Total operating expenses'
			when totalingAccount = 891999
			then 'Total operating expenses'
		END PLGroup
	,CASE when totalingAccount = 999999
			then 94
			when totalingAccount = 891999
			then 94
		ELSE NULL
		END PLOrder
	
	,CASE when totalingAccount = 999999
			then 1
			when totalingAccount = 891999
			then -1
		ELSE 1
		END Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'ExternalProForma' PLType
	,CASE when TotalingAccount = 410000
			then 'Income (loss) from operations'
			when TotalingAccount = 891999
			then 'Income (loss) from operations'
		END PLGroup
	,CASE when TotalingAccount = 410000
			then 96
			when TotalingAccount = 891999
			then 96
		ELSE NULL
		END PLOrder
	
	,CASE when TotalingAccount = 410000
			then -1
			when TotalingAccount = 891999
			then 1
		ELSE 1
		END Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'ExternalProForma' PLType
	,CASE when TotalingAccount = 400000
			then 'Net Income (Loss)'
			when TotalingAccount = 982999
			then 'Net Income (Loss)'
			when TotalingAccount = 891999
			then 'Net Income (Loss)'
		END PLGroup
	,CASE when TotalingAccount = 400000
			then 106
			when TotalingAccount = 982999
			then 106
			when TotalingAccount = 891999
			then 106
		ELSE NULL
		END PLOrder
	
	,CASE when TotalingAccount = 400000
			then -1
			when TotalingAccount = 982999
			then 1
			when TotalingAccount = 891999
			then 1
		ELSE 1
		END Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'ExternalProForma' PLType
	,CASE when TotalingAccount = 982999
			then 'Net loss attributable to noncontrolling interest'
			
		END PLGroup
	,CASE when TotalingAccount = 982999
			then 107
			
		ELSE NULL
		END PLOrder
	
	,1 Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'ExternalProForma' PLType
	,CASE when TotalingAccount = 400000
			then 'Net income (loss) attributable to common stockholders'
			when TotalingAccount = 891999
			then 'Net income (loss) attributable to common stockholders'
		END PLGroup
	,CASE when TotalingAccount = 400000
			then 108
			when TotalingAccount = 891999
			then 108
		ELSE NULL
		END PLOrder
	
	,CASE when TotalingAccount = 400000
			then -1
		ELSE 1
		END Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal ProForma' PLType
	,CASE 
		WHEN totalingAccount = 491001
			THEN totalingAccountDescription
		WHEN totalingAccount = 491002
			THEN totalingAccountDescription
		WHEN totalingAccount = 491003
			THEN totalingAccountDescription
		WHEN totalingAccount = 491999
			THEN totalingAccountDescription
		WHEN totalingAccount = 492999
			THEN totalingAccountDescription
		WHEN totalingAccount = 493999
			THEN totalingAccountDescription
		WHEN totalingAccount = 499999
			THEN totalingAccountDescription
		WHEN totalingAccount = 732999
			THEN 'Supply Chain - NC'
		WHEN totalingAccount = 739999
			AND DepartmentNumber = 170
			THEN 'Supply Chain - C'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 200
			AND DepartmentNumber <= 280
			THEN 'Antisense'
		WHEN totalingAccount = 731999
			AND DepartmentNumber = 290
			THEN 'Translational Medicine'
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 700
				AND DepartmentNumber <= 799
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 685
				)
			THEN 'Development'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 610
			AND DepartmentNumber <= 699
			AND DepartmentNumber != 685
			THEN 'Mfg and Operations'
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 800
				AND DepartmentNumber <= 890
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 899
				)
			THEN 'R&D Support'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 304
			AND DepartmentNumber <= 399
			THEN 'Medical Affairs'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 499
			THEN 'Commercial'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 500
			AND DepartmentNumber <= 599
			THEN 'SG&A'
		WHEN totalingAccount = 892999
			THEN 'Corporate Expenses'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 901
			AND DepartmentNumber <= 930
			THEN 'Corporate Expenses'
		WHEN totalingAccount = 981999
			THEN totalingAccountDescription
		WHEN totalingAccount = 983999
			THEN totalingAccountDescription
		WHEN totalingAccount = 984999
			THEN totalingAccountDescription
		WHEN totalingAccount = 985999
			THEN totalingAccountDescription
		WHEN totalingAccount = 986999
			THEN totalingAccountDescription
		WHEN totalingAccount = 988999
			THEN totalingAccountDescription
		WHEN totalingAccount = 987999
			THEN totalingAccountDescription
		when  totalingAccount = 999999
			THEN totalingAccountDescription
		when  totalingAccount = 981999
			THEN totalingAccountDescription
		ELSE NULL
		END PLGroup
	,CASE  
		WHEN totalingAccount = 491001
			THEN 109
		WHEN totalingAccount = 491002
			THEN 110
		WHEN totalingAccount = 491003
			THEN 111
		WHEN totalingAccount = 491999
			THEN 113
		WHEN totalingAccount = 492999
			THEN 115
		WHEN totalingAccount = 493999
			THEN 116
		WHEN totalingAccount = 499999
			THEN 118
		WHEN totalingAccount = 732999
			THEN 121
		WHEN totalingAccount = 739999
			AND DepartmentNumber = 170
			THEN 122
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 200
			AND DepartmentNumber <= 280
			THEN 124
		WHEN totalingAccount = 731999
			AND DepartmentNumber = 290
			THEN 125
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 700
				AND DepartmentNumber <= 799
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 685
				)
			THEN 126
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 610
			AND DepartmentNumber <= 699
			AND DepartmentNumber != 685
			THEN 127
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 800
				AND DepartmentNumber <= 890
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 899
				)
			THEN 128
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 304
			AND DepartmentNumber <= 399
			THEN 129
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 499
			THEN 130
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 500
			AND DepartmentNumber <= 599
			THEN 131
		WHEN totalingAccount = 892999
			THEN 132
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 901
			AND DepartmentNumber <= 930
			THEN 132
		WHEN totalingAccount = 981999
			THEN 140
		WHEN totalingAccount = 983999
			THEN 141
		WHEN totalingAccount = 984999
			THEN 142
		WHEN totalingAccount = 985999
			THEN 143
		WHEN totalingAccount = 986999
			THEN 144
		WHEN totalingAccount = 988999
			THEN 145
		WHEN totalingAccount = 987999
			THEN 146		
		when  totalingAccount = 999999
			THEN 136
		when  totalingAccount = 981999
			THEN 136
		ELSE NULL
		END PLOrder
	
	,case WHEN totalingAccount = 985999
			THEN -1
		WHEN totalingAccount = 986999
			THEN -1
		WHEN totalingAccount = 491001
			THEN -1
		WHEN totalingAccount = 491002
			THEN -1
		WHEN totalingAccount = 491003
			THEN -1
		WHEN totalingAccount = 491999
			THEN -1
		WHEN totalingAccount = 492999
			THEN -1 
		WHEN totalingAccount = 499999
			THEN -1
		WHEN totalingAccount = 983999
			THEN -1
		WHEN totalingAccount = 984999
			THEN -1
		
		when  totalingAccount = 999999
			THEN 1
		when  totalingAccount = 981999
			THEN -1
		else 1 end Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal ProForma' PLType
	,CASE when TotalingAccount = 999999
		then 'Total Operating Expenses'
		when totalingaccount = 891999 then 
		'Total Operating Expenses'
	ELSE NULL
		END PLGroup
	,CASE when TotalingAccount = 999999
		then 136
		when totalingaccount = 891999 then 
		136
	ELSE NULL
	END PLOrder
	
	,CASE when totalingaccount = 891999 then -1
	ELSE null
	END Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal ProForma' PLType
	,CASE when TotalingAccount = 410000
		then 'Income (Loss) From Operations'
		when totalingaccount = 891999 then 
		'Income (Loss) From Operations'
	ELSE NULL
		END PLGroup
	,CASE when TotalingAccount = 410000
		then 138
		when totalingaccount = 891999 then 
		138
	ELSE NULL
	END PLOrder
	
	,CASE when totalingaccount = 410000 then -1
	ELSE 1
	END Factor
FROM PLStage
where TotalingAccount in ( '410000','891999')

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal ProForma' PLType
	,CASE when TotalingAccount = 410000
		then 'Net Income (Loss)'
		when totalingaccount = 891999 then 
		'Net Income (Loss)'
		when totalingaccount = 982999 then 
		'Net Income (Loss)'
	ELSE NULL
		END PLGroup
	,CASE when TotalingAccount = 410000
		then 148
		when totalingaccount = 891999 then 
		148
		when totalingaccount = 982999 then  148
	ELSE NULL
	END PLOrder
	
	,CASE when totalingaccount = 410000 then -1
	ELSE 1
	END Factor
FROM PLStage  

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal ProForma' PLType
	,CASE when TotalingAccount = 982999
		then totalingAccountDescription
	ELSE NULL
		END PLGroup
	,CASE when TotalingAccount = 982999
		then 149
	ELSE NULL
	END PLOrder
	
	,1 Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal ProForma' PLType
	,CASE when TotalingAccount = 400000
		then 'Net income (loss) attributable to common stockholders'
		when totalingaccount = 891999
		then 'Net income (loss) attributable to common stockholders'
	ELSE NULL
		END PLGroup
	,CASE when TotalingAccount = 400000
		then 150
		when totalingaccount = 891999 then 
		150
	ELSE NULL
	END PLOrder
	
	,CASE when totalingaccount = 400000 then -1
	ELSE 1
	END Factor
FROM PLStage


) ta


Truncate table PL_Crosswalk_AKCEA
insert into PL_Crosswalk_AKCEA
select ta.*
from(
SELECT DISTINCT TotalingAccount
	,TotalingAccountDescription
	,mainAccount
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'External GAAP' PLType
	,CASE 
		WHEN totalingAccount = 491001
			THEN totalingAccountDescription
		WHEN totalingAccount = 491002
			THEN totalingAccountDescription
		WHEN totalingAccount = 491003
			THEN totalingAccountDescription
		WHEN totalingAccount = 491999
			THEN totalingAccountDescription
		WHEN totalingAccount = 492999
			THEN totalingAccountDescription
		WHEN totalingAccount = 493999
			THEN totalingAccountDescription
		WHEN totalingAccount = 499999
			THEN totalingAccountDescription
		WHEN totalingAccount = 732999
			THEN 'Cost of Sales'
		WHEN totalingAccount = 999999 -- need
			AND DepartmentNumber = 170
			THEN 'Cost of Sales'
		WHEN (
				totalingAccount = 999999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 399
				)
			OR (
				totalingAccount = 999999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
			THEN 'R&D'
		WHEN totalingAccount = 999999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 599
			THEN 'SG&A'
		WHEN totalingAccount = 410000
			THEN totalingAccountDescription
		WHEN totalingAccount = 981999
			THEN totalingAccountDescription
		WHEN totalingAccount = 983999
			THEN totalingAccountDescription
		WHEN totalingAccount = 984999
			THEN totalingAccountDescription
		WHEN totalingAccount = 985999
			THEN totalingAccountDescription
		WHEN totalingAccount = 986999
			THEN totalingAccountDescription
		WHEN totalingAccount = 988999
			THEN totalingAccountDescription
		WHEN totalingAccount = 987999
			THEN totalingAccountDescription
		WHEN totalingAccount = 982999
			THEN 'Net Income (Loss)'
		WHEN totalingAccount = 400000
			THEN 'Net Income (Loss)'
		ELSE NULL
		END PLGroup
	,CASE 
		WHEN totalingAccount = 491001
			THEN 1
		WHEN totalingAccount = 491002
			THEN 2
		WHEN totalingAccount = 491003
			THEN 3
		WHEN totalingAccount = 491999
			THEN 5
		WHEN totalingAccount = 492999
			THEN 6
		WHEN totalingAccount = 493999
			THEN 7
		WHEN totalingAccount = 499999
			THEN 8
		WHEN totalingAccount = 732999
			THEN 12
		WHEN totalingAccount = 999999
			AND DepartmentNumber = 170
			THEN 12
		WHEN (
				totalingAccount = 999999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 399
				)
			OR (
				totalingAccount = 999999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
			THEN 15
		WHEN totalingAccount = 999999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 599
			THEN 16
		WHEN totalingAccount = 410000
			THEN 20
		WHEN totalingAccount = 981999
			THEN 22
		WHEN totalingAccount = 983999
			THEN 23
		WHEN totalingAccount = 984999
			THEN 24
		WHEN totalingAccount = 985999
			THEN 25
		WHEN totalingAccount = 986999
			THEN 26
		WHEN totalingAccount = 988999
			THEN 27
		WHEN totalingAccount = 987999
			THEN 28
		WHEN totalingAccount = 982999
			THEN 29
		WHEN totalingAccount = 400000
			THEN 29
		ELSE NULL
		END PLOrder
	,case when totalingAccount = 400000 
			then -1
		when totalingAccount = 983999 then -1 
		WHEN totalingAccount = 984999
			THEN -1
		WHEN totalingAccount = 985999
			THEN -1
		WHEN totalingAccount = 410000
			THEN -1
		WHEN totalingAccount = 491001
			THEN 1
		WHEN totalingAccount = 491002
			THEN -1
		WHEN totalingAccount = 491003
			THEN -1
		WHEN totalingAccount = 491999
			THEN -1
		WHEN totalingAccount = 492999
			THEN -1
		WHEN totalingAccount = 493999
			THEN -1
		WHEN totalingAccount = 499999
			THEN -1
		WHEN totalingAccount = 986999
			THEN -1
		else 1 end Factor 
FROM PLStage


union all

SELECT DISTINCT TotalingAccount
	,TotalingAccountDescription
	,mainAccount
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'External GAAP' PLType
	,CASE 		WHEN totalingAccount = 999999
			THEN totalingAccountDescription
		WHEN totalingAccount = 982999
			THEN totalingAccountDescription
		WHEN totalingAccount = 400000
			THEN totalingAccountDescription
		END PLGroup
	,CASE 
		WHEN totalingAccount = 999999
			THEN 18
		WHEN totalingAccount = 982999
			THEN 31
		WHEN totalingAccount = 400000
			THEN 32
		ELSE NULL
		END PLOrder
	,case  WHEN totalingAccount = 400000
			THEN -1 else 1 end Factor
FROM PLStage


union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal GAAP' PLType
	,CASE 
		WHEN totalingAccount = 491001
			THEN totalingAccountDescription
		WHEN totalingAccount = 491002
			THEN totalingAccountDescription
		WHEN totalingAccount = 491003
			THEN totalingAccountDescription
		WHEN totalingAccount = 491999
			THEN totalingAccountDescription
		WHEN totalingAccount = 492999
			THEN totalingAccountDescription
		WHEN totalingAccount = 493999
			THEN totalingAccountDescription
		WHEN totalingAccount = 499999
			THEN totalingAccountDescription
		WHEN totalingAccount = 732999
			THEN 'Supply Chain - NC'
		WHEN totalingAccount = 739999
			AND DepartmentNumber = 170
			THEN 'Supply Chain - C'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 200
			AND DepartmentNumber <= 280
			THEN 'Antisense'
		WHEN totalingAccount = 731999
			AND DepartmentNumber = 290
			THEN 'Translational Medicine'
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 700
				AND DepartmentNumber <= 799
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 685
				)
			THEN 'Development'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 610
			AND DepartmentNumber <= 699
			AND DepartmentNumber != 685
			THEN 'Mfg and Operations'
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 800
				AND DepartmentNumber <= 890
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 899
				)
			THEN 'R&D Support'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 304
			AND DepartmentNumber <= 399
			THEN 'Medical Affairs'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 499
			THEN 'Commercial'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 500
			AND DepartmentNumber <= 599
			THEN 'SG&A'
		WHEN totalingAccount = 892999
			THEN 'Corporate Expenses'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 901
			AND DepartmentNumber <= 930
			THEN 'Corporate Expenses'
		WHEN totalingAccount = 891999
			THEN totalingAccountDescription
		WHEN totalingAccount = 999999
			THEN totalingAccountDescription
		WHEN totalingAccount = 410000
			THEN totalingAccountDescription
		WHEN totalingAccount = 891999
			THEN totalingAccountDescription
		WHEN totalingAccount = 983999
			THEN totalingAccountDescription
		WHEN totalingAccount = 984999
			THEN totalingAccountDescription
		WHEN totalingAccount = 985999
			THEN totalingAccountDescription
		WHEN totalingAccount = 986999
			THEN totalingAccountDescription
		WHEN totalingAccount = 988999
			THEN totalingAccountDescription
		WHEN totalingAccount = 987999
			THEN totalingAccountDescription
		WHEN totalingAccount = 982999
			THEN totalingAccountDescription
		WHEN totalingAccount = 400000
			THEN totalingAccountDescription
		ELSE NULL
		END PLGroup
	,CASE 
		WHEN totalingAccount = 491001
			THEN 33
		WHEN totalingAccount = 491002
			THEN 34
		WHEN totalingAccount = 491003
			THEN 35
		WHEN totalingAccount = 491999
			THEN 37
		WHEN totalingAccount = 492999
			THEN 39
		WHEN totalingAccount = 493999
			THEN 40
		WHEN totalingAccount = 499999
			THEN 42
		WHEN totalingAccount = 732999
			THEN 45
		WHEN totalingAccount = 739999
			AND DepartmentNumber = 170
			THEN 46
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 200
			AND DepartmentNumber <= 280
			THEN 48
		WHEN totalingAccount = 731999
			AND DepartmentNumber = 290
			THEN 49
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 700
				AND DepartmentNumber <= 799
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 685
				)
			THEN 50
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 610
			AND DepartmentNumber <= 699
			AND DepartmentNumber != 685
			THEN 51
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 800
				AND DepartmentNumber <= 890
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 899
				)
			THEN 52
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 304
			AND DepartmentNumber <= 399
			THEN 53
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 499
			THEN 54
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 500
			AND DepartmentNumber <= 599
			THEN 55
		WHEN totalingAccount = 892999
			THEN 56
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 901
			AND DepartmentNumber <= 930
			THEN 56
		WHEN totalingAccount = 891999
			THEN 59
		WHEN totalingAccount = 999999
			THEN 61
		WHEN totalingAccount = 410000
			THEN 63
		WHEN totalingAccount = 891999
			THEN 65
		WHEN totalingAccount = 983999
			THEN 66
		WHEN totalingAccount = 984999
			THEN 67
		WHEN totalingAccount = 985999
			THEN 68
		WHEN totalingAccount = 986999
			THEN 69
		WHEN totalingAccount = 988999
			THEN 70
		WHEN totalingAccount = 987999
			THEN 71
		WHEN totalingAccount = 982999
			THEN 74
		WHEN totalingAccount = 400000
			THEN 76
		ELSE NULL
		END PLGroup
	
	,case WHEN totalingAccount = 491001
			THEN -1
		WHEN totalingAccount = 400000
			THEN -1
		WHEN totalingAccount = 491002
			THEN -1
		WHEN totalingAccount = 491003
			THEN -1
		WHEN totalingAccount = 491999
			THEN -1
		WHEN totalingAccount = 492999
			THEN -1
		WHEN totalingAccount = 493999
			THEN -1
		WHEN totalingAccount = 499999
			THEN -1
		WHEN totalingAccount = 410000
			THEN -1
		WHEN totalingAccount = 983999
			THEN -1
		WHEN totalingAccount = 984999
			THEN -1
		WHEN totalingAccount = 985999
			THEN -1
		WHEN totalingAccount = 986999
			THEN -1
			 else 1 end Factor
FROM PLStage


union all


SELECT DISTINCT TotalingAccount
	,TotalingAccountDescription
	,mainAccount
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal GAAP' PLType
	,CASE WHEN totalingAccount = 982999
			THEN 'Net Income (Loss)'
		WHEN totalingAccount = 400000
			THEN 'Net Income (Loss)'
		END PLGroup
	,CASE 
		WHEN totalingAccount = 982999
			THEN 73
		WHEN totalingAccount = 400000
			THEN 73
		ELSE NULL
		END PLOrder
	,case when totalingAccount = 400000 then -1 else 1 end Factor 
FROM PLStage


union all


SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'ExternalProForma' PLType
	,CASE 
		WHEN totalingAccount = 491001
			THEN totalingAccountDescription
		WHEN totalingAccount = 491002
			THEN totalingAccountDescription
		WHEN totalingAccount = 491003
			THEN totalingAccountDescription
		WHEN totalingAccount = 491999
			THEN totalingAccountDescription
		WHEN totalingAccount = 492999
			THEN totalingAccountDescription
		WHEN totalingAccount = 493999
			THEN totalingAccountDescription
		WHEN totalingAccount = 499999
			THEN totalingAccountDescription
		WHEN totalingAccount = 732999
			THEN 'Cost of Sales'

--GOOD

		WHEN totalingAccount = 999999
			AND DepartmentNumber = 170
			THEN 'Cost of Sales'
		WHEN totalingAccount = 891999 
			AND DepartmentNumber = 170 --NEG
			THEN 'Cost of Sales'
		WHEN (
				totalingAccount = 999999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 399
				)
			OR (
				totalingAccount = 999999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
			THEN 'R&D'
		WHEN (
				totalingAccount = 891999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
				OR (
				totalingAccount = 891999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 299
				) --NEG
			THEN 'R&D'
		WHEN totalingAccount = 999999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 599
			THEN 'SG&A'
		WHEN (
				totalingAccount = 891999
				AND DepartmentNumber >= 400
				AND DepartmentNumber <= 599
				) --NEG
			THEN 'SG&A'
		WHEN totalingAccount = 981999
			THEN totalingAccountDescription
		WHEN totalingAccount = 983999
			THEN totalingAccountDescription
		WHEN totalingAccount = 984999
			THEN totalingAccountDescription
		WHEN totalingAccount = 985999
			THEN totalingAccountDescription
		WHEN totalingAccount = 986999
			THEN totalingAccountDescription
		WHEN totalingAccount = 988999
			THEN totalingAccountDescription
		WHEN totalingAccount = 987999
			THEN totalingAccountDescription
		ELSE NULL
		END PLGroup
	,CASE 
		WHEN totalingAccount = 491001
			THEN 77
		WHEN totalingAccount = 491002
			THEN 78
		WHEN totalingAccount = 491003
			THEN 79
		WHEN totalingAccount = 491999
			THEN 81
		WHEN totalingAccount = 492999
			THEN 82
		WHEN totalingAccount = 493999
			THEN 83
		WHEN totalingAccount = 499999
			THEN 85
		WHEN totalingAccount = 732999
			THEN 88

--GOOD

		WHEN totalingAccount = 999999
			AND DepartmentNumber = 170
			THEN 88
		WHEN totalingAccount = 891999 
			AND DepartmentNumber = 170 --NEG
			THEN 88
		WHEN (
				totalingAccount = 999999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 399
				)
			OR (
				totalingAccount = 999999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
			THEN 91
		WHEN (
				totalingAccount = 891999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
				OR (
				totalingAccount = 891999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 299
				) --NEG
			THEN 91
		WHEN totalingAccount = 999999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 599
			THEN 92
		WHEN (
				totalingAccount = 891999
				AND DepartmentNumber >= 400
				AND DepartmentNumber <= 599
				) --NEG
			THEN 92
		WHEN totalingAccount = 981999
			THEN 98
		WHEN totalingAccount = 983999
			THEN 99
		WHEN totalingAccount = 984999
			THEN 100
		WHEN totalingAccount = 985999
			THEN 101
		WHEN totalingAccount = 986999
			THEN 102
		WHEN totalingAccount = 988999
			THEN 103
		WHEN totalingAccount = 987999
			THEN 104
		ELSE NULL
		END PLOrder
	
	,CASE 
		WHEN totalingAccount = 891999 
			AND DepartmentNumber = 170 --NEG
			THEN -1
		WHEN (
				totalingAccount = 891999
				AND DepartmentNumber >= 600
				AND DepartmentNumber <= 899
				)
				OR (
				totalingAccount = 891999
				AND DepartmentNumber >= 200
				AND DepartmentNumber <= 299
				) --NEG
			THEN -1
		WHEN (
				totalingAccount = 891999
				AND DepartmentNumber >= 400
				AND DepartmentNumber <= 599
				) --NEG
			THEN -1
		WHEN totalingAccount = 491001
			THEN -1
		WHEN totalingAccount = 491002
			THEN -1
		WHEN totalingAccount = 491003
			THEN -1
		WHEN totalingAccount = 491999
			THEN -1
		WHEN totalingAccount = 492999
			THEN -1
		WHEN totalingAccount = 493999
			THEN -1
		WHEN totalingAccount = 499999
			THEN -1
		WHEN totalingAccount = 983999
			THEN -1
		WHEN totalingAccount = 984999
			THEN -1
		WHEN totalingAccount = 985999
			THEN -1
		WHEN totalingAccount = 986999
			THEN -1
		WHEN totalingAccount = 988999
			THEN -1
		WHEN totalingAccount = 987999
			THEN -1
		ELSE 1
		END Factor
FROM PLStage


union all


SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'ExternalProForma' PLType
	,CASE when totalingAccount = 999999
			then 'Total operating expenses'
			when totalingAccount = 891999
			then 'Total operating expenses'
		END PLGroup
	,CASE when totalingAccount = 999999
			then 94
			when totalingAccount = 891999
			then 94
		ELSE NULL
		END PLOrder
	
	,CASE when totalingAccount = 999999
			then 1
			when totalingAccount = 891999
			then -1
		ELSE 1
		END Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'ExternalProForma' PLType
	,CASE when TotalingAccount = 410000
			then 'Income (loss) from operations'
			when TotalingAccount = 891999
			then 'Income (loss) from operations'
		END PLGroup
	,CASE when TotalingAccount = 410000
			then 96
			when TotalingAccount = 891999
			then 96
		ELSE NULL
		END PLOrder
	
	,CASE when TotalingAccount = 410000
			then -1
			when TotalingAccount = 891999
			then 1
		ELSE 1
		END Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'ExternalProForma' PLType
	,CASE when TotalingAccount = 400000
			then 'Net Income (Loss)'
			when TotalingAccount = 982999
			then 'Net Income (Loss)'
			when TotalingAccount = 891999
			then 'Net Income (Loss)'
		END PLGroup
	,CASE when TotalingAccount = 400000
			then 106
			when TotalingAccount = 982999
			then 106
			when TotalingAccount = 891999
			then 106
		ELSE NULL
		END PLOrder
	
	,CASE when TotalingAccount = 400000
			then -1
			when TotalingAccount = 982999
			then 1
			when TotalingAccount = 891999
			then 1
		ELSE 1
		END Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'ExternalProForma' PLType
	,CASE when TotalingAccount = 982999
			then 'Net loss attributable to noncontrolling interest'
			
		END PLGroup
	,CASE when TotalingAccount = 982999
			then 107
			
		ELSE NULL
		END PLOrder
	
	,1 Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'ExternalProForma' PLType
	,CASE when TotalingAccount = 400000
			then 'Net income (loss) attributable to common stockholders'
			when TotalingAccount = 891999
			then 'Net income (loss) attributable to common stockholders'
		END PLGroup
	,CASE when TotalingAccount = 400000
			then 108
			when TotalingAccount = 891999
			then 108
		ELSE NULL
		END PLOrder
	
	,CASE when TotalingAccount = 400000
			then -1
		ELSE 1
		END Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal ProForma' PLType
	,CASE 
		WHEN totalingAccount = 491001
			THEN totalingAccountDescription
		WHEN totalingAccount = 491002
			THEN totalingAccountDescription
		WHEN totalingAccount = 491003
			THEN totalingAccountDescription
		WHEN totalingAccount = 491999
			THEN totalingAccountDescription
		WHEN totalingAccount = 492999
			THEN totalingAccountDescription
		WHEN totalingAccount = 493999
			THEN totalingAccountDescription
		WHEN totalingAccount = 499999
			THEN totalingAccountDescription
		WHEN totalingAccount = 732999
			THEN 'Supply Chain - NC'
		WHEN totalingAccount = 739999
			AND DepartmentNumber = 170
			THEN 'Supply Chain - C'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 200
			AND DepartmentNumber <= 280
			THEN 'Antisense'
		WHEN totalingAccount = 731999
			AND DepartmentNumber = 290
			THEN 'Translational Medicine'
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 700
				AND DepartmentNumber <= 799
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 685
				)
			THEN 'Development'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 610
			AND DepartmentNumber <= 699
			AND DepartmentNumber != 685
			THEN 'Mfg and Operations'
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 800
				AND DepartmentNumber <= 890
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 899
				)
			THEN 'R&D Support'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 304
			AND DepartmentNumber <= 399
			THEN 'Medical Affairs'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 499
			THEN 'Commercial'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 500
			AND DepartmentNumber <= 599
			THEN 'SG&A'
		WHEN totalingAccount = 892999
			THEN 'Corporate Expenses'
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 901
			AND DepartmentNumber <= 930
			THEN 'Corporate Expenses'
		WHEN totalingAccount = 981999
			THEN totalingAccountDescription
		WHEN totalingAccount = 983999
			THEN totalingAccountDescription
		WHEN totalingAccount = 984999
			THEN totalingAccountDescription
		WHEN totalingAccount = 985999
			THEN totalingAccountDescription
		WHEN totalingAccount = 986999
			THEN totalingAccountDescription
		WHEN totalingAccount = 988999
			THEN totalingAccountDescription
		WHEN totalingAccount = 987999
			THEN totalingAccountDescription
		when  totalingAccount = 999999
			THEN totalingAccountDescription
		when  totalingAccount = 981999
			THEN totalingAccountDescription
		ELSE NULL
		END PLGroup
	,CASE  
		WHEN totalingAccount = 491001
			THEN 109
		WHEN totalingAccount = 491002
			THEN 110
		WHEN totalingAccount = 491003
			THEN 111
		WHEN totalingAccount = 491999
			THEN 113
		WHEN totalingAccount = 492999
			THEN 115
		WHEN totalingAccount = 493999
			THEN 116
		WHEN totalingAccount = 499999
			THEN 118
		WHEN totalingAccount = 732999
			THEN 121
		WHEN totalingAccount = 739999
			AND DepartmentNumber = 170
			THEN 122
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 200
			AND DepartmentNumber <= 280
			THEN 124
		WHEN totalingAccount = 731999
			AND DepartmentNumber = 290
			THEN 125
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 700
				AND DepartmentNumber <= 799
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 685
				)
			THEN 126
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 610
			AND DepartmentNumber <= 699
			AND DepartmentNumber != 685
			THEN 127
		WHEN (
				totalingAccount = 731999
				AND DepartmentNumber >= 800
				AND DepartmentNumber <= 890
				)
			OR (
				totalingAccount = 731999
				AND DepartmentNumber = 899
				)
			THEN 128
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 304
			AND DepartmentNumber <= 399
			THEN 129
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 400
			AND DepartmentNumber <= 499
			THEN 130
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 500
			AND DepartmentNumber <= 599
			THEN 131
		WHEN totalingAccount = 892999
			THEN 132
		WHEN totalingAccount = 731999
			AND DepartmentNumber >= 901
			AND DepartmentNumber <= 930
			THEN 132
		WHEN totalingAccount = 981999
			THEN 140
		WHEN totalingAccount = 983999
			THEN 141
		WHEN totalingAccount = 984999
			THEN 142
		WHEN totalingAccount = 985999
			THEN 143
		WHEN totalingAccount = 986999
			THEN 144
		WHEN totalingAccount = 988999
			THEN 145
		WHEN totalingAccount = 987999
			THEN 146		
		when  totalingAccount = 999999
			THEN 136
		when  totalingAccount = 981999
			THEN 136
		ELSE NULL
		END PLOrder
	
	,case WHEN totalingAccount = 985999
			THEN -1
		WHEN totalingAccount = 986999
			THEN -1
		WHEN totalingAccount = 491001
			THEN -1
		WHEN totalingAccount = 491002
			THEN -1
		WHEN totalingAccount = 491003
			THEN -1
		WHEN totalingAccount = 491999
			THEN -1
		WHEN totalingAccount = 492999
			THEN -1 
		WHEN totalingAccount = 499999
			THEN -1
		WHEN totalingAccount = 983999
			THEN -1
		WHEN totalingAccount = 984999
			THEN -1
		
		when  totalingAccount = 999999
			THEN 1
		when  totalingAccount = 981999
			THEN -1
		else 1 end Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal ProForma' PLType
	,CASE when TotalingAccount = 999999
		then 'Total Operating Expenses'
		when totalingaccount = 891999 then 
		'Total Operating Expenses'
	ELSE NULL
		END PLGroup
	,CASE when TotalingAccount = 999999
		then 136
		when totalingaccount = 891999 then 
		136
	ELSE NULL
	END PLOrder
	
	,CASE when totalingaccount = 891999 then -1
	ELSE null
	END Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal ProForma' PLType
	,CASE when TotalingAccount = 410000
		then 'Income (Loss) From Operations'
		when totalingaccount = 891999 then 
		'Income (Loss) From Operations'
	ELSE NULL
		END PLGroup
	,CASE when TotalingAccount = 410000
		then 138
		when totalingaccount = 891999 then 
		138
	ELSE NULL
	END PLOrder
	
	,CASE when totalingaccount = 410000 then -1
	ELSE 1
	END Factor
FROM PLStage
where TotalingAccount in ( '410000','891999')

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal ProForma' PLType
	,CASE when TotalingAccount = 410000
		then 'Net Income (Loss)'
		when totalingaccount = 891999 then 
		'Net Income (Loss)'
		when totalingaccount = 982999 then 
		'Net Income (Loss)'
	ELSE NULL
		END PLGroup
	,CASE when TotalingAccount = 410000
		then 148
		when totalingaccount = 891999 then 
		148
		when totalingaccount = 982999 then  148
	ELSE NULL
	END PLOrder
	
	,CASE when totalingaccount = 410000 then -1
	ELSE 1
	END Factor
FROM PLStage  

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal ProForma' PLType
	,CASE when TotalingAccount = 982999
		then totalingAccountDescription
	ELSE NULL
		END PLGroup
	,CASE when TotalingAccount = 982999
		then 149
	ELSE NULL
	END PLOrder
	
	,1 Factor
FROM PLStage

union all

SELECT DISTINCT totalingAccount
	,totalingAccountDescription
	,mainAccount totalingAccountDescription
	,AccountKey
	,DepartmentKey
	,DepartmentNumber
	,'Internal ProForma' PLType
	,CASE when TotalingAccount = 400000
		then 'Net income (loss) attributable to common stockholders'
		when totalingaccount = 891999
		then 'Net income (loss) attributable to common stockholders'
	ELSE NULL
		END PLGroup
	,CASE when TotalingAccount = 400000
		then 150
		when totalingaccount = 891999 then 
		150
	ELSE NULL
	END PLOrder
	
	,CASE when totalingaccount = 400000 then -1
	ELSE 1
	END Factor
FROM PLStage


) ta





 insert into  [dbo].[PL_Crosswalk_akcea] 
select distinct '999999','Total Operating Expenses',left(AccountString,4),f.accountkey,d.departmentkey,d.DepartmentNumber ,
'internal proforma','Total Operating Expenses','136','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where AccountString  =  '7300-407-000-000'

--select * from PL_Crosswalk_akcea where pltype = 'internal proforma' and plgroup = 'Income (Loss) from Operations'

insert into  [dbo].[PL_Crosswalk_akcea] 
select distinct '999999','Total Operating Expenses',left(AccountString,4),f.accountkey,d.departmentkey,d.DepartmentNumber ,
'internal proforma','Total Operating Expenses','136','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where AccountString  =  '6405-407-000-000'


delete  from  [dbo].[PL_Crosswalk_akcea] 
 where plgroup in ('Income (Loss) from Operations')
 and pltype in ('Internal ProForma')

 insert into  [dbo].[PL_Crosswalk_akcea] 
select '410000','Income (Loss) from Operations',mainaccount,accountkey,departmentkey,departmentnumber
,'Internal ProForma','Income (Loss) from Operations',138,case when plgroup in ('Total Operating Expenses') then -1* factor
when (plgroup = 'total revenue' and (mainaccount = '4317' AND departmentnumber = '000'))
or (plgroup = 'total revenue' and (mainaccount = '4318' AND departmentnumber = '000')) then -1
when plgroup = 'Total Revenue' then 1 else factor end 
 from  [dbo].[PL_Crosswalk_akcea] 
 where plgroup in ('Total Operating Expenses',
 'Total Revenue'
)
 and pltype in ('Internal ProForma')



 
delete from  [dbo].[PL_Crosswalk_akcea] 
where plgroup = 'Net income (loss) attributable to common stockholders' and pltype in ('Internal ProForma')

 insert into  [dbo].[PL_Crosswalk_akcea] 
select '400000','Total Net Income (Loss)',mainaccount,accountkey,departmentkey,departmentnumber
,'Internal ProForma','Net income (loss) attributable to common stockholders',150,
case when plgroup = 'Total Income Tax Benefit (Expense)' then factor*-1 else factor end 
from  [dbo].[PL_Crosswalk_akcea] 
 where plgroup in ('Total Income (Loss) from Operations','Total Income Tax Benefit (Expense)',
 'Total Investment Income','Total Other Income')
 and pltype in ('Internal ProForma')

 
--select * from PL_Crosswalk_akcea where pltype = 'internal proforma' and plgroup = 'Net income (loss) attributable to common stockholders'
 
delete from  [dbo].[PL_Crosswalk_akcea] 
where plgroup = 'Net Income (Loss)' and pltype in ('Internal ProForma')

 insert into  [dbo].[PL_Crosswalk_akcea] 
select '400000','Net Income (Loss)',mainaccount,accountkey,departmentkey,departmentnumber
,'Internal ProForma','Net Income (Loss)',148,
case when plgroup = 'Total Income Tax Benefit (Expense)' then factor*-1 else factor end 
from  [dbo].[PL_Crosswalk_akcea] 
 where plgroup in ('Total Income (Loss) from Operations','Total Income Tax Benefit (Expense)',
 'Total Investment Income','Total Other Income')
 and pltype in ('Internal ProForma')

--5019-745-000-000

insert into  [dbo].[PL_Crosswalk_akcea] 
select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey,d.departmentkey,d.DepartmentNumber ,
'internal proforma','Mfg and Operations','127','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where AccountString  =  '5019-670-000-000'


insert into  [dbo].[PL_Crosswalk_akcea] 
select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey,d.departmentkey,d.DepartmentNumber ,
'internal proforma','Total Operating Expenses','136','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where AccountString  =  '5019-745-000-000'


insert into  [dbo].[PL_Crosswalk_akcea] 
select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey,d.departmentkey,d.DepartmentNumber ,
'internal proforma','Total Operating Expenses','136','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where AccountString  =  '5019-670-000-000'


insert into  [dbo].[PL_Crosswalk_akcea] 
select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey,d.departmentkey,d.DepartmentNumber ,
'internal proforma','Total Operating Expenses','136','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where AccountString  =  '5005-318-000-000'


insert into  [dbo].[PL_Crosswalk_akcea] 
select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey,d.departmentkey,d.DepartmentNumber ,
'internal proforma','Total Operating Expenses','136','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where AccountString  in(
'5000-512-000-000',
'5005-413-000-000',
'5005-452-000-000',
'5005-512-000-000',
'5008-512-000-000',
'5010-512-000-000',
'5016-512-000-000',
'5019-512-000-000',
'5100-512-000-000',
'5201-512-000-000',
'6403-512-000-000',
'6405-512-000-000',
'7000-512-000-000',
'7000-512-152-000',
'7000-512-153-000',
'7000-512-000-000',
'7000-512-000-000',
'7014-417-000-000')


delete from   [dbo].[PL_Crosswalk_akcea] 
where pltype = 'internal proforma'
and plgroup = 'sg&a'
and concat(mainaccount,'-',departmentnumber) in (
'5000-512',
'5005-512',
'5008-512',
'5010-512',
'5016-512',
'5019-512',
'5100-512',
'5201-512',
'6403-512',
'6405-512',
'7000-512',
'7000-512')

--select * from  [dbo].[PL_Crosswalk_akcea]  where  pltype = 'internal proforma' and plorder = '132'
insert into  [dbo].[PL_Crosswalk_akcea] 
select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey,d.departmentkey,d.DepartmentNumber ,
'internal proforma','SG&A','131','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where AccountString  in(
'5019-540-000-000'
)


insert into  [dbo].[PL_Crosswalk_akcea] 
select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey,d.departmentkey,d.DepartmentNumber ,
'internal proforma','Corporate Expenses','132','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where AccountString 
 in(
'9000-541-000-000',
'9200-598-000-000',
'9200-899-000-000',
'9821-598-000-000',
'9821-899-000-000',
'9201-411-000-000'
)


--delete from  [dbo].[PL_Crosswalk_akcea] 
--where concat (mainaccount,'-',departmentnumber)
--in ('5005-512'
--,'5008-512'
--,'5010-512'
--,'5016-512'
--,'5100-512'
--,'5201-512'
--,'6403-512'
--,'7000-512'
--,'7000-512'
--,'7000-512'
--)
--and plorder = 130


delete from PL_Crosswalk_akcea
where plorder = 136

insert into [dbo].[PL_Crosswalk_akcea] 
select totalingAccount,TotalingAccountDescription,MainAccount
,accountKey,DepartmentKey,DepartmentNumber,'internal proforma','Total Operating Expenses',136
,1 from PL_Crosswalk_akcea
where plorder >= 121
and  plorder <= 132

--118,136

delete from PL_Crosswalk_akcea
where plorder = 138

insert into [dbo].[PL_Crosswalk_akcea] 
select totalingAccount,TotalingAccountDescription,MainAccount
,accountKey,DepartmentKey,DepartmentNumber,'internal proforma','Income (Loss) from Operations',138
,case when plorder = 136 then -1 else 1 end from PL_Crosswalk_akcea
where (plorder = 118
or plorder = 136)


 
delete from  [dbo].[PL_Crosswalk_akcea] 
where plgroup = 'Net income (loss) attributable to common stockholders' and pltype in ('Internal ProForma')

 insert into  [dbo].[PL_Crosswalk_akcea] 
select '400000','Total Net Income (Loss)',mainaccount,accountkey,departmentkey,departmentnumber
,'Internal ProForma','Net income (loss) attributable to common stockholders',150,
case when plgroup = 'Total Income Tax Benefit (Expense)' then factor*-1 else factor end 
from  [dbo].[PL_Crosswalk_akcea] 
where plorder >= 138
and plorder <= 146

delete from  [dbo].[PL_Crosswalk_akcea] 
where plgroup = 'Net income (Loss)' and pltype in ('Internal ProForma')

 insert into  [dbo].[PL_Crosswalk_akcea] 
select '400000','Total Net Income (Loss)',mainaccount,accountkey,departmentkey,departmentnumber
,'Internal ProForma','Net income (Loss)',148,
case when plgroup = 'Total Income Tax Benefit (Expense)' then factor*-1 else factor end 
from  [dbo].[PL_Crosswalk_akcea] 
where plorder >= 138
and plorder <= 146

--NEW___NEW

delete from  [dbo].[PL_Crosswalk_akcea] 
where plorder >= 121
and plorder <= 132


 insert into  [dbo].[PL_Crosswalk_akcea] 
 select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey
 ,isnull(d.departmentkey,'1'),isnull(d.DepartmentNumber,'000') ,
'internal proforma','Cost of Sales','121','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where (((left(AccountString ,4) >= '4600'
and left(AccountString ,4) <= '4695')
or d.departmentnumber = '170')
and left(AccountString ,1) <> '9')



 insert into  [dbo].[PL_Crosswalk_akcea] 
 select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey
 ,isnull(d.departmentkey,'1'),isnull(d.DepartmentNumber,'000') ,
'internal proforma','Development','122','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where 
 ((d.DepartmentNumber like '7%' or d.DepartmentNumber = '685' ) and d.DepartmentNumber <> '798' 
 and d.DepartmentNumber <> '799' 
 and (left(AccountString,4) <> '5018'
      and (left(AccountString,1) <> '9'
	  or left(AccountString,4) = '9806')))

 
--Mfg and Operations	departments 610-699, + accout 9806


delete from  [dbo].[PL_Crosswalk_akcea] 
where plorder >= 123
and plorder <= 123

 insert into  [dbo].[PL_Crosswalk_akcea] 
 select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey
 ,isnull(d.departmentkey,'1'),isnull(d.DepartmentNumber,'000') ,
'internal proforma','Mfg and Operations','123','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where 
(
(d.departmentnumber like '61%'
or  d.departmentnumber like '62%'
or  d.departmentnumber like '63%'
or  d.departmentnumber like '64%'
or  d.departmentnumber like '65%'
or  d.departmentnumber like '66%'
or  d.departmentnumber like '67%'
or  d.departmentnumber like '68%'
or  d.departmentnumber like '69%')
 and (left(AccountString,4) <> '5018'
      and (left(AccountString,1) <> '9'
	  or left(AccountString,4) = '9806')
	  and d.DepartmentNumber <> '685')
)


 insert into  [dbo].[PL_Crosswalk_akcea] 
 select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey
 ,isnull(d.departmentkey,'1'),isnull(d.DepartmentNumber,'000') ,
'internal proforma','R&D Support','124','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where 
(
( d.departmentnumber like '80%'
or  d.departmentnumber like '81%'
or  d.departmentnumber like '82%'
or  d.departmentnumber like '83%'
or  d.departmentnumber like '84%'
or  d.departmentnumber like '85%'
or  d.departmentnumber like '86%'
or  d.departmentnumber like '87%'
or  d.departmentnumber like '88%'
or d.departmentnumber  = '890'
or d.departmentnumber  = '899'
 )
 and (left(AccountString,4) <> '5018'
      and (left(AccountString,1) <> '9'
	  or left(AccountString,4) = '9806'))
)



 insert into  [dbo].[PL_Crosswalk_akcea] 
 select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey
 ,isnull(d.departmentkey,'1'),isnull(d.DepartmentNumber,'000') ,
'internal proforma','Medical Affairs','125','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where 
(
((d.departmentnumber in ('304','305','305','306','307','308','309') or 
d.departmentnumber like '31%' or 
d.departmentnumber like '32%' or 
d.departmentnumber like '33%' or 
d.departmentnumber like '34%' or 
d.departmentnumber like '35%' or 
d.departmentnumber like '36%' or 
d.departmentnumber like '37%' or 
d.departmentnumber like '38%' or 
d.departmentnumber like '39%') and d.departmentnumber <> '398' and d.departmentnumber <> '399')

 and (left(AccountString,4) <> '5018'
      and (left(AccountString,1) <> '9'
	  or left(AccountString,4) = '9806'))
 )



 insert into  [dbo].[PL_Crosswalk_akcea] 
 select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey
 ,isnull(d.departmentkey,'1'),isnull(d.DepartmentNumber,'000') ,
'internal proforma','Commercial','126','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where 
(
((d.departmentnumber like '40%'
or d.departmentnumber like '41%'
or d.departmentnumber like '42%'
or d.departmentnumber like '43%'
or d.departmentnumber like '44%'
or d.departmentnumber like '45%'
or d.departmentnumber like '46%'
or d.departmentnumber like '47%'
or d.departmentnumber like '48%'
or d.departmentnumber like '49%'
or d.departmentnumber = '512')
and  d.departmentnumber <> '499'
 )
 and (left(AccountString,4) <> '5018'
      and (left(AccountString,1) <> '9'
	  or left(AccountString,4) = '9806'))
	  
and  d.departmentnumber <> '499'
)




 insert into  [dbo].[PL_Crosswalk_akcea] 
 select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey
 ,isnull(d.departmentkey,'1'),isnull(d.DepartmentNumber,'000') ,
'internal proforma','SG&A','127','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where 
(
(d.departmentnumber like '5%'
and d.departmentnumber <> '512'
 )
 
 and (left(AccountString,4) <> '5018'
      and (left(AccountString,1) <> '9'
	  or left(AccountString,4) = '9806'))
)


delete from  [dbo].[PL_Crosswalk_akcea] 
where plorder = '128'

 insert into  [dbo].[PL_Crosswalk_akcea] 
 select distinct '731999','Total Controllable (excl. COGS)',left(AccountString,4),f.accountkey
 ,isnull(d.departmentkey,'1'),isnull(d.DepartmentNumber,'000') ,
'internal proforma','Corporate Expenes	','128','1'
from FactTransaction f 
left join DimDepartment d on d.departmentkey = f.departmentkey 
where 
(
(d.departmentnumber in ('901','902','903','904','905','906','907','908','909','930','931','932','933','934','935')
or d.departmentnumber like '91%'
or d.departmentnumber like '92%')
or (
 left(accountstring ,1) = '9'
or left(accountstring ,4) = '5018'
and left(accountstring ,4) <> '9806'
 )
)
delete from [PL_Crosswalk_akcea] where plorder = 128 and mainaccount in ( '9806','9941','9942','9110','9110','9120')



delete from [PL_Crosswalk_akcea] where mainaccount = '3506'  or  mainaccount =  '4901'
or mainAccount = '9805'

delete from PL_Crosswalk_AKCEA where mainaccount in ('4900' ,'4901','4902','4903','4910','4911','4912','4920'
,'4922','4923','4930','4931','4932','4933','4934','4935','4940','4941','4942','4945','4946','4947'
,'4950','4953','4954','4955','4960','8013','8014','8015','9107','9110','9119','9120','9941','9942')
and plorder >= 121
and plorder <= 132

delete from PL_Crosswalk_akcea
where plorder = 136

insert into [dbo].[PL_Crosswalk_akcea] 
select totalingAccount,TotalingAccountDescription,MainAccount
,accountKey,DepartmentKey,DepartmentNumber,'internal proforma','Total Operating Expenses',136
,1 from PL_Crosswalk_akcea
where plorder >= 121
and  plorder <= 132

delete from PL_Crosswalk_akcea
where plorder = 138

insert into [dbo].[PL_Crosswalk_akcea] 
select totalingAccount,TotalingAccountDescription,MainAccount
,accountKey,DepartmentKey,DepartmentNumber,'internal proforma','Income (Loss) from Operations',138
,case when plorder = 136 then -1 else 1 end from PL_Crosswalk_akcea
where (plorder = 118
or plorder = 136)


delete from  [dbo].[PL_Crosswalk_akcea] 
where plgroup = 'Net income (loss) attributable to common stockholders' and pltype in ('Internal ProForma')

 insert into  [dbo].[PL_Crosswalk_akcea] 
select '400000','Total Net Income (Loss)',mainaccount,accountkey,departmentkey,departmentnumber
,'Internal ProForma','Net income (loss) attributable to common stockholders',150,
case when plgroup = 'Total Income Tax Benefit (Expense)' then factor*-1 else factor end 
from  [dbo].[PL_Crosswalk_akcea] 
where plorder >= 138
and plorder <= 146

delete from  [dbo].[PL_Crosswalk_akcea] 
where plgroup = 'Net income (Loss)' and pltype in ('Internal ProForma')

 insert into  [dbo].[PL_Crosswalk_akcea] 
select '400000','Total Net Income (Loss)',mainaccount,accountkey,departmentkey,departmentnumber
,'Internal ProForma','Net income (Loss)',148,
case when plgroup = 'Total Income Tax Benefit (Expense)' then factor*-1 else factor end 
from  [dbo].[PL_Crosswalk_akcea] 
where plorder >= 138
and plorder <= 146




delete from [PL_Crosswalk_akcea] where mainaccount = '3506'  or  mainaccount =  '4901'
or mainAccount = '9805'

delete from PL_Crosswalk_AKCEA where mainaccount in ('4900' ,'4901','4902','4903','4910','4911','4912','4920'
,'4922','4923','4930','4931','4932','4933','4934','4935','4940','4941','4942','4945','4946','4947'
,'4950','4953','4954','4955','4960','8013','8014','8015','9107','9110','9119','9120','9941','9942')
and plorder >= 121
and plorder <= 132
