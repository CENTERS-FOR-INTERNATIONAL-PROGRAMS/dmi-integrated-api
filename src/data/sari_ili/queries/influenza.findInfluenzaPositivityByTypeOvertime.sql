SELECT
  SUM(InfluenzaAPositive) as InfluenzaAPositiveNumber,
  SUM(InfluenzaBPositive) as InfluenzaBPositiveNumber,
  SUM(InfluenzaABPositive) as InfluenzaPositiveNumber,
  SUM(TotalTestsDone) as TotalTestsDoneNumber,
  SUM(TestedNegativeFluNumber) TestedNegativeFluNumber,
  CASE
    WHEN SUM(TotalTestsDone) = 0 THEN 0  -- Handle divide by zero error (you can use 0 or another value if needed)
    ELSE CAST(round(((SUM(InfluenzaAPositive) * 100.0) / SUM(TotalTestsDone)), 2) as decimal(5, 2))
  END AS InfluenzaAPositivePercentage,
  CASE
    WHEN SUM(TotalTestsDone) = 0 THEN 0  -- Handle divide by zero error (you can use 0 or another value if needed)
    ELSE CAST(round(((SUM(InfluenzaBPositive) * 100.0) / SUM(TotalTestsDone)), 2) as decimal(5, 2))
  END AS InfluenzaBPositivePercentage,
  CASE
    WHEN SUM(TotalTestsDone) = 0 THEN 0  -- Handle divide by zero error (you can use 0 or another value if needed)
    ELSE CAST(round(((SUM(InfluenzaABPositive) * 100.0) / SUM(TotalTestsDone)), 2) as decimal(5, 2))
  END AS InfluenzaPositivePercentage,
  SUM(TestedNegativeFluNumber) TestedNegativeFluNumber,

  E.WeekNumber as EpiWeek,
    E.Year
    --D.Month
FROM
(
SELECT
    CASE when fluaPos = 1 then 1 else 0 end InfluenzaAPositive,
    CASE when flubpos = 1 then  1 else 0  end InfluenzaBPositive,
    CASE WHEN fluaPos = 1 or FlubPos = 1 and flutest = 1 then  1 else 0  end InfluenzaABPositive,
    CASE WHEN flutest = 1 then  1 else 0  end TotalTestsDone,
    (
    (CASE WHEN flutest = 1 then  1 else 0  end) - (
    (CASE when fluaPos = 1 then  1 else 0  end) +(CASE when flubpos = 1 then  1 else 0  end) + (CASE WHEN fluaPos = 1 and FlubPos = 1 and flutest = 1 then  1 else 0  end)
    )
) TestedNegativeFluNumber,

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
GROUP BY E.WeekNumber, E.YEAR
ORder by  E.Year,E.WeekNumber;