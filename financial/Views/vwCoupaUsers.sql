CREATE VIEW [financial].[vwCoupaUsers]
	AS SELECT SUBSTRING(du.userprincipalname, 1, (charindex('@' , du.userprincipalname, 1) - 1)) AS [Login]
    , du.userprincipalname AS [SsoIdentifier]
    , du.userprincipalname AS Email
    , du.firstname
    , du.lastname
    , replace(dd.departmentnumberdescription, '- ', '') AS department
    , du.WorkPhone AS PhoneWork
    , du.CellPhone AS PhoneMobile
    , du.stocklevelcode AS ApprovalLimit
    , du2.CoupaUserId AS ApproverCoupaUserId --ds07292021 changed to coupa user id
    , CASE du.CompanyCode
        WHEN 'IONS'
            THEN 'Ionis'
        WHEN 'AKCA'
            THEN 'Akcea - Canada'
        WHEN 'AKDE'
            THEN 'Akcea - Germany'
        WHEN 'AKFR'
            THEN 'Akcea - France'
        WHEN 'AKIE'
            THEN 'Akcea - Ireland'
        WHEN 'AKUK'
            THEN 'Akcea - UK'
        WHEN 'AKUS'
            THEN 'Akcea'
        WHEN 'AKIT'
            THEN 'Akcea - Italy'
        WHEN 'AKES'
            THEN 'Akcea - Spain'
        WHEN 'AKPT'
            THEN 'Akcea - Portugal'
        ELSE du.CompanyCode
        END AS [DefaultChartofAccountsName]
    , du.CompanyCode AS [ContentGroups]
    , dd.departmentnumber AS [DepartmentCode]
        --, CASE 
        --WHEN du.CompanyCode = 'IONS'
        --    THEN 'Isis'
        --ELSE du.CompanyCode
        --END AS [DefaultAddressLocationCode]
    , CASE 
       WHEN du.workplacename IN ('Faraday Twenty Two Eighty', 'Faraday Twenty Two Eighty Two')
           THEN 'MM Receiving'
       WHEN du.WorkplaceName = 'Akcea Therapeutics Inc.'
            THEN 'AKUS'
       ELSE 'Isis'
       END AS [DefaultAddressLocationCode]
    , CASE du.CompanyCode
        WHEN 'IONS'
            THEN 'Department Restricted'
        ELSE 'Department Restricted - ' + du.CompanyCode
        END AS [DefaultAccountGroupName]
    , CASE du.CompanyCode
        WHEN 'IONS'
            THEN 'USD'
        WHEN 'AKUS'
            THEN 'USD'
        WHEN 'AKCA'
            THEN 'CAD'
        WHEN 'AKDE'
            THEN 'EUR'
        WHEN 'AKFR'
            THEN 'EUR'
        WHEN 'AKUK'
            THEN 'GBP'
        WHEN 'AKIE'
            THEN 'EUR'
        WHEN 'AKIT'
            THEN 'EUR'
        WHEN 'AKES'
            THEN 'EUR'
        WHEN 'AKPT'
            THEN 'EUR'
        END AS [DefaultCurrency]
    , du.EmployeeNumber AS [EmployeeID]
    , COALESCE(du.datemodified, du.dateinserted) AS lastupdateddate
    , du.CoupaUserID
FROM dbo.dimUser AS du
    LEFT JOIN dbo.dimuser AS du2
    ON du.managerkey = du2.userkey
    LEFT JOIN dbo.dimdepartment AS dd
    ON du.departmentkey = dd.departmentkey
WHERE isnull(du.userprincipalname, '') <> ''
    and du.usertype in ('Employee', 'Temp', 'TMP', 'AGN')
    and isnull(du.companycode, '') <> ''
    and du.active = 1
    and isnull(du.employeenumber, '') <> ''
