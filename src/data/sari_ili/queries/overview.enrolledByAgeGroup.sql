SELECT 
      SUM(EnrolledNumber) EnrolledNumber,
       CAST(SUM(EnrolledNumber) * 100.0 / NULLIF(SUM(SUM(EnrolledNumber)) OVER (), 0) AS DECIMAL(10, 2)) AS EnrolledPercent,
      G.AgeGroupCategory
  FROM
  (
SELECT
    CASE WHEN Enrolled = 1   AND agecat IS NOT NULL then  1 else 0 END as EnrolledNumber,
     (SELECT [AgeGroupCategory] FROM [dbo].[DimAgeGroup] WHERE [AgeGroupId] = B.AgeCat
  ) AS AgeCategory,
        B.FacilityKey as FacilityID,
        B.DateScreenedKey,
        B.EpiWeek,
        B.AgeCat,
		B.caseDef
        
 FROM
     [dbo].[FactSari] B
  ) A 
INNER JOIN DimDate D On A.DateScreenedKey = D.DateKey
INNER JOIN DimFacility F on A.FacilityId = F.FacilityId 
INNER JOIN DimEpiWeek E on A.EpiWeek = E.WeekKey
INNER JOIN [DimAgeGroup] G on A.AgeCat = G.AgeGroupId
INNER JOIN DimCaseDefinition C on A.caseDef = C.Id
--{{WHERE}}--
GROUP BY AgeGroupCategory,AgeGroupOrdinal
ORDER BY AgeGroupOrdinal;