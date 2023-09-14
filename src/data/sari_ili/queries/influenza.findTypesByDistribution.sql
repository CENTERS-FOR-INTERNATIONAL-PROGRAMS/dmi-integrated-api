SELECT
  SUM(InfluenzaAPositive) InfluenzaAPositiveNumber,
  SUM(InfluenzaBPositive)InfluenzaBPositiveNumber,
  SUM(TotalTestsDone) TotalTestsDone,
   CAST(SUM(InfluenzaAPositive) * 100.0 / NULLIF(SUM(TotalTestsDone), 0) AS DECIMAL(10, 2)) AS InfluenzaAPositivePercent,
    CAST(SUM(InfluenzaBPositive) * 100.0 / NULLIF(SUM(TotalTestsDone), 0) AS DECIMAL(10, 2)) AS InfluenzaBPositivePercent,
    CAST(((SUM(TotalTestsDone) - (SUM(InfluenzaAPositive) + SUM(InfluenzaBPositive))) * 100) / SUM(TotalTestsDone) AS DECIMAL(10, 2)) AS NegativeFluPercent,
  (SUM(TotalTestsDone)) - (SUM(InfluenzaAPositive) + SUM(InfluenzaBPositive)) NegativeFluNumber,
  SUM(InfluenzaABPositive) InfluenzaABPositiveNumber,
   CAST(SUM(InfluenzaABPositive) * 100.0 / NULLIF(SUM(TotalTestsDone), 0) AS DECIMAL(10, 2)) AS InfluenzaABPositivePercent
FROM
  (
SELECT
    CASE when fluaPos = 1 then 1 else 0 end InfluenzaAPositive,
    CASE when flubpos = 1 then 1 else 0 end InfluenzaBPositive,
    CASE WHEN flutest = 1 then 1 else 0 end TotalTestsDone,
	CASE WHEN FluaPos =1 and FlubPos =1 then 1 else 0 end InfluenzaABPositive,
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
;