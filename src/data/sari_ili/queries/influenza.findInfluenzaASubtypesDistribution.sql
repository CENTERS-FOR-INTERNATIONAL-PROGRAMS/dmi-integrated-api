SELECT
  SUM(NotSubTypeNumber)NotSubTypeNumber,
  SUM(AH1N1Number)AH1N1Number,
  SUM(AH3N2Number)AH3N2Number,
  SUM(NonSubTypableNumber)NonSubTypableNumber,
  (SUM(NotSubTypeNumber) + SUM(AH1N1Number) + SUM(AH3N2Number) + SUM(NonSubTypableNumber)) TotalInfluenzaSubTypeA,
  ((SUM(NotSubTypeNumber)) * 100) / ((SUM(NotSubTypeNumber) + SUM(AH1N1Number) + SUM(AH3N2Number) + SUM(NonSubTypableNumber))) NotSubTypeNumberPercent,
  ((SUM(AH1N1Number) * 100)) / ((SUM(NotSubTypeNumber) + SUM(AH1N1Number) + SUM(AH3N2Number) + SUM(NonSubTypableNumber))) AH1N1NumberPercent,
  ((SUM(AH3N2Number) * 100)) / ((SUM(NotSubTypeNumber) + SUM(AH1N1Number) + SUM(AH3N2Number) + SUM(NonSubTypableNumber))) AH3N2NumberPercent,
  ((SUM(NonSubTypableNumber)) * 100) / ((SUM(NotSubTypeNumber) + SUM(AH1N1Number) + SUM(AH3N2Number) + SUM(NonSubTypableNumber))) NonSubTypableNumberPercent
 
FROM
  (
SELECT
    CASE when notsubtyp = 1 and flutest = 1 then  1 else 0 END [NotSubTypeNumber],
    CASE when ph1n1 = 1 and flutest = 1 then  1 else 0 END [AH1N1Number],
    CASE when h3n2 = 1 and flutest = 1 then  1 else 0 END [AH3N2Number],
    CASE when unsub_non = 1 and flutest = 1 then  1 else 0  END[NonSubTypableNumber],
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
--{{WHERE}}
