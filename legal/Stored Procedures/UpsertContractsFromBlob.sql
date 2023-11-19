

-- Uses an input file list of the format:
--[ "staging/contracts/current/000d8dff-365c-4e12-9ce4-13773e82bd75.json",
--  "legal/staging/contracts/current/000f9aaa-45f7-4a3a-b477-2096513113ac.json",
--  "legal/staging/contracts/current/00169df6-eb62-47e7-84ad-a571a01e5f86.json" ]
-- To merge the json data in the files in the lake into the legal warehouse tables
CREATE PROCEDURE legal.UpsertContractsFromBlob
(
    @currentAction VARCHAR(1000) OUTPUT,
    @returnCode int OUTPUT,
    @returnMessage VARCHAR(1000) OUTPUT
)


AS
BEGIN

    -- Drop temp tables used in sproc
    DROP TABLE IF EXISTS #LegalOrganization
    DROP TABLE IF EXISTS #UniqueLegalOrganization


    SELECT @currentAction = 'Merging for all tables related to Legal Organisation'
    PRINT @currentAction
    -- Merge json contract company data into LegalOrganization table
        
    -- First select the legal org data into a separate temp table to allow us to create a uniqe set 
    -- as the same company will appear in multiple contract records
    CREATE TABLE #LegalOrganization(
        [CongaCompanyID] [varchar](100) NULL,
        [OrganizationName] [varchar](200) NULL,
        [OrganizationNumber] [varchar](100) NULL,
        [CompanyGroup] [varchar](200) NULL,
        [DunsNumber] [varchar](100) NULL,
        [OrganizationType] [varchar](100) NULL,
        [OrganizationCategory] [varchar](100) NULL,
        [OrganizationStatus] [varchar](100) NULL,
        [StreetAddress1] [varchar](2000) NULL,
        [StreetAddress2] [varchar](2000) NULL,
        [City] [varchar](2000) NULL,
        [StateProvince] [varchar](2000) NULL,
        [Country] [varchar](2000) NULL,
        [PostalCode] [varchar](2000) NULL,
        [ID] [int] IDENTITY(1,1) NOT NULL
    )

    INSERT INTO #LegalOrganization(
            CongaCompanyID,
            OrganizationName,
            OrganizationNumber,
            CompanyGroup,
            DunsNumber,
            OrganizationType,
            OrganizationCategory,
            OrganizationStatus,
            StreetAddress1,
            StreetAddress2,
            City,
            StateProvince,
            Country,
            PostalCode
            )
    SELECT  
            JSON_VALUE(j.jsonData, '$.company.id') AS id,
            JSON_VALUE(j.jsonData, '$.company.name') AS name,
            JSON_VALUE(j.jsonData, '$.company.number') AS number,
            JSON_VALUE(j.jsonData, '$.company.group') AS companyGroup,
            JSON_VALUE(j.jsonData, '$.company.externalId') AS externalId,
            JSON_VALUE(j.jsonData, '$.company.type') AS type,
            JSON_VALUE(j.jsonData, '$.company.category') AS category,
            JSON_VALUE(j.jsonData, '$.company.status') AS status,
            JSON_VALUE(j.jsonData, '$.company.address1') AS address1,
            JSON_VALUE(j.jsonData, '$.company.address2') AS address2,
            JSON_VALUE(j.jsonData, '$.company.city') AS city,
            JSON_VALUE(j.jsonData, '$.company.stateOfIncorporation') AS stateOfIncorporation,
            JSON_VALUE(j.jsonData, '$.company.country') AS country,
            JSON_VALUE(j.jsonData, '$.company.postalCode') AS postalCode
    FROM #Json j 

        
    SELECT @currentAction = 'Create Unique Legal Organisation List'
    PRINT @currentAction

    -- The same company will appear in multiple contract records
    -- To get a unique set we need to do a trick using the MAX identity
    -- from the temp table to only get one of the companies.
    -- A separate process will keep the companies up to date

    CREATE TABLE #UniqueLegalOrganization(
        [CongaCompanyID] [varchar](100) NULL,
        [OrganizationName] [varchar](200) NULL,
        [OrganizationNumber] [varchar](100) NULL,
        [CompanyGroup] [varchar](200) NULL,
        [DunsNumber] [varchar](100) NULL,
        [OrganizationType] [varchar](100) NULL,
        [OrganizationCategory] [varchar](100) NULL,
        [OrganizationStatus] [varchar](100) NULL,
        [StreetAddress1] [varchar](2000) NULL,
        [StreetAddress2] [varchar](2000) NULL,
        [City] [varchar](2000) NULL,
        [StateProvince] [varchar](2000) NULL,
        [Country] [varchar](2000) NULL,
        [PostalCode] [varchar](2000) NULL,
        [ID] [int] IDENTITY(1,1) NOT NULL
    )


    INSERT INTO #UniqueLegalOrganization(
        CongaCompanyID,
        OrganizationName,
        OrganizationNumber,
        CompanyGroup,
        DunsNumber,
        OrganizationType,
        OrganizationCategory,
        OrganizationStatus,
        StreetAddress1,
        StreetAddress2,
        City,
        StateProvince,
        Country,
        PostalCode)
    SELECT
        main.CongaCompanyID,
        main.OrganizationName,
        main.OrganizationNumber,
        main.CompanyGroup,
        main.DunsNumber,
        main.OrganizationType,
        main.OrganizationCategory,
        main.OrganizationStatus,
        main.StreetAddress1,
        main.StreetAddress2,
        main.City,
        main.StateProvince,
        main.Country,
        main.PostalCode
    FROM #LegalOrganization main 
    JOIN (
        SELECT MAX(ID) as ID, [CongaCompanyId]
        FROM #LegalOrganization
        GROUP BY CongaCompanyId
    ) sub ON sub.ID = main.ID

    -- Merge json contract company data into LegalOrganization table
    MERGE [legal].[LegalOrganization] AS [Target]
    USING (
            SELECT
                CongaCompanyID,
                OrganizationName,
                OrganizationNumber,
                CompanyGroup,
                DunsNumber,
                OrganizationType,
                OrganizationCategory,
                OrganizationStatus
            FROM #UniqueLegalOrganization
            ) AS [Source] 
    ON [Target].CongaCompanyID = [Source].CongaCompanyID
    WHEN MATCHED THEN
    UPDATE SET    
        [Target].CongaCompanyID =  [Source].CongaCompanyID,
        [Target].OrganizationName =  [Source].OrganizationName,
        [Target].OrganizationNumber =  [Source].OrganizationNumber,
        [Target].CompanyGroup =  [Source].CompanyGroup,
        [Target].DunsNumber =  [Source].DunsNumber,
        [Target].OrganizationType =  [Source].OrganizationType,
        [Target].OrganizationCategory =  [Source].OrganizationCategory,
        [Target].OrganizationStatus =  [Source].OrganizationStatus
    WHEN NOT MATCHED BY Target THEN
    INSERT (
            CongaCompanyID,
            OrganizationName,
            OrganizationNumber,
            CompanyGroup,
            DunsNumber,
            OrganizationType,
            OrganizationCategory,
            OrganizationStatus
            )
        VALUES (
            [Source].CongaCompanyID,
            [Source].OrganizationName,
            [Source].OrganizationNumber,
            [Source].CompanyGroup,
            [Source].DunsNumber,
            [Source].OrganizationType,
            [Source].OrganizationCategory,
            [Source].OrganizationStatus
    ) OUTPUT 'LegalOrganization', CONVERT(varchar, DELETED.CongaCompanyID), $action, CONVERT(varchar, INSERTED.CongaCompanyID)  INTO #SummaryOfChanges; 


    SELECT @currentAction = 'Merge of Organization'
    PRINT @currentAction
    
    -- Merge json contract company data into [shared].[Organization] table
    -- Only need to add to join table if doesnt exist
    -- Eventually, this needs to be managed via an MDM process
    MERGE [shared].[Organization] AS [Target]
    USING (
            SELECT
                ulo.OrganizationName,
                lo.LegalOrganizationID,
                org.OrganizationId
            FROM #UniqueLegalOrganization ulo
            LEFT JOIN [legal].[LegalOrganization] lo ON lo.CongaCompanyID = ulo.CongaCompanyID
            LEFT JOIN shared.Organization org ON lo.LegalOrganizationID = org.LegalOrganizationID
            ) AS [Source] 
    ON [Target].LegalOrganizationID = [Source].LegalOrganizationID
    WHEN NOT MATCHED THEN
    INSERT (
            OrgName,
            LegalOrganizationID
            )
        VALUES (
            [Source].OrganizationName,
            [Source].LegalOrganizationID
    ) OUTPUT 'Organization', '', $action, CONVERT(varchar, INSERTED.OrgName)  INTO #SummaryOfChanges; 



    SELECT @currentAction = 'Merge of LocationInfo'
    PRINT @currentAction
    -- Merge json contract company data into [shared].[LocationInfo] table
    -- Only need to add to join table if doesnt exist
    MERGE [shared].[LocationInfo] AS [Target]
    USING (
            SELECT
                lo.LegalOrganizationID,
                li.LocationInfoId,
                org.OrganizationId
            FROM #UniqueLegalOrganization ulo
            LEFT JOIN [legal].[LegalOrganization] lo ON lo.CongaCompanyID = ulo.CongaCompanyID
            LEFT JOIN shared.Organization org ON lo.LegalOrganizationID = org.LegalOrganizationID
            LEFT JOIN shared.LocationInfo li ON li.OrganizationID = org.OrganizationID
            ) AS [Source] 
    ON [Target].LocationInfoId = [Source].LocationInfoId
    WHEN NOT MATCHED THEN
    INSERT (
            LocationType,
            OrganizationID
            )
        VALUES (
            'Legal Address',
            [Source].OrganizationID
    ) OUTPUT 'LocationInfo', '', $action, CONVERT(varchar, INSERTED.OrganizationID)  INTO #SummaryOfChanges; 


    SELECT @currentAction = 'Merge of Address'
    PRINT @currentAction
    -- Merge json contract company data into [shared].[Address] table
    MERGE [shared].[Address] AS [Target]
    USING (
            SELECT
                ulo.CongaCompanyID,
                ulo.OrganizationName,
                ulo.StreetAddress1,
                ulo.StreetAddress2,
                ulo.City,
                ulo.StateProvince,
                ulo.Country,
                ulo.PostalCode,
                li.LocationInfoId
            FROM #UniqueLegalOrganization ulo
            LEFT JOIN [legal].[LegalOrganization] lo ON lo.CongaCompanyID = ulo.CongaCompanyID
            LEFT JOIN shared.Organization org ON lo.LegalOrganizationID = org.LegalOrganizationID
            LEFT JOIN shared.LocationInfo li ON li.OrganizationID = org.OrganizationID
            ) AS [Source] 
    ON [Target].LocationInfoId = [Source].LocationInfoId
    WHEN MATCHED THEN
    UPDATE SET    
        [Target].AddresseeName =  [Source].OrganizationName,
        [Target].StreetAddress1 =  [Source].StreetAddress1,
        [Target].StreetAddress2 =  [Source].StreetAddress2,
        [Target].City =  [Source].City,
        [Target].Country =  [Source].Country,
        [Target].PostalCode =  [Source].PostalCode,
        [Target].LocationInfoId =  [Source].LocationInfoId
    WHEN NOT MATCHED THEN
    INSERT (
            AddresseeName,
            StreetAddress1,
            StreetAddress2,
            City,
            StateProvince,
            Country,
            PostalCode,
            LocationInfoID
            )
        VALUES (
            [Source].OrganizationName,
            [Source].StreetAddress1,
            [Source].StreetAddress2,
            [Source].City,
            [Source].StateProvince,
            [Source].Country,
            [Source].PostalCode,
            [Source].LocationInfoId
    ) OUTPUT 'Address', CONVERT(varchar, DELETED.AddresseeName), $action, CONVERT(varchar, INSERTED.AddresseeName)  INTO #SummaryOfChanges; 


    SELECT @currentAction = 'Merge of Legal Contracts'
    PRINT @currentAction
    -- Merge json contract data into Legal Contracts table
    MERGE [legal].[LegalContracts] AS [Target]
    USING (
        SELECT  JSON_VALUE(j.jsonData, '$.id') AS id,
            JSON_VALUE(j.jsonData, '$.group') AS contractGroup,
            JSON_VALUE(j.jsonData, '$.number') AS contractNumber,
            JSON_VALUE(j.jsonData, '$.agreementType') AS agreementType,
            JSON_VALUE(j.jsonData, '$.purpose') AS purpose,
            JSON_VALUE(j.jsonData, '$.legalEntity') AS legalEntity,
            JSON_VALUE(j.jsonData, '$.effectiveDate') AS effectiveDate,
            JSON_VALUE(j.jsonData, '$.noticePeriod') AS noticePeriod,
            JSON_VALUE(j.jsonData, '$.termType') AS termType,
            JSON_VALUE(j.jsonData, '$.status') AS contractStatus,
            JSON_VALUE(j.jsonData, '$.currency') AS currency,
            JSON_VALUE(j.jsonData, '$.originalCompany') AS originalCompany,
            JSON_VALUE(j.jsonData, '$.description') AS contracDescription,
            JSON_VALUE(j.jsonData, '$.studyNumber') AS studyNumber,
            JSON_VALUE(j.jsonData, '$.noticeDate') AS noticeDate,
            JSON_VALUE(j.jsonData, '$.originalExpirationDate') AS originalExpirationDate,
            JSON_VALUE(j.jsonData, '$.currentExpirationDate') AS currentExpirationDate,
            JSON_VALUE(j.jsonData, '$.parentContractId') AS parentContractId,
            JSON_VALUE(j.jsonData, '$.lastUpdateDate') AS lastUpdateDate,
            lo.LegalOrganizationID as LegalOrganizationID,
            lcp.LegalContractsId as ParentLegalContractsId
        FROM #Json j 
        LEFT JOIN [legal].[LegalOrganization] lo ON JSON_VALUE(j.jsonData, '$.company.id') = lo.CongaCompanyID
        LEFT JOIN [legal].[LegalContracts] lcp ON JSON_VALUE(j.jsonData, '$.parentContractId') = lcp.CongaContractID
            ) AS [Source] 
    ON [Target].CongaContractID = [Source].id
    WHEN MATCHED THEN
    UPDATE SET    
        [Target].CongaContractID =  [Source].id,
        [Target].ContractNumber =  [Source].contractNumber,
        [Target].AgreementType =  [Source].agreementType,
        [Target].Purpose =  [Source].purpose,
        [Target].LegalEntity =  [Source].legalEntity,
        [Target].OriginalExpirationDate =  [Source].originalExpirationDate,
        [Target].EffectiveDate =  [Source].effectiveDate,
        [Target].CurrentExpirationDate =  [Source].currentExpirationDate,
        [Target].TermType =  [Source].termType,
        [Target].Status =  [Source].contractStatus,
        [Target].Description =  [Source].contracDescription,
        [Target].LastUpdateDate =  [Source].lastUpdateDate,
        [Target].LegalOrganizationID =  [Source].LegalOrganizationID,
        [Target].ParentContractID =  [Source].ParentLegalContractsId,
        [Target].ContractGroup =  [Source].ContractGroup,
        [Target].NoticePeriod =  [Source].NoticePeriod,
        [Target].NoticeDate =  [Source].NoticeDate,
        [Target].StudyNumber =  [Source].StudyNumber
    WHEN NOT MATCHED BY Target THEN
    INSERT (
            CongaContractID,
            ContractNumber,
            AgreementType,
            Purpose,
            LegalEntity,
            OriginalExpirationDate,
            EffectiveDate,
            CurrentExpirationDate,
            TermType,
            Status,
            Description,
            LastUpdateDate,
            LegalOrganizationID,
            ParentContractID,
            ContractGroup,
            NoticePeriod,
            NoticeDate,
            StudyNumber)
        VALUES (
            [Source].id,
            [Source].contractNumber,
            [Source].agreementType,
            [Source].purpose,
            [Source].legalEntity,
            [Source].originalExpirationDate,
            [Source].effectiveDate,
            [Source].currentExpirationDate,
            [Source].termType,
            [Source].contractStatus,
            [Source].contracDescription,
            [Source].lastUpdateDate,
            [Source].LegalOrganizationID,
            [Source].ParentLegalContractsId,
            [Source].ContractGroup,
            [Source].NoticePeriod,
            [Source].NoticeDate,
            [Source].StudyNumber
    )
    OUTPUT 'LegalContracts', CONVERT(varchar, DELETED.CongaContractID), $action, CONVERT(varchar, INSERTED.CongaContractID)  INTO #SummaryOfChanges; 
    
    
    SELECT @currentAction = 'Merge of Legal Target'
    PRINT @currentAction
    -- Merge contract targets.  As this is an array, we assume the new list is correct every time 
    -- so we delete rows that arent in the list from the DB
    MERGE [legal].[ContractTarget] AS [Target]
    USING (
        -- There are potential dupes in the dataset for MTID's so we are using the max and group by to de-dupe
        SELECT ct.LegalContractsID as LegalContractsID,
                JSON_VALUE(j.jsonData, '$.id') AS id,
                case when MAX(t.isEncumbered) = 'Yes' then 1
                    else 0
                end as IsEncumbered,
                MAX(t.mtid) as mtid
        FROM #Json j 
        JOIN [legal].[LegalContracts] ct ON JSON_VALUE(j.jsonData, '$.id') = ct.CongaContractID
        CROSS APPLY OPENJSON(j.jsonData, '$.targets')
            WITH (
                mtid varchar(100),
                geneName varchar(100), 
                isEncumbered varchar(100)) as t
        WHERE t.mtid IS NOT NULL
        GROUP BY LegalContractsID, JSON_VALUE(j.jsonData, '$.id'), mtid
        ) AS [Source] 
    ON [Target].LegalContractsID = [Source].LegalContractsID AND [Target].MTID = [Source].mtid
    -- On match, the only field we can update is a possible encomberance change
    WHEN MATCHED THEN
    UPDATE SET    
        [Target].IsEncumbred = [Source].IsEncumbered
    -- When the record is not in the target (byt contract id and mtid) then add
    WHEN NOT MATCHED BY Target THEN
    INSERT (LegalContractsID, MTID, IsEncumbred) VALUES ([Source].LegalContractsID, [Source].mtid, [Source].IsEncumbered)
    -- If there is a record in the source that is not in the target then we need to remove as a record may have been removed from the list
    WHEN NOT MATCHED BY Source AND [Target].LegalContractsID IN (SELECT ct.LegalContractsID FROM #Json j JOIN [legal].[LegalContracts] ct ON JSON_VALUE(j.jsonData, '$.id') = ct.CongaContractID) THEN
        DELETE
    OUTPUT 'ContractTarget', CONVERT(varchar, DELETED.LegalContractsID), $action, CONVERT(varchar, INSERTED.LegalContractsID)  INTO #SummaryOfChanges; 



    SELECT @currentAction = 'Merge of Legal ContractTypes'
    PRINT @currentAction
    -- Merge contract contract types.  This is additive as it's difficult to work out if there is a modify.
    MERGE [legal].[ContractTypes] AS [Target]
    USING (
        -- Using 'value' here as array is of strings, not objects
        SELECT  JSON_VALUE(j.jsonData, '$.id') AS id,
                jsonContractType
        FROM #Json j 
        CROSS APPLY OPENJSON(j.jsonData, '$.types')
        WITH (   
              jsonContractType   VARCHAR(200)  '$'
              )
        ) AS [Source] 
    ON [Target].ContractType = [Source].jsonContractType
    -- When the record is not in the target then add
    WHEN NOT MATCHED BY Target THEN
    INSERT (ContractType) VALUES ([Source].jsonContractType)
    OUTPUT 'ContractTypes', CONVERT(varchar, DELETED.ContractType), $action, CONVERT(varchar, INSERTED.ContractType)  INTO #SummaryOfChanges; 


    SELECT @currentAction = 'Merge of Legal ContractContractTypes'
    PRINT @currentAction
    -- Merge contract types.  As this is an array, we assume the new list is correct every time 
    -- so we delete rows that arent in the list from the DB
    MERGE [legal].[ContractContractTypes] AS [Target]
    USING (
        -- Using 'value' here as array is of strings, not objects
        SELECT  lc.LegalContractsID as LegalContractsID,
                JSON_VALUE(j.jsonData, '$.id') AS id,
                jsonContractType,
                ct.contractTypesId
        FROM #Json j 
        JOIN [legal].[LegalContracts] lc ON JSON_VALUE(j.jsonData, '$.id') = lc.CongaContractID 
        CROSS APPLY OPENJSON(j.jsonData, '$.types')
        WITH (   
              jsonContractType   VARCHAR(200)  '$'
              )
        JOIN [legal].[ContractTypes] ct ON jsonContractType = ct.contractType
        ) AS [Source] 
    ON [Target].LegalContractsID = [Source].LegalContractsID  AND [Target].ContractTypesID = [Source].contractTypesId
    -- When the record is not in the target then add
    WHEN NOT MATCHED BY Target THEN
    INSERT (LegalContractsID, ContractTypesID) VALUES ([Source].LegalContractsID, [Source].contractTypesId )
    -- If there is a record in the source that is not in the target then we need to remove as a record may have been removed from the list
    WHEN NOT MATCHED BY Source AND [Target].LegalContractsID IN (SELECT ct.LegalContractsID FROM #Json j JOIN [legal].[LegalContracts] ct ON JSON_VALUE(j.jsonData, '$.id') = ct.CongaContractID) THEN
        DELETE
    OUTPUT 'ContractContractTypes', CONVERT(varchar, DELETED.LegalContractsID), $action, CONVERT(varchar, INSERTED.LegalContractsID)  INTO #SummaryOfChanges; 

END