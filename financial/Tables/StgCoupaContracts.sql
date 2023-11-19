﻿CREATE TABLE financial.StgCoupaContracts (
Id INT NULL,
CreatedAt DATETIME NULL,
UpdatedAt DATETIME NULL,
Name VARCHAR(250) NULL,
Number VARCHAR(250) NULL,
Type VARCHAR(50) NULL,
Version INT NULL,
StartDate DATETIME NULL,
EndDate DATETIME NULL,
Status VARCHAR(20) NULL,
MinimumValue FLOAT NULL,
MaximumValue FLOAT NULL,
StopSpendBasedOnMaxValue VARCHAR(10) NULL,
Terms VARCHAR(250) NULL,
Preferred VARCHAR(250) NULL,
SavingsPct VARCHAR(10) NULL,
MinCommit FLOAT NULL,
MaxCommit FLOAT NULL,
SupplierInvoiceable VARCHAR(10) NULL,
IsDefault VARCHAR(10) NULL,
SupplierAccount VARCHAR(250) NULL,
UseOrderWindows VARCHAR(10) NULL,
OrderWindowTz VARCHAR(250) NULL,
RequisitionMessage VARCHAR(250) NULL,
PoMessage VARCHAR(250) NULL,
LegalAgreement VARCHAR(250) NULL,
CurrentApproval VARCHAR(250) NULL,
UsedForBuying VARCHAR(10) NULL,
StrictInvoicingRules VARCHAR(10) NULL,
TermType VARCHAR(250) NULL,
AutoExtendEndDateForRenewal VARCHAR(10) NULL,
Terminated VARCHAR(10) NULL,
TerminationNotice VARCHAR(250) NULL,
TerminationNoticeLengthUnit VARCHAR(50) NULL,
TerminationNoticeLengthValue VARCHAR(50) NULL,
Consent VARCHAR(250) NULL,
NoOfRenewals INT NULL,
RenewalLengthUnit VARCHAR(50) NULL,
RenewalLengthValue VARCHAR(50) NULL,
LengthOfNoticeUnit VARCHAR(50) NULL,
LengthOfNoticeValue VARCHAR(50) NULL,
SourceId INT NULL,
SourceType VARCHAR(50) NULL,
Source VARCHAR(50) NULL,
QuoteResponseId VARCHAR(50) NULL,
Description VARCHAR(250) NULL,
PublishedDate DATETIME NULL,
ExecutionDate DATETIME NULL,
ProxySupplierId INT NULL,
SupplierCoupaId INT NULL, 
CurrencyCoupaId INT NULL,
CreatedByCoupaId INT NULL,
UpdatedByCoupaId INT NULL)