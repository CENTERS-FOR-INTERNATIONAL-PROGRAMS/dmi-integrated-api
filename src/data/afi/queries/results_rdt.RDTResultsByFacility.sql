SELECT COALESCE(LeptospirosisNumber, 0) AS LeptospirosisNumber,
    COALESCE(MalariaNumber, 0) AS MalariaNumber,
    (
        SELECT ShortName
        FROM [dbo].[DimFacilities]
        Where StudySiteID = MalariaData.StudySite
    ) HealthFacility
FROM (
        SELECT COUNT(B.ResultValue) AS LeptospirosisNumber,
            D.StudySite
        FROM [dbo].[FactLeptospirosisRdt] C
            INNER JOIN [dbo].[FactLabResult] B ON C.Barcode = B.Barcode
            INNER JOIN [dbo].[FactScreening] D ON C.PID = D.StudyID
        WHERE B.ResultValue = 1
        GROUP BY D.StudySite
    ) LeptoData
    FULL JOIN (
        SELECT COUNT(B.ResultValue) AS MalariaNumber,
            D.StudySite
        FROM [dbo].[FactMalariRdt] C
            INNER JOIN [dbo].[FactLabResult] B ON C.Barcode = B.Barcode
            INNER JOIN [dbo].[FactScreening] D ON C.PID = D.StudyID
        WHERE B.ResultValue = 1
        GROUP BY D.StudySite
    ) MalariaData ON LeptoData.StudySite = MalariaData.StudySite;