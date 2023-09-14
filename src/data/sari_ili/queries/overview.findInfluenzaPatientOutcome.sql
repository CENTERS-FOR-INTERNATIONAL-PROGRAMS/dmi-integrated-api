SELECT
  SUM(Outcome1) as [DischargedFromHospitalNumber],
  SUM(Outcome2) as [DeathNumber],
  SUM(Outcome3) as [RefusedHospitalTreatmentNumber],
  SUM(Outcome4) as [AbscondedNumber],
  SUM(Outcome5) as [RefferedToAnotherFacilityNumber],

  CAST(SUM(Outcome1) * 100.0 / NULLIF(SUM(Outcome1 + Outcome2 + Outcome3 + Outcome4 + Outcome5), 0) AS DECIMAL(10, 2)) AS [DischargedFromHospitalPercent],
  CAST(SUM(Outcome2) * 100.0 / NULLIF(SUM(Outcome1 + Outcome2 + Outcome3 + Outcome4 + Outcome5), 0) AS DECIMAL(10, 2)) AS [DeathPercent],
  CAST(SUM(Outcome3) * 100.0 / NULLIF(SUM(Outcome1 + Outcome2 + Outcome3 + Outcome4 + Outcome5), 0) AS DECIMAL(10, 2)) AS [RefusedHospitalTreatmentPercent],
  CAST(SUM(Outcome4) * 100.0 / NULLIF(SUM(Outcome1 + Outcome2 + Outcome3 + Outcome4 + Outcome5), 0) AS DECIMAL(10, 2)) AS [AbscondedPercent],
  CAST(SUM(Outcome5) * 100.0 / NULLIF(SUM(Outcome1 + Outcome2 + Outcome3 + Outcome4 + Outcome5), 0) AS DECIMAL(10, 2)) AS [ReferredToAnotherFacilityPercent]

FROM
  (
SELECT
    CASE WHEN outcome = 1 then  1 else 0 END as Outcome1,
    CASE WHEN outcome = 2 then  1 else 0 end  as Outcome2,
    CASE WHEN outcome = 3 then  1 else 0 end as Outcome3,
    CASE WHEN outcome = 4 then  1 else 0 end as Outcome4,
    CASE WHEN outcome = 5 then  1 else 0 end as Outcome5,
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