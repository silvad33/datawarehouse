CREATE FUNCTION [tm].[fnBiomarkerMilestone]
(
	@MethodValidation varchar(250),
	@MethodDevelopment varchar(250),
	@ReagentProcurement varchar(250),
	@Contract varchar(250),
	@Bidding varchar(250)
)
RETURNS varchar(25)
AS
BEGIN
	RETURN case 
            when ISNULL(@MethodValidation,'') != '' then 'Method Validation'
            when ISNULL(@MethodDevelopment,'') != '' then  'Method Development'
            when ISNULL(@ReagentProcurement,'') != '' then  'Reagent Procurement'
            when ISNULL(@Contract,'') != '' then  'Contract'
            when ISNULL(@Bidding,'') != '' then  'Bidding'
        End 
END
