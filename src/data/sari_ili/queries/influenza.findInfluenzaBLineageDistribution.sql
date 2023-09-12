SELECT
  SUM(YamagataNumber)YamagataNumber,
  SUM(VictoriaNumber)VictoriaNumber,
  SUM(NotdeterminedNumber)NotdeterminedNumber,
  (SUM(YamagataNumber) + SUM(VictoriaNumber) + SUM(NotdeterminedNumber)) TotalInfluenzaBLineage,
  ((SUM(YamagataNumber)) * 100) / ((SUM(YamagataNumber) + SUM(VictoriaNumber) + SUM(NotdeterminedNumber))) YamagataPercent,
  ((SUM(VictoriaNumber)) * 100) / ((SUM(YamagataNumber) + SUM(VictoriaNumber) + SUM(NotdeterminedNumber))) VictoriaPercent,
  ((SUM(NotdeterminedNumber)) * 100) / ((SUM(YamagataNumber) + SUM(VictoriaNumber) + SUM(NotdeterminedNumber))) NotdeterminedPercent
FROM
  (
SELECT 
	CASE WHEN yamagata = 1 and flutest = 1 THEN   1 else 0 END YamagataNumber,
	CASE WHEN victoria = 1 and flutest = 1 THEN   1 else 0 END VictoriaNumber,
	CASE WHEN FlubUndetermined = 1 and flutest = 1 THEN 1 else 0 END NotdeterminedNumber,
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
