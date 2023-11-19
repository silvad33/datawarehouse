

-- Uses an input file list of the format:
--[ "staging/contracts/current/000d8dff-365c-4e12-9ce4-13773e82bd75.json",
--  "legal/staging/contracts/current/000f9aaa-45f7-4a3a-b477-2096513113ac.json",
--  "legal/staging/contracts/current/00169df6-eb62-47e7-84ad-a571a01e5f86.json" ]
-- To merge the json data in the files in the lake into the legal warehouse tables
CREATE PROCEDURE clinical.UpsertClinicalSitesFromBlob
(
    @currentAction VARCHAR(1000) OUTPUT,
    @returnCode int OUTPUT,
    @returnMessage VARCHAR(1000) OUTPUT
)


AS
BEGIN
    -- Add Any new clinical Sites that are new
    SELECT @currentAction = 'Merge of ClinicalSite'
    PRINT @currentAction
    MERGE [clinical].[ClinicalSite] AS [Target]
    USING (
        SELECT  JSON_VALUE(j.jsonData, '$.siteNumber') AS siteNumber
        FROM #Json j 
        ) AS [Source] 
    ON [Target].ClinicalSiteNumber = [Source].siteNumber
    -- When the record is not in the target then add
    WHEN NOT MATCHED BY Target THEN
    INSERT (ClinicalSiteNumber) VALUES ([Source].siteNumber)
    OUTPUT 'ClinicalSite', CONVERT(varchar, DELETED.ClinicalSiteNumber), $action, CONVERT(varchar, INSERTED.ClinicalSiteNumber)  INTO #SummaryOfChanges; 


    -- Add and update ClinicalStudy Site Records
    SELECT @currentAction = 'Merge of ClinicalStudySites'
    PRINT @currentAction
    MERGE [clinical].[ClinicalStudySites] AS [Target]
    USING (
        SELECT  JSON_VALUE(j.jsonData, '$.siteNumber') AS siteNumber,
            JSON_VALUE(j.jsonData, '$.studyStartDate') AS studyStartDate,
            JSON_VALUE(j.jsonData, '$.studyEndDate') AS studyEndDate,
            JSON_VALUE(j.jsonData, '$.siteStatus') AS siteStatus, 
            cst.ClinicalStudyId,
            csi.ClinicalSiteId
        FROM #Json j 
        JOIN [clinical].[ClinicalSite] csi ON JSON_VALUE(j.jsonData, '$.siteNumber') = csi.ClinicalSiteNumber
        JOIN [clinical].[ClinicalStudy] cst ON JSON_VALUE(j.jsonData, '$.studyNumber') = cst.ClinicalStudyName
        ) AS [Source] 
    ON [Target].ClinicalSiteId = [Source].ClinicalSiteId AND [Target].ClinicalStudyId = [Source].ClinicalStudyId 
    -- The study status or dates may change so update is needed here
    WHEN MATCHED THEN
    UPDATE SET    
        [Target].ClinicalSiteId =  [Source].ClinicalSiteId,
        [Target].ClinicalStudyId =  [Source].ClinicalStudyId,
        [Target].StartDate =  [Source].studyStartDate,
        [Target].EndDate =  [Source].studyEndDate,
        [Target].Status =  [Source].siteStatus
    -- When the record is not in the target then add
    WHEN NOT MATCHED BY Target THEN
    INSERT (ClinicalSiteId, ClinicalStudyId, StartDate, EndDate, Status) VALUES ([Source].ClinicalSiteId, [Source].ClinicalStudyId, [Source].studyStartDate, [Source].studyEndDate, [Source].siteStatus)
    OUTPUT 'ClinicalStudySites', CONVERT(varchar, DELETED.ClinicalSiteId) + ' ' + CONVERT(varchar, DELETED.ClinicalStudyId), $action, CONVERT(varchar, INSERTED.ClinicalSiteId) + ' ' + CONVERT(varchar, INSERTED.ClinicalStudyId)  INTO #SummaryOfChanges; 


    -- Add and update Address Records
    SELECT @currentAction = 'Merge of LocationInfo'
    PRINT @currentAction
    MERGE [shared].[LocationInfo] AS [Target]
    USING (
        -- uniquness is based on site number and org id (veeva id)
        SELECT  JSON_VALUE(j.jsonData, '$.siteNumber') AS siteNumber,
            o.OrganizationID,
            csi.ClinicalSiteId
        FROM #Json j 
        JOIN [clinical].[ClinicalSite] csi ON JSON_VALUE(j.jsonData, '$.siteNumber') = csi.ClinicalSiteNumber
        JOIN [clinical].[ClinicalOrganization] co ON JSON_VALUE(j.jsonData, '$.organizationLocation.VeevaId') = co.VeevaID
        JOIN [shared].[Organization] o ON co.ClinicalOrganizationID = o.ClinicalOrganizationID
        ) AS [Source] 
    ON [Target].ClinicalSiteId = [Source].ClinicalSiteId AND [Target].OrganizationID = [Source].OrganizationID
    -- Organisation may change so we need to update
    WHEN MATCHED THEN
    UPDATE SET    
        [Target].OrganizationID =  [Source].OrganizationID,
        [Target].ClinicalSiteId =  [Source].ClinicalSiteId
    -- When the record is not in the target then add
    WHEN NOT MATCHED BY Target THEN
    INSERT (LocationType, OrganizationID, ClinicalSiteID) VALUES ('Address', [Source].OrganizationID, [Source].ClinicalSiteId)
    OUTPUT 'LocationInfo', CONVERT(varchar, DELETED.OrganizationID) + ' ' + CONVERT(varchar, DELETED.ClinicalSiteID), $action, CONVERT(varchar, INSERTED.OrganizationID + ' ' + CONVERT(varchar, INSERTED.ClinicalSiteID))  INTO #SummaryOfChanges; 


    SELECT @currentAction = 'Merge of Address'
    PRINT @currentAction
    MERGE [shared].[Address] AS [Target]
    USING (
        -- uniquness is based on site number and org id
        SELECT  JSON_VALUE(j.jsonData, '$.siteNumber') AS siteNumber,
            JSON_VALUE(j.jsonData, '$.organizationLocation.name') AS orgName,
            JSON_VALUE(j.jsonData, '$.organizationLocation.addressLine1') AS addressLine1,
            JSON_VALUE(j.jsonData, '$.organizationLocation.addressLine2') AS addressLine2,
            JSON_VALUE(j.jsonData, '$.organizationLocation.postalZipCode') AS postalZipCode,
            JSON_VALUE(j.jsonData, '$.organizationLocation.StateProvinceRegion') AS StateProvinceRegion,
            JSON_VALUE(j.jsonData, '$.organizationLocation.townCity') AS townCity,
            JSON_VALUE(j.jsonData, '$.organizationLocation.country') AS country,
            lo.LocationInfoId,
            csi.ClinicalSiteId
        FROM #Json j 
        JOIN [clinical].[ClinicalSite] csi ON JSON_VALUE(j.jsonData, '$.siteNumber') = csi.ClinicalSiteNumber
        JOIN [clinical].[ClinicalOrganization] co ON JSON_VALUE(j.jsonData, '$.organizationLocation.VeevaId') = co.VeevaID
        JOIN [shared].[Organization] o ON co.ClinicalOrganizationID = o.ClinicalOrganizationID
        JOIN [shared].[LocationInfo] lo ON lo.OrganizationID = o.OrganizationID AND lo.ClinicalSiteID = csi.ClinicalSiteID
        ) AS [Source] 
    ON [Target].LocationInfoId = [Source].LocationInfoId
    -- Address can change so we need to apply updates
    WHEN MATCHED THEN
    UPDATE SET    
        [Target].AddresseeName =  [Source].orgName,
        [Target].StreetAddress1 =  [Source].addressLine1,
        [Target].StreetAddress2 =  [Source].addressLine2,
        [Target].City =  [Source].townCity,
        [Target].StateProvince =  [Source].StateProvinceRegion,
        [Target].Country =  [Source].country,
        [Target].PostalCode =  [Source].postalZipCode
    -- When the record is not in the target then add
    WHEN NOT MATCHED BY Target THEN
    INSERT (AddresseeName, StreetAddress1, StreetAddress2, City, StateProvince, Country, PostalCode, LocationInfoId) VALUES ([Source].orgName, [Source].addressLine1, [Source].addressLine2, [Source].townCity, [Source].StateProvinceRegion, [Source].country, [Source].postalZipCode, [Source].LocationInfoId)
    -- If the address changes then we need to delete out the old address and replace with the new.  There should only be one address per site so this is safe to run as a delete by site id
    WHEN NOT MATCHED BY Source AND [Target].LocationInfoId IN (
                        SELECT lo.LocationInfoId 
                        FROM #Json j 
                        JOIN [clinical].[ClinicalSite] csi ON JSON_VALUE(j.jsonData, '$.siteNumber') = csi.ClinicalSiteNumber
                        JOIN [shared].[LocationInfo] lo ON csi.ClinicalSiteId = lo.ClinicalSiteId
                    ) THEN
        DELETE
    OUTPUT 'Address', CONVERT(varchar, DELETED.AddresseeName), $action, CONVERT(varchar, INSERTED.AddresseeName)  INTO #SummaryOfChanges; 







END