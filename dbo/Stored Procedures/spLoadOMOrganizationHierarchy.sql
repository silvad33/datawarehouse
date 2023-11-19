CREATE PROCEDURE [dbo].[spLoadOMOrganizationHierarchy] AS

-- SELECT * FROM OrganizationHierarchy
-- SELECT * FROM [OMOrganizationHierarchyPublishedV2Staging]

TRUNCATE TABLE OrganizationHierarchy

DECLARE @HierarchyType as varchar(50),
	@RootPartyNumber as varchar(50), 
	@Level1PartyNumber as varchar(50), 
	@Level2PartyNumber as varchar(50), 
	@Level3PartyNumber as varchar(50), 
	@Level4PartyNumber as varchar(50), 
	@Level5PartyNumber as varchar(50), 
	@Level6PartyNumber as varchar(50), 
	@Level7PartyNumber as varchar(50)

--select * from [OMOrganizationHierarchyPublishedV2Staging]
-- Retrieve the top level of the hierarchy
DECLARE RootLevelCursor CURSOR FOR
SELECT CHILDORGANIZATIONPARTYNUMBER, HIERARCHYTYPE
FROM [dbo].[OMOrganizationHierarchyPublishedV2Staging] o
WHERE PARENTORGANIZATIONPARTYNUMBER =''
ORDER BY HIERARCHYTYPE

OPEN RootLevelCursor
FETCH NEXT FROM RootLevelCursor INTO @RootPartyNumber, @HierarchyType

