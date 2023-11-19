CREATE PROCEDURE [dbo].[spFactAccountingSourceExplorer]
AS
TRUNCATE TABLE FactAccountingSourceExplorer

INSERT INTO FactAccountingSourceExplorer
-- Main
SELECT 'Journal'
    , gje.JournalNumber
    , gje.AccountingDate
    , gje.VOUCHER
    , gje.DocumentNumber
    , CASE 
        WHEN datepart(year, gje.DocumentDate) = 1900
            THEN NULL
        ELSE gje.DocumentDate
        END AS DocumentDate
    , gje.JournalCategory
    , gje.PostingType
    , gje.DESCRIPTION
    , gje.LedgerAccount
    , gje.TransactionCurrencyCode
    , jdc.LedgerDimension
    , gje.Recid AS GeneralJournalAccountEntry
    , gje.IsCorrection
    , 0 AS Side
    , gje.AccountingCurrencyAmount
    , gje.ReportingCurrencyAmount
    , gje.TransactionCurrencyAmount
    , NULL AS MonetaryAmount
    , 0 AS AccountingDistributionRecId
    , gje.DATAAREAID AS DestinationCompany
    , CONVERT(VARCHAR(1000), '') AS TypeEnumName
    , 0 AS SourceDocumentRecId
    , CONVERT(VARCHAR(1000), '') AS SourceRelationType
    , 0 AS MainAccountId
    , CONVERT(VARCHAR(1000), '') AS MainAccountName
    , CONVERT(VARCHAR(1000), '') AS PartyNumber
    , CONVERT(VARCHAR(1000), '') AS PartyName
    , '' AS LINEDOCUMENTREFERENCE
    , ptcr.PostingTypeDescription
FROM GeneralJournalAccountEntryStaging gje
JOIN RSMJournalDimensionCrosswalkStaging jdc
    ON jdc.GeneralJournalRecid = gje.RECID
LEFT JOIN PostingTypeCrossReference ptcr
    ON gje.PostingType = ptcr.PostingType
WHERE NOT gje.RECID IN (
        SELECT GENERALJOURNALACCOUNTENTRY
        FROM RSMsubledgerJournalAccountEntryStaging
        )

UNION

-- SubLedger
SELECT 'SubLedger Summary'
    , isnull(sje.JOURNALNUMBER, gje.JournalNumber) AS JournalNumber
    , gje.AccountingDate
    , gje.VOUCHER
    , gje.DocumentNumber
    , CASE 
        WHEN datepart(year, gje.DocumentDate) = 1900
            THEN NULL
        ELSE gje.DocumentDate
        END AS DocumentDate
    , gje.JournalCategory
    , gje.PostingType
    , gje.DESCRIPTION
    , gje.LedgerAccount
    , gje.TransactionCurrencyCode
    , jdc.LedgerDimension
    , gje.Recid AS GeneralJournalAccountEntry
    , gje.IsCorrection
    , sjae.Side
    , sjae.AccountingCurrencyAmount
    , sjae.ReportingCurrencyAmount
    , sjae.TransactionCurrencyAmount
    , NULL AS MonetaryAmount
    , 0 AS AccountingDistributionRecId
    , gje.DATAAREAID AS DestinationCompany
    , sdh.TypeEnumName
    , ae.SOURCEDOCUMENTHEADER AS SourceDocumentRecId
    , sdh.SourceRelationType
    , 0 AS MainAccountId
    , '' AS MainAccountName
    , '' AS PartyNumber
    , '' AS PARTYNAME
    , '' AS LINEDOCUMENTREFERENCE
    , ptcr.PostingTypeDescription
FROM GeneralJournalAccountEntryStaging gje
JOIN RSMJournalDimensionCrosswalkStaging jdc
    ON jdc.GeneralJournalRecid = gje.RECID
JOIN RSMsubledgerJournalAccountEntryStaging sjae
    ON sjae.GENERALJOURNALACCOUNTENTRY = gje.GENERALJOURNALACCOUNTENTRYRECID
JOIN RSMSubLedgerJournalEntryStaging sje
    ON sje.RECID = sjae.SubledgerJournalEntry
JOIN rsmAccountingEventStaging ae
    ON ae.RECID = sje.AccountingEvent
JOIN rsmSourceDocumentHeaderEntStaging sdh
    ON sdh.RECID = ae.SOURCEDOCUMENTHEADER
LEFT JOIN PostingTypeCrossReference ptcr
    ON gje.PostingType = ptcr.PostingType
WHERE NOT sjae.RECID IN (
        SELECT subledgerJournalAccountEntry
        FROM RSMSubLedgerJournalAccountEntryDistributionStaging
        )

UNION

