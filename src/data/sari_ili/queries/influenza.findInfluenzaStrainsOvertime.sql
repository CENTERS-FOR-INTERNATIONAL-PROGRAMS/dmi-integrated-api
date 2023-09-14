SELECT
    SUM([NotSubTypeNumber]) AS NotSubTypeNumber,
    SUM([AH1N1Number]) AS AH1N1Number,
    SUM([AH3N2Number]) AS AH3N2Number,
    SUM([NonSubTypableNumber]) AS NonSubTypableNumber,
    SUM([YamagataNumber]) AS YamagataNumber,
    SUM([VictoriaNumber]) AS VictoriaNumber,
    SUM([NotDeterminedNumber]) AS NotDeterminedNumber,
    SUM([InfluenzaNegativeNumber]) AS InfluenzaNegativeNumber,
	SUM([InfluenzaPositiveNumber]) AS InfluenzaPositiveNumber,
    E.WeekNumber,
    E.Year
FROM (
    SELECT
	    id,
        CASE WHEN notsubtyp = 1 AND flutest = 1 THEN 1 else 0 END AS [NotSubTypeNumber],
        CASE WHEN ph1n1 = 1 AND flutest = 1 THEN 1 else 0  END AS [AH1N1Number],
        CASE WHEN h3n2 = 1 AND flutest = 1 THEN 1 else 0  END AS [AH3N2Number],
        CASE WHEN unsub_non = 1 AND flutest = 1 THEN 1 else 0  END AS [NonSubTypableNumber],
        CASE WHEN yamagata = 1 AND flutest = 1 THEN 1 else 0  END AS [YamagataNumber],
        CASE WHEN victoria = 1 AND flutest = 1 THEN 1 else 0  END AS [VictoriaNumber],
        CASE WHEN FlubUndetermined = 1 AND flutest = 1 THEN 1 else 0  END AS [NotDeterminedNumber],
        CASE WHEN flupos = 0 THEN 1 else 0  END AS [InfluenzaNegativeNumber],
		CASE WHEN flupos = 1 THEN 1 else 0  END AS [InfluenzaPositiveNumber],
	
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
GROUP BY E.WeekNumber, E.Month, E.YEAR
ORDER BY  E.YEAR,E.WeekNumber;