CREATE VIEW mdr.vwASEDocuments AS
select
  ae.SOURCEDOCUMENTHEADER,
  sl.DOCUMENTNUMBER,
  sl.VOUCHER,
  sl.JOURNALNUMBER,
  sl.VOUCHERDATAAREAID,
  vt.VENDORACCOUNTNUM
from
  RSMSubLedgerJournalEntryStaging sl
  join rsmAccountingEventStaging ae on ae.RECID = sl.ACCOUNTINGEVENT
  join RSMVendTransStaging vt on vt.ACCOUNTINGEVENT = ae.RECID
  and vt.DATAAREAID = sl.VOUCHERDATAAREAID
  join factaccountingsourceexplorer ase on ase.SourceDocumentRecId = ae.SOURCEDOCUMENTHEADER
  and ase.DestinationCompany = sl.VOUCHERDATAAREAID