-- SubLedger Distribution
-- added aggregation functionality DS05272021
SELECT 'SubLedger Detail' AS gl_level
    , isnull(sje.JOURNALNUMBER, gje.JournalNumber) AS JournalNumber
    --ds04292021 brought in the subledger journal number.
    , gje.AccountingDate
    , gje.VOUCHER
    , gje.DocumentNumber
    , CASE 
        WHEN datepart(year, gje.DocumentDate) = 1900
            THEN NULL
        ELSE gje.DocumentDate
        END AS DocumentDate
    , gje.JournalCategory
    , gje.PostingType
    , gje.DESCRIPTION
    , gje.LedgerAccount
    , gje.TransactionCurrencyCode
    , jdc.LedgerDimension
    , gje.Recid AS GeneralJournalAccountEntry
    , gje.IsCorrection
    , sjae.Side
    , sum(sjad.AccountingCurrencyAmount) AS AccountingCurrencyAmount
    , sum(sjad.ReportingCurrencyAmount) AS ReportingCurrencyAmount
    , sum(ad.TransactionCurrencyAmount) AS TransactionCurrencyAmount
    , NULL AS MonetaryAmount -- , ad.MonetaryAmount
    , '' AS AccountingDistributionRecId -- , ad.RECID AS AccountingDistributionRecId
    , ad.ACCOUNTINGLEGALENTITY_DATAAREA AS DestinationCompany
    , sdh.TypeEnumName
    , ae.SOURCEDOCUMENTHEADER AS SourceDocumentRecId
    , sdh.SourceRelationType
    , 0 AS MainAccountId
    , '' AS MainAccountName
    , '' AS PartyNumber
    , '' AS PARTYNAME
    , aeri.LINEDOCUMENTREFERENCE
    , ptcr.PostingTypeDescription
FROM GeneralJournalAccountEntryStaging gje
JOIN RSMJournalDimensionCrosswalkStaging jdc
    ON jdc.GeneralJournalRecid = gje.RECID
JOIN RSMsubledgerJournalAccountEntryStaging sjae
    ON sjae.GENERALJOURNALACCOUNTENTRY = gje.GENERALJOURNALACCOUNTENTRYRECID
JOIN RSMSubLedgerJournalEntryStaging sje
    ON sje.RECID = sjae.SubledgerJournalEntry
JOIN rsmAccountingEventStaging ae
    ON ae.RECID = sje.AccountingEvent
JOIN rsmSourceDocumentHeaderEntStaging sdh
    ON sdh.RECID = ae.SOURCEDOCUMENTHEADER
JOIN RSMSubLedgerJournalAccountEntryDistributionStaging sjad
    ON sjad.subledgerJournalAccountEntry = sjae.RECID
JOIN rsmAccountingDistributionStaging ad
    ON ad.RECID = sjad.AccountingDistribution
JOIN rsmSourceDocumentLineReferenceIdentityStaging aeri
    ON aeri.SOURCEDOCUMENTLINE = ad.SOURCEDOCUMENTLINE
LEFT JOIN PostingTypeCrossReference ptcr
    ON gje.PostingType = ptcr.PostingType
GROUP BY isnull(sje.JOURNALNUMBER, gje.JournalNumber)
    , --ds04292021 brought in the subledger journal number.
    gje.AccountingDate
    , gje.VOUCHER
    , gje.DocumentNumber
    , CASE 
        WHEN datepart(year, gje.DocumentDate) = 1900
            THEN NULL
        ELSE gje.DocumentDate
        END
    , gje.JournalCategory
    , gje.PostingType
    , gje.DESCRIPTION
    , gje.LedgerAccount
    , gje.TransactionCurrencyCode
    , ad.ACCOUNTINGLEGALENTITY_DATAAREA
    , jdc.LedgerDimension
    , gje.Recid
    , gje.IsCorrection
    , sjae.Side
    , sdh.TypeEnumName
    , ae.SOURCEDOCUMENTHEADER
    , sdh.SourceRelationType
    , aeri.LINEDOCUMENTREFERENCE
    , ptcr.PostingTypeDescription

-- Adding these two update statements for AzureDevops for Bug2296 DSilva 3/22/2021
UPDATE FactAccountingSourceExplorer
SET VOUCHER = (
        SELECT TOP 1 VOUCHER
        FROM mdr.vwASEDocuments ase
        WHERE ase.SOURCEDOCUMENTHEADER = FactAccountingSourceExplorer.SourceDocumentRecId
        )
WHERE VOUCHER = ''
    AND EXISTS (
        SELECT VOUCHER
        FROM mdr.vwASEDocuments ase
        WHERE ase.SOURCEDOCUMENTHEADER = FactAccountingSourceExplorer.SourceDocumentRecId
        )

UPDATE FactAccountingSourceExplorer
SET DocumentNumber = (
        SELECT TOP 1 DocumentNumber
        FROM mdr.vwASEDocuments ase
        WHERE ase.SOURCEDOCUMENTHEADER = FactAccountingSourceExplorer.SourceDocumentRecId
        )
WHERE DocumentNumber = ''
    AND EXISTS (
        SELECT DocumentNumber
        FROM mdr.vwASEDocuments ase
        WHERE ase.SOURCEDOCUMENTHEADER = FactAccountingSourceExplorer.SourceDocumentRecId
        )

