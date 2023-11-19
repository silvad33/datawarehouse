CREATE VIEW V_VendorBankExtract
AS
SELECT V.VENDORORGANIZATIONNAME AS [Legal Name]
	, S.CoupaSupplierID AS [Payee ID]
	, 'Yes' AS [Enable Coupa Pay]
	, V.DEFAULTVENDORPAYMENTMETHODNAME AS [Method]
	, V.PRIMARYEMAILADDRESS AS [Payment Delivery Email]
	, 'UNKNOWN' AS [Bank Account Country]
	, 'UNKNOWN' AS [Bank Account Currency Code]
	, VB.BANKNAME AS [Bank Name]
	, VB.BANKACCOUNTNUMBER AS [Account Number]
	, VB.IBAN AS [IBAN]
	, 'UNKNOWN' AS [Transit Code Type]
	, 'UNKNOWN' AS [Transit Code]
	, VB.SWIFTCODE AS [SWIFT Code]
	, 'UNKNOWN' AS [Account Type]
	, 'UNKNOWN' AS [Bank Address Line 1]
	, 'UNKNOWN' AS [Bank Address Line 2]
	, 'UNKNOWN' AS [City]
	, 'UNKNOWN' AS [State]
	, 'UNKNOWN' AS [Postal Code]
	, 'UNKNOWN' AS [RemitTo Code]
	, 'UNKNOWN' AS [Document Types]
FROM VendVendorBankAccountStaging AS VB
  INNER JOIN VendVendorV2Staging AS V ON VB.VENDORACCOUNTNUMBER = V.VENDORACCOUNTNUMBER AND V.VENDORGROUPID <> 'EMP'
  INNER JOIN DimSupplier AS S ON VB.VENDORACCOUNTNUMBER = S.SupplierID

