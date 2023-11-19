CREATE FUNCTION [research].[fnCompoundPrimaryGeneFromNumber](	@compoundNumber	VARCHAR(50))
RETURNS VARCHAR(256)
AS
/*
    -- *************************************
    --  Look up the (most) primary gene term for a given compound number.  Used by Pubs application with user 'api_login_restricted'
    --  Progressive searches from most restrictive to least restrictive.
    --  See also:  
    --  Author:  John O'Neill
    --  Modified: 03/10/2020.  Added EnsemblID alternate search term
    -- *************************************
*/
BEGIN

	DECLARE @primaryGene Varchar(50)
	-- Ensure input parameter is not empty
	IF @compoundNumber = ''
	        RETURN ''
	ELSE
	BEGIN
		-- Most restrictive filter. Human, status is primary, target type is intended
		SET @primaryGene =  (
		  SELECT TOP 1 GeneTerm
		  FROM  research.CompoundGeneTerms
		  WHERE
		  (
     			(CompoundNumber= @compoundNumber AND CompoundTermType = 'aso_number' ) 
      			or (CompoundTerm = @compoundNumber AND (CompoundTermType = 'trade' or CompoundTermType = 'internal'))
                or (EnsemblID = @compoundNumber)
  		  )
		  AND GeneTermStatus = 'primary'
		  AND TargetType = 'intended' 
		  AND GeneTermType= 'GeneSymbol'
		  AND (species = 'Human')
)

 -- If none found for most restrictive, remove human species criteria
IF @primaryGene IS NULL
  SET @primaryGene = (
	   SELECT TOP 1 GeneTerm--gene_symbol
	   FROM  research.CompoundGeneTerms
	   WHERE
	   (
     		(CompoundNumber= @compoundNumber AND CompoundTermType = 'aso_number' ) 
      		or (CompoundTerm = @compoundNumber AND (CompoundTermType = 'trade' or CompoundTermType = 'internal'))
            or (EnsemblID = @compoundNumber)
  	   )
	  AND GeneTermStatus = 'primary'
	  AND TargetType = 'intended' 
	  AND GeneTermType= 'GeneSymbol'
	-- does not have species = human restriction
  
)
 -- If none found for any species, relax the restriction on intended target type
IF @primaryGene IS NULL
  SET @primaryGene = (
	SELECT TOP 1 GeneTerm--gene_symbol
  	FROM  research.CompoundGeneTerms
  	WHERE (
     		(CompoundNumber= @compoundNumber AND CompoundTermType = 'aso_number' ) 
      		or (CompoundTerm = @compoundNumber AND (CompoundTermType = 'trade' or CompoundTermType = 'internal'))
            or (EnsemblID = @compoundNumber)
  	 )
  	AND GeneTermStatus = 'primary'
  	AND GeneTermType= 'GeneSymbol'
  -- does not have TargetType = 'intended' restriction
  -- does not have species = human restriction
)

		RETURN @primaryGene 
    	END
	
	RETURN ''        
END
GO