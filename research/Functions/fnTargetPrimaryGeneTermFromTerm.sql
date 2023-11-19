CREATE FUNCTION [research].[fnTargetPrimaryGeneTermFromTerm](@searchTerm VARCHAR(50))
RETURNS VARCHAR(256)
AS
/*
    -- *************************************
    --  Look up the (most) primary gene term for a given search term.  Used by Pubs application with user 'api_login_restricted'
    --  Progressive searches from most restrictive to least restrictive.
    --  See also:  
    --  Author:  John O'Neill
    --  Modified: 03/05/2021.
    -- *************************************
*/
BEGIN
DECLARE @primaryGene Varchar(50)
	-- Ensure input parameter is not empty
	IF @searchTerm = ''
	        RETURN ''
	ELSE
	BEGIN

 
		-- Most restrictive filter. Human, status is primary, term type is GeneSymbol
		SET @primaryGene =  (
		  SELECT TOP 1 PrimarySymbol
		  FROM  research.GeneTerms
		  WHERE
     	  (GeneTerm= @searchTerm OR EnsemblID = @searchTerm)	
		  AND GeneTermStatus = 'primary'-- synonym
		  AND GeneTermType= 'GeneSymbol' -- | GeneName
		  AND species = 'Human'
        )

 -- If none found for most restrictive, remove human species criteria
IF @primaryGene IS NULL
  SET @primaryGene = (
	    SELECT TOP 1 PrimarySymbol
		  FROM  research.GeneTerms
		  WHERE
     	  (GeneTerm= @searchTerm OR EnsemblID = @searchTerm)	
		  AND GeneTermStatus = 'primary'-- synonym
		  AND GeneTermType= 'GeneSymbol' -- | GeneName
		  -- AND species = 'Human'
	-- does not have species = human restriction
  
)
 -- If none found for any species, relax the restriction on intended target type
IF @primaryGene IS NULL
  SET @primaryGene = (
	SELECT TOP 1 PrimarySymbol
		  FROM  research.GeneTerms
		  WHERE
     	  (GeneTerm= @searchTerm OR EnsemblID = @searchTerm)	
		  AND GeneTermStatus = 'primary'-- synonym
		  -- AND GeneTermType= 'GeneSymbol' -- | GeneName
		  -- AND species = 'Human'
	-- does not have species = human restriction
    )

  IF @primaryGene IS NULL
  SET @primaryGene = (
	SELECT TOP 1 PrimarySymbol
		  FROM  research.GeneTerms
		  WHERE
     	 (GeneTerm= @searchTerm OR EnsemblID = @searchTerm)	
		  --AND GeneTermStatus = 'primary'-- synonym
		  -- AND GeneTermType= 'GeneSymbol' -- | GeneName
		  -- AND species = 'Human'
	-- does not have species = human restriction
    )	
		RETURN @primaryGene 
END
	
	RETURN ''        
END

