SELECT SUM(FluPositiveNumber) FluPositiveNumber,
    CAST(
        SUM(FluPositiveNumber) * 100.0 / NULLIF(SUM(SUM(FluPositiveNumber)) OVER (), 0) AS DECIMAL(10, 2)
    ) AS FluPositivePercent,
    AgeGroupCategory
FROM (
        SELECT CASE
                WHEN flutest = 1
                AND FluaPos = 1
                or FlubPos = 1 then 1
                else 0
            END as FluPositiveNumber,
            B.FacilityKey as FacilityID,
            B.DateScreenedKey,
            B.EpiWeek,
            B.AgeCat
        FROM [dbo].[FactSari] B
    ) A
    INNER JOIN DimDate D On A.DateScreenedKey = D.DateKey
    INNER JOIN DimFacility F on A.FacilityId = F.FacilityId
    INNER JOIN DimEpiWeek E on A.EpiWeek = E.WeekKey
    INNER JOIN [DimAgeGroup] G on A.AgeCat = G.AgeGroupId --{{WHERE}}--
GROUP BY AgeGroupCategory,
    AgeGroupOrdinal
ORDER BY AgeGroupCategory,
    AgeGroupOrdinal;


    SELECT 
      SUM(FluPositiveNumber) FluPositiveNumber,
	  CAST(SUM(FluPositiveNumber) * 100.0 / NULLIF(SUM(SUM(FluPositiveNumber)) OVER (), 0) AS DECIMAL(10, 2)) AS FluPositivePercent,
      AgeGroupCategory
  FROM
  (
SELECT
	CASE WHEN flutest = 1 AND FluaPos = 1 or FlubPos =1   then  1 else 0 END as FluPositiveNumber,
	

		B.FacilityKey as FacilityID,
		B.DateScreenedKey,
		B.EpiWeek,
		B.AgeCat,
		B.caseDef
 FROM
     [dbo].[FactSari] B
  ) A 
INNER JOIN DimDate D On A.DateScreenedKey = D.DateKey
INNER JOIN DimFacility F on A.FacilityId = F.FacilityId 
INNER JOIN DimEpiWeek E on A.EpiWeek = E.WeekKey
INNER JOIN [DimAgeGroup] G on A.AgeCat = G.AgeGroupId
INNER JOIN DimCaseDefinition C on A.caseDef = C.Id
--{{WHERE}}--
GROUP BY
  AgeGroupCategory,AgeGroupOrdinal
ORDER BY
 AgeGroupOrdinal;