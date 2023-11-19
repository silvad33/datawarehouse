﻿CREATE TABLE [dbo].[FreeTextInvoiceStaging](
	[FREETEXTNUMBER] [nvarchar](20) NOT NULL,
	[INVOICEDATE] [datetime] NOT NULL,
	[CUSTOMERACCOUNT] [nvarchar](20) NOT NULL,
	[INVOICEACCOUNT] [nvarchar](20) NOT NULL,
	[CURRENCYCODE] [nvarchar](3) NOT NULL,
	[DUEDATE] [datetime] NOT NULL,
	[LINENUMBER] [numeric](32, 16) NOT NULL,
	[LEDGERDIMENSIONDISPLAYVALUE] [nvarchar](500) NOT NULL,
	[AMOUNTCUR] [numeric](32, 6) NOT NULL,
	[DEFAULTDIMENSIONDISPLAYVALUE] [nvarchar](500) NOT NULL,
	[DIRECTDEBITMANDATEID] [nvarchar](35) NOT NULL,
	[NGPCODE] [int] NOT NULL,
	[POSTPONEDVAT] [int] NOT NULL,
	[CFPSCODE] [nvarchar](4) NOT NULL,
	[ISFINALUSER] [int] NOT NULL,
	[FISCALOPERATIONPRESENCETYPE] [int] NOT NULL,
	[ISSERVICEDELIVERYADDRESSBASED] [int] NOT NULL,
	[CFOPCODE] [nvarchar](5) NOT NULL,
	[FISCALDOCUMENTTYPEID] [nvarchar](10) NOT NULL,
	[FISCALESTABLISHMENTID] [nvarchar](10) NOT NULL,
	[FISCALDOCUMENTOPERATIONTYPEID] [nvarchar](10) NOT NULL,
	[TRANSPORTATIONDOCUMENTLINEID] [uniqueidentifier] NOT NULL,
	[DEFINITIONGROUP] [nvarchar](60) NOT NULL,
	[EXECUTIONID] [nvarchar](90) NOT NULL,
	[ISSELECTED] [int] NOT NULL,
	[TRANSFERSTATUS] [int] NOT NULL,
	[POSTINGPROFILE] [nvarchar](10) NOT NULL,
	[METHODOFPAYMENT] [nvarchar](10) NOT NULL,
	[TERMSOFPAYMENT] [nvarchar](100) NOT NULL,
	[CASHDISCOUNTCODE] [nvarchar](10) NOT NULL,
	[CASHDISCOUNTDATE] [datetime] NOT NULL,
	[DOCUMENTDATE] [datetime] NOT NULL,
	[DESCRIPTION] [nvarchar](512) NOT NULL,
	[QUANTITY] [numeric](32, 6) NOT NULL,
	[UNITPRICE] [numeric](32, 6) NOT NULL,
	[SALESTAXGROUP] [nvarchar](10) NOT NULL,
	[SALESTAXITEMGROUP] [nvarchar](10) NOT NULL,
	[CUSTOMERREFERENCE] [nvarchar](60) NOT NULL,
	[CUSTOMERREQUISITION] [nvarchar](20) NOT NULL,
	[BILLINGCLASSIFICATION] [nvarchar](15) NOT NULL,
	[BILLINGCODE] [nvarchar](10) NOT NULL,
	[EINVOICEACCOUNTCODE] [nvarchar](35) NOT NULL,
	[EINVOICEISLINESPECIFIC] [int] NOT NULL,
	[GIROTYPE] [int] NOT NULL,
	[ISLUMPSUMRECOVERYTEXTPRINTED] [int] NOT NULL,
	[PROPERTYNUMBER] [nvarchar](20) NOT NULL,
	[INCLTAX] [int] NOT NULL,
	[DELIVERYDATE] [datetime] NOT NULL,
	[DISCOUNTPERCENTAGE] [numeric](32, 6) NOT NULL,
	[CUSTOMERPAYMENTFINECODE] [nvarchar](10) NOT NULL,
	[CUSTOMERPAYMENTFINANCIALINTERESTCODE] [nvarchar](10) NOT NULL,
	[COMPLEMENTARYFISCALDOCUMENTTYPE] [int] NOT NULL,
	[CONSIGNEEACCOUNT] [nvarchar](20) NOT NULL,
	[CONSIGNORACCOUNT] [nvarchar](20) NOT NULL,
	[ISCORRECTION] [int] NOT NULL,
	[CORRECTEDFACTUREDATE] [datetime] NOT NULL,
	[CORRECTEDFACTUREEXTERNALID] [nvarchar](30) NOT NULL,
	[CORRECTEDINVOICEDATE] [datetime] NOT NULL,
	[CORRECTEDINVOICEID] [nvarchar](60) NOT NULL,
	[CORRECTEDPERIOD] [datetime] NOT NULL,
	[CORRECTIONTYPE] [int] NOT NULL,
	[VATONPAYMENT] [int] NOT NULL,
	[NONREALREVENUE] [int] NOT NULL,
	[PARTITION] [nvarchar](20) NOT NULL,
	[INVOICETXT] [nvarchar](max) NULL,
	[HEADERDEFAULTDIMENSIONDISPLAYVALUE] [nvarchar](500) NOT NULL,
	[DATEOFVATREGISTER] [datetime] NOT NULL,
	[SALESDATE] [datetime] NOT NULL,
	[INTENTLETTERID_IT] [nvarchar](10) NOT NULL,
	[RSMSALESID] [nvarchar](60) NOT NULL,
	[RSMEXPORTED] [int] NOT NULL,
	[RSMLINENUMBER] [int] NOT NULL,
	[DATAAREAID] [nvarchar](4) NOT NULL,
	[SYNCSTARTDATETIME] [datetime] NOT NULL,
	[RECID] [bigint] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]