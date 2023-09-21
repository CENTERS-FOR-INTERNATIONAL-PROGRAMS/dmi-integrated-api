SELECT SUM(SARSCOV2TestedNumber) SARSCOV2TestedNumber,
    CAST(
        (SUM(SARSCOV2TestedNumber) * 100.0) / NULLIF(SUM(SUM(SARSCOV2TestedNumber)) OVER (), 0) AS DECIMAL(10, 2)
    ) AS SARSCOV2TestedPercent,
    AgeGroupCategory
FROM(
        SELECT CASE
                WHEN CovidTest = 1
                AND AgeCat IS NOT NULL THEN 1
                else 0
            END SARSCOV2TestedNumber,
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