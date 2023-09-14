SELECT SUM(SARSCOV2PositiveNumber) SARSCOV2PositiveNumber,
    CAST(
        (SUM(SARSCOV2PositiveNumber) * 100.0) / NULLIF(SUM(SUM(SARSCOV2PositiveNumber)) OVER (), 0) AS DECIMAL(10, 2)
    ) AS SARSCOV2PositivePercent,
    AgeGroupCategory
FROM(
        SELECT CASE
                WHEN CovidTest = 1
                AND CovidPos = 1
                and AgeCat IS NOT NULL THEN 1
                else 0
            END SARSCOV2PositiveNumber,
            B.AgeCat,
            B.FacilityKey as FacilityID,
            B.DateScreenedKey,
            B.EpiWeek
        FROM FactSari B
    ) A
    INNER JOIN DimDate D On A.DateScreenedKey = D.DateKey
    INNER JOIN DimFacility F on A.FacilityId = F.FacilityId
    INNER JOIN DimEpiWeek E on A.EpiWeek = E.WeekKey
    INNER JOIN DimAgeGroup G on A.AgeCat = G.AgeGroupId --{{WHERE}}--
Group by AgeGroupCategory,
    AgeGroupOrdinal
ORDER BY AgeGroupOrdinal;
