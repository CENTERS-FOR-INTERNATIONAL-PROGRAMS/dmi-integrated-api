SELECT
CASE WHEN 
  SUM(Tested) IS NULL THEN 0
  ELSE SUM(Tested) END AS TestedNumber,
  CASE
    WHEN SUM(flueTestDone) = 0 THEN 0
    ELSE CAST((SUM(InfluenzaAPositive) + SUM(InfluenzaBPositive) + SUM(InfluenzaABPositive)) * 100.0 / NULLIF(SUM(flueTestDone), 0) AS DECIMAL(10, 2))
  END AS InfluenzaPositivePercent,
  CASE
    WHEN SUM(CovidTEstDone) = 0 THEN 0
    ELSE CAST((SUM(CovidPositive)) * 100.0 / NULLIF(SUM(CovidTEstDone), 0) AS DECIMAL(10, 2))
  END AS SARSCOV2PositivePercent,
  E.WeekNumber as EpiWeek, E.Year
  

FROM
        (SELECT 
            CASE WHEN flutest = 1 or CovidTest = 1 then flutest end Tested,
            CASE WHEN CovidPos = 1 THEN 1 else 0 end CovidPositive,
            CASE WHEN covidTEst = 1 THEN  1 else 0 end CovidTEstDone,
            CASE WHEN fluaPos = 1 THEN  1 else 0 END InfluenzaAPositive,
            CASE WHEN flubPos = 1 THEN  1 else 0 END InfluenzaBPositive,
            CASE WHEN flubPos = 1 and fluApos = 1 then  1 else 0 END InfluenzaABPositive,
            CASE WHEN flutest = 1 THEN  1 else 0 END flueTestDone,
        B.FacilityKey as FacilityID,
        B.DateScreenedKey,
        B.EpiWeek,
		B.caseDef
        FROM
        [dbo].[FactSari] B

  ) A

    
INNER JOIN DimDate D On A.DateScreenedKey = D.DateKey
INNER JOIN DimFacility F on A.FacilityId = F.FacilityId 
INNER JOIN DimEpiWeek E on A.EpiWeek = E.WeekKey
INNER JOIN DimCaseDefinition C on A.caseDef = C.Id
--{{WHERE}}--
GROUP BY  E.Year,E.MONTH, E.WeekNumber
ORDER BY  E.Year, E.MONTH, E.WeekNumber;
