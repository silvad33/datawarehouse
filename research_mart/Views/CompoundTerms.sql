CREATE VIEW research_mart.CompoundTerms AS
SELECT DISTINCT compoundnumber, compoundterm, compoundtermtype, compoundtermstatus, geneterm 
FROM research.CompoundGeneTerms
WHERE targettype = 'intended'
AND genetermtype = 'GeneSymbol'
AND genetermstatus = 'primary'
GO
