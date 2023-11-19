CREATE TABLE [dbo].[StgCoupaSuppliers]
(
	SupplierKey int null,
	SupplierName varchar(250) null,
	CoupaSupplierID int null,
	Entity varchar(10) null,
	SupplierID varchar(20) null,
	LastUpdated datetime null,
	D365SupplierId varchar(20) null,
	FederalTaxId varchar(100) null,
	InternationTaxId varchar(100) null,
	LocationCode varchar(250) null,
	StreetOne varchar(250) null,
	StreetTwo varchar(250) null,
	City varchar(250) null,
	State varchar(100) null,
	PostalCode varchar(50) null,
	Country varchar(250) null
)
