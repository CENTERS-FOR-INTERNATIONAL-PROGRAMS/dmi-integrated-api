SELECT WeekNumber,
    SUM(
        CASE
            WHEN PositiveNumber > 0 THEN PositiveNumber
            ELSE 0
        END
    ) AS PositiveNumber,
    SUM(SampleTestedNumber) AS SamplesTestedNumber,
    CAST(
        SUM(
            CASE
                WHEN PositiveNumber > 0 THEN PositiveNumber
                ELSE 0
            END
        ) AS DECIMAL
    ) / NULLIF(SUM(SampleTestedNumber), 0) * 100 AS PositivePercentage
FROM (
        SELECT E.WeekNumber,
            CASE
                WHEN B.ResultValue = 2 THEN 1
                ELSE 0
            END AS NegativeNumber,
            CASE
                WHEN B.ResultValue = 1 THEN 1
                ELSE 0
            END AS PositiveNumber,
            CASE
                WHEN B.ResultValue = 1
                OR B.ResultValue = 2 THEN 1
                ELSE 0
            END AS SampleTestedNumber
        FROM [dbo].[FactLeptospirosisRdt] A
            INNER JOIN [dbo].[FactLabResult] B ON A.Barcode = B.Barcode
            INNER JOIN [dbo].[FactScreening] D ON A.PID = D.StudyID
            INNER JOIN [dbo].[DimEpiweek] E ON D.InterviewDate BETWEEN E.StartDate AND E.EndDate
        WHERE B.ResultValue IS NOT NULL
    ) D
WHERE D.WeekNumber IS NOT NULL
GROUP BY WeekNumber
ORDER BY WeekNumber;