WHILE @@FETCH_STATUS=0
BEGIN

	DECLARE Level1Cursor CURSOR FOR
	SELECT CHILDORGANIZATIONPARTYNUMBER
	FROM [dbo].[OMOrganizationHierarchyPublishedV2Staging] o
	WHERE PARENTORGANIZATIONPARTYNUMBER =@RootPartyNumber and HIERARCHYTYPE=@HierarchyType

	OPEN Level1Cursor
	FETCH NEXT FROM Level1Cursor INTO @Level1PartyNumber

	WHILE @@FETCH_STATUS=0
	BEGIN
		INSERT INTO [dbo].[OrganizationHierarchy](HierarchyDepth, HierarchyType, RootPartyNumber, Level1PartyNumber)
		SELECT  '1', @HierarchyType,@RootPartyNumber,@Level1PartyNumber

		DECLARE Level2Cursor CURSOR FOR
		SELECT CHILDORGANIZATIONPARTYNUMBER
		FROM [dbo].[OMOrganizationHierarchyPublishedV2Staging] o
		WHERE PARENTORGANIZATIONPARTYNUMBER =@Level1PartyNumber and HIERARCHYTYPE=@HierarchyType

		OPEN Level2Cursor
		FETCH NEXT FROM Level2Cursor INTO @Level2PartyNumber

		WHILE @@FETCH_STATUS=0
		BEGIN
			INSERT INTO [dbo].[OrganizationHierarchy](HierarchyDepth, HierarchyType, RootPartyNumber, Level1PartyNumber, Level2PartyNumber)
			SELECT '2', @HierarchyType,@RootPartyNumber,@Level1PartyNumber,@Level2PartyNumber

			DECLARE Level3Cursor CURSOR FOR
			SELECT CHILDORGANIZATIONPARTYNUMBER
			FROM [dbo].[OMOrganizationHierarchyPublishedV2Staging] o
			WHERE PARENTORGANIZATIONPARTYNUMBER =@Level2PartyNumber and HIERARCHYTYPE=@HierarchyType

			OPEN Level3Cursor
			FETCH NEXT FROM Level3Cursor INTO @Level3PartyNumber

			WHILE @@FETCH_STATUS=0
			BEGIN
				INSERT INTO [dbo].[OrganizationHierarchy](HierarchyDepth, HierarchyType, RootPartyNumber, Level1PartyNumber, Level2PartyNumber, Level3PartyNumber)
				SELECT '3', @HierarchyType,@RootPartyNumber,@Level1PartyNumber,@Level2PartyNumber,@Level3PartyNumber

				DECLARE Level4Cursor CURSOR FOR
				SELECT CHILDORGANIZATIONPARTYNUMBER
				FROM [dbo].[OMOrganizationHierarchyPublishedV2Staging] o
				WHERE PARENTORGANIZATIONPARTYNUMBER =@Level3PartyNumber and HIERARCHYTYPE=@HierarchyType

				OPEN Level4Cursor
				FETCH NEXT FROM Level4Cursor INTO @Level4PartyNumber

				WHILE @@FETCH_STATUS=0
				BEGIN
					INSERT INTO [dbo].[OrganizationHierarchy](HierarchyDepth, HierarchyType, RootPartyNumber, Level1PartyNumber, Level2PartyNumber, 
						Level3PartyNumber, Level4PartyNumber)
					SELECT '4', @HierarchyType,@RootPartyNumber,@Level1PartyNumber,@Level2PartyNumber,@Level3PartyNumber,@Level4PartyNumber

					DECLARE Level5Cursor CURSOR FOR
					SELECT CHILDORGANIZATIONPARTYNUMBER
					FROM [dbo].[OMOrganizationHierarchyPublishedV2Staging] o
					WHERE PARENTORGANIZATIONPARTYNUMBER =@Level4PartyNumber and HIERARCHYTYPE=@HierarchyType

					OPEN Level5Cursor
					FETCH NEXT FROM Level5Cursor INTO @Level5PartyNumber

					WHILE @@FETCH_STATUS=0
					BEGIN
						INSERT INTO [dbo].[OrganizationHierarchy](HierarchyDepth, HierarchyType, RootPartyNumber, Level1PartyNumber, Level2PartyNumber, 
							Level3PartyNumber, Level4PartyNumber, Level5PartyNumber)
						SELECT '5', @HierarchyType,@RootPartyNumber,@Level1PartyNumber,@Level2PartyNumber,@Level3PartyNumber,@Level4PartyNumber,@Level5PartyNumber


						DECLARE Level6Cursor CURSOR FOR
						SELECT CHILDORGANIZATIONPARTYNUMBER
						FROM [dbo].[OMOrganizationHierarchyPublishedV2Staging] o
						WHERE PARENTORGANIZATIONPARTYNUMBER =@Level5PartyNumber and HIERARCHYTYPE=@HierarchyType

						OPEN Level6Cursor
						FETCH NEXT FROM Level6Cursor INTO @Level6PartyNumber

						WHILE @@FETCH_STATUS=0
						BEGIN
							INSERT INTO [dbo].[OrganizationHierarchy](HierarchyDepth, HierarchyType, RootPartyNumber, Level1PartyNumber, Level2PartyNumber, 
								Level3PartyNumber, Level4PartyNumber, Level5PartyNumber, Level6PartyNumber)
							SELECT '6', @HierarchyType,@RootPartyNumber,@Level1PartyNumber,@Level2PartyNumber,@Level3PartyNumber,@Level4PartyNumber,@Level5PartyNumber,
								@Level6PartyNumber

							DECLARE Level7Cursor CURSOR FOR
							SELECT CHILDORGANIZATIONPARTYNUMBER
							FROM [dbo].[OMOrganizationHierarchyPublishedV2Staging] o
							WHERE PARENTORGANIZATIONPARTYNUMBER =@Level6PartyNumber and HIERARCHYTYPE=@HierarchyType

							OPEN Level7Cursor
							FETCH NEXT FROM Level7Cursor INTO @Level7PartyNumber

							WHILE @@FETCH_STATUS=0
							BEGIN
								INSERT INTO [dbo].[OrganizationHierarchy](HierarchyDepth, HierarchyType, RootPartyNumber, Level1PartyNumber, Level2PartyNumber, 
									Level3PartyNumber, Level4PartyNumber, Level5PartyNumber, Level6PartyNumber, Level7PartyNumber)
								SELECT '7', @HierarchyType,@RootPartyNumber,@Level1PartyNumber,@Level2PartyNumber,@Level3PartyNumber,@Level4PartyNumber,
									@Level5PartyNumber,@Level6PartyNumber,@Level7PartyNumber

								FETCH NEXT FROM Level6Cursor INTO @Level7PartyNumber
							END
							CLOSE Level7Cursor
							DEALLOCATE Level7Cursor

							FETCH NEXT FROM Level6Cursor INTO @Level6PartyNumber
						END
						CLOSE Level6Cursor
						DEALLOCATE Level6Cursor


						FETCH NEXT FROM Level5Cursor INTO @Level5PartyNumber
					END
					CLOSE Level5Cursor
					DEALLOCATE Level5Cursor

					FETCH NEXT FROM Level4Cursor INTO @Level4PartyNumber
				END
				CLOSE Level4Cursor
				DEALLOCATE Level4Cursor

				FETCH NEXT FROM Level3Cursor INTO @Level3PartyNumber
			END
			CLOSE Level3Cursor
			DEALLOCATE Level3Cursor



			FETCH NEXT FROM Level2Cursor INTO @Level2PartyNumber
		END
		CLOSE Level2Cursor
		DEALLOCATE Level2Cursor


		FETCH NEXT FROM Level1Cursor INTO @Level1PartyNumber
	END
	CLOSE Level1Cursor
	DEALLOCATE Level1Cursor

	FETCH NEXT FROM RootLevelCursor INTO @RootPartyNumber, @HierarchyType