-- Update From Vend Trans
UPDATE FactAccountingSourceExplorer
SET SubLedgerPartyNumber = v.VENDORACCOUNTNUMBER
    , subLedgerPartyName = p.ORGANIZATIONNAME
FROM FactAccountingSourceExplorer AS fas
JOIN RSMVendTransStaging vt
    ON fas.VOUCHER = vt.VOUCHER
        AND fas.DestinationCompany = vt.DATAAREAID
JOIN VendVendorV2Staging v
    ON v.VENDORACCOUNTNUMBER = vt.VendorAccountNum
JOIN DirPartyV2Staging p
    ON p.PARTYNUMBER = v.VENDORPARTYNUMBER

-- Set Documents based on vendtrans if not populated
UPDATE FactAccountingSourceExplorer
SET DOCUMENTNUMBER = (
        SELECT TOP 1 vt.INVOICE
        FROM RSMVendTransStaging vt
        WHERE vt.VOUCHER = FactAccountingSourceExplorer.VOUCHER
            AND vt.TRANSDATE = FactAccountingSourceExplorer.AccountingDate
            AND NOT vt.INVOICE IS NULL
        )
    , DOCUMENTDATE = (
        SELECT TOP 1 vt.DOCUMENTDATE
        FROM RSMVendTransStaging vt
        WHERE vt.VOUCHER = FactAccountingSourceExplorer.VOUCHER
            AND vt.TRANSDATE = FactAccountingSourceExplorer.AccountingDate
            AND NOT vt.DOCUMENTDATE IS NULL
        ORDER BY vt.DOCUMENTDATE DESC
        )
WHERE (
        DOCUMENTNUMBER = ''
        OR DOCUMENTNUMBER IS NULL
        )
    AND EXISTS (
        SELECT *
        FROM RSMVendTransStaging vt
        WHERE vt.VOUCHER = FactAccountingSourceExplorer.VOUCHER
            AND vt.TRANSDATE = FactAccountingSourceExplorer.AccountingDate
            AND NOT vt.INVOICE IS NULL
        )

-- Set Documents based on custtrans if not populated
UPDATE FactAccountingSourceExplorer
SET DOCUMENTNUMBER = (
        SELECT TOP 1 vt.INVOICE
        FROM RSMCustTransStaging vt
        WHERE vt.VOUCHER = FactAccountingSourceExplorer.VOUCHER
            AND vt.TRANSDATE = FactAccountingSourceExplorer.AccountingDate
            AND NOT vt.INVOICE IS NULL
        )
    , DOCUMENTDATE = (
        SELECT TOP 1 vt.DOCUMENTDATE
        FROM RSMCustTransStaging vt
        WHERE vt.VOUCHER = FactAccountingSourceExplorer.VOUCHER
            AND vt.TRANSDATE = FactAccountingSourceExplorer.AccountingDate
            AND NOT vt.DOCUMENTDATE IS NULL
        ORDER BY vt.DOCUMENTDATE DESC
        )
WHERE (
        DOCUMENTNUMBER = ''
        OR DOCUMENTNUMBER IS NULL
        )
    AND EXISTS (
        SELECT *
        FROM RSMCustTransStaging vt
        WHERE vt.VOUCHER = FactAccountingSourceExplorer.VOUCHER
            AND vt.TRANSDATE = FactAccountingSourceExplorer.AccountingDate
            AND NOT vt.INVOICE IS NULL
        )

-- Update Transaction Currency Sign
UPDATE FactAccountingSourceExplorer
SET SubLedgerTransactionCurrencyAmount = - 1 * SubLedgerTransactionCurrencyAmount
WHERE (
        SubLedgerAccountingCurrencyAmount < 0
        AND SubLedgerTransactionCurrencyAmount > 0
        )
    OR (
        SubLedgerTransactionCurrencyAmount < 0
        AND SubLedgerAccountingCurrencyAmount > 0
        )

--update transaction document date when the document number is not null
UPDATE FactAccountingSourceExplorer
SET DOCUMENTDATE = (
        SELECT TOP 1 vt.DOCUMENTDATE
        FROM RSMVendTransStaging vt
        WHERE vt.VOUCHER = FactAccountingSourceExplorer.VOUCHER
            AND vt.TRANSDATE = FactAccountingSourceExplorer.AccountingDate
            AND NOT vt.DOCUMENTDATE IS NULL
        ORDER BY vt.DOCUMENTDATE DESC
        )
WHERE (
        DOCUMENTDATE = ''
        OR DOCUMENTDATE IS NULL
        )
    AND EXISTS (
        SELECT *
        FROM RSMVendTransStaging vt
        WHERE vt.VOUCHER = FactAccountingSourceExplorer.VOUCHER
            AND vt.TRANSDATE = FactAccountingSourceExplorer.AccountingDate
            AND NOT vt.INVOICE IS NULL
        )

--Update the documentdates that are year 1900
UPDATE [dbo].[FactAccountingSourceExplorer]
SET DocumentDate = NULL
WHERE DATEPART(year, DocumentDate) = 1900
