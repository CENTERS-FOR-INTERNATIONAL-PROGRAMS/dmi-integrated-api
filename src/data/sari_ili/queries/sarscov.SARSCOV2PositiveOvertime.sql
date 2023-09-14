SELECT SUM(SARSCOV2PositiveNumber)SARSCOV2PositiveNumber, 
	SUM(SARSCOV2TestedNumber) SARSCOV2TestedNumber,
	CAST((SUM(SARSCOV2PositiveNumber) * 100.0) / NULLIF(SUM(SUM(SARSCOV2PositiveNumber)) OVER (), 0) AS DECIMAL(10, 2)) AS SARSCOV2PositivePercent, 
	E.WeekNumber AS EpiWeek,
 
	E.Year,
	E.Month
FROM(
SELECT
CASE WHEN CovidTest = 1 AND  CovidPos = 1 and AgeCat IS NOT NULL THEN 1 else 0 END SARSCOV2PositiveNumber,
CASE WHEN CovidTest = 1 AND AgeCat IS NOT NULL THEN 1 else 0 END SARSCOV2TestedNumber,

B.FacilityKey as FacilityID,
B.DateScreenedKey,
B.EpiWeek,
B.caseDef
FROM
FactSari B
  ) A
INNER JOIN DimDate D On A.DateScreenedKey = D.DateKey
INNER JOIN DimFacility F on A.FacilityId = F.FacilityId 
INNER JOIN DimEpiWeek E on A.EpiWeek = E.WeekKey
INNER JOIN DimCaseDefinition C on A.caseDef = C.Id
 --{{WHERE}}--
GROUP BY E.YEAR,E.Month, E.WeekNumber 
ORDER BY E.YEAR,E.Month, E.WeekNumber ;