END
CLOSE RootLevelCursor
DEALLOCATE RootLevelCursor
-- SELECT * FROM OMOrganizationHierarchy

DELETE FROM OrganizationHierarchy
WHERE HierarchyDepth=1 and
	EXISTS
	(SELECT * FROM OrganizationHierarchy h
	WHERE h.HierarchyType = OrganizationHierarchy.HierarchyType and
		h.Level1PartyNumber = OrganizationHierarchy.Level1PartyNumber and
		h.Level2PartyNumber is NOT NULL and
		h.HierarchyDepth=2)

DELETE FROM OrganizationHierarchy
WHERE HierarchyDepth=2 and
	EXISTS
	(SELECT * FROM OrganizationHierarchy h
	WHERE h.HierarchyType = OrganizationHierarchy.HierarchyType and
		h.Level2PartyNumber = OrganizationHierarchy.Level2PartyNumber and
		h.Level3PartyNumber is NOT NULL and
		h.HierarchyDepth=3)

DELETE FROM OrganizationHierarchy
WHERE HierarchyDepth=3 and
	EXISTS
	(SELECT * FROM OrganizationHierarchy h
	WHERE h.HierarchyType = OrganizationHierarchy.HierarchyType and
		h.Level3PartyNumber = OrganizationHierarchy.Level3PartyNumber and
		h.Level4PartyNumber is NOT NULL and
		h.HierarchyDepth=4)

DELETE FROM OrganizationHierarchy
WHERE HierarchyDepth=4 and
	EXISTS
	(SELECT * FROM OrganizationHierarchy h
	WHERE h.HierarchyType = OrganizationHierarchy.HierarchyType and
		h.Level4PartyNumber = OrganizationHierarchy.Level4PartyNumber and
		h.Level5PartyNumber is NOT NULL and
		h.HierarchyDepth=5)

DELETE FROM OrganizationHierarchy
WHERE HierarchyDepth=5 and
	EXISTS
	(SELECT * FROM OrganizationHierarchy h
	WHERE h.HierarchyType = OrganizationHierarchy.HierarchyType and
		h.Level5PartyNumber = OrganizationHierarchy.Level5PartyNumber and
		h.Level6PartyNumber is NOT NULL and
		h.HierarchyDepth=6)

DELETE FROM OrganizationHierarchy
WHERE HierarchyDepth=6 and
	EXISTS
	(SELECT * FROM OrganizationHierarchy h
	WHERE h.HierarchyType = OrganizationHierarchy.HierarchyType and
		h.Level6PartyNumber = OrganizationHierarchy.Level6PartyNumber and
		h.Level7PartyNumber is NOT NULL and
		h.HierarchyDepth=7)

Update OrganizationHierarchy
SET [LeafPartyNumber]=
	Case WHEN HierarchyDepth=1 THEN Level1PartyNumber
	WHEN HierarchyDepth=2 THEN Level2PartyNumber
	WHEN HierarchyDepth=3 THEN Level3PartyNumber
	WHEN HierarchyDepth=4 THEN Level4PartyNumber
	WHEN HierarchyDepth=5 THEN Level5PartyNumber
	WHEN HierarchyDepth=6 THEN Level6PartyNumber
	WHEN HierarchyDepth=7 THEN Level7PartyNumber
	ELSE 'NA' END

Update OrganizationHierarchy
SET LeafOperatingUnit=
	(SELECT [OPERATINGUNITNUMBER]
	FROM [dbo].[DirPartyV2Staging] p
	WHERE p.[PARTYNUMBER]=OrganizationHierarchy.[LeafPartyNumber])