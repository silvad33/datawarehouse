CREATE TABLE [financial].[StgCoupaUsers] (
    CoupaId INT
    , CreatedAt DATETIME
    , UpdatedAt DATETIME
    , Login VARCHAR(50)
    , Email VARCHAR(256)
    , PurchasingUser VARCHAR(5)
    , ExpenseUser VARCHAR(5)
    , SourcingUser VARCHAR(5)
    , InventoryUser VARCHAR(5)
    , ContractsUser VARCHAR(5)
    , AnalyticsUser VARCHAR(5)
    , AicUser VARCHAR(5)
    , SpendGuardUser VARCHAR(5)
    , CcwUser VARCHAR(5)
    , ClmAdvancedUser VARCHAR(5)
    , SupplyChainUser VARCHAR(5)
    , EmployeeNumber VARCHAR(50)
    , FirstName VARCHAR(50)
    , LastName VARCHAR(50)
    , FullName VARCHAR(250)
    , ApiUser VARCHAR(5)
    , Active VARCHAR(5)
    , SalesforceId INT
    , AccountSecurityType INT
    , AuthenticationMethod VARCHAR(50)
    , SsoIdentifier VARCHAR(250)
    , DefaultLocale VARCHAR(50)
    , BusinessGroupSecurityType INT
    , EditInvoiceOnQuickEntry VARCHAR(5)
    , MentionName VARCHAR(50)
    , EmployeePaymentChannel VARCHAR(50)
    , DepartmentCode VARCHAR(10)
    , ManagerCoupaId INT
    )
