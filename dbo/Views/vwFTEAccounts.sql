﻿Create view vwFTEAccounts as
Select *
from MAINACCOUNTSTAGING
where 
MAINACCOUNTCATEGORY in ('BENEFITS',
'BONUS',
'CPAACCRUAL',
'MBO',
'SALARY')