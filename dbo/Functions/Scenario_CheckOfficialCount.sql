/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 13.0 		*/
/*  Created On : 22-Oct-2020 10:03:19 AM 				*/
/*  DBMS       : SQL Server 2012 						*/
/* ---------------------------------------------------- */

/* Create Functions */

CREATE FUNCTION Scenario_CheckOfficialCount (
	@ScenarioTypeKey INT
) RETURNS INT AS BEGIN
	DECLARE @officialCount INT;
	SELECT @officialCount = COUNT(*) FROM DimScenario WHERE ScenarioTypeKey = @ScenarioTypeKey AND Official = 1;
	RETURN @officialCount
END;
GO