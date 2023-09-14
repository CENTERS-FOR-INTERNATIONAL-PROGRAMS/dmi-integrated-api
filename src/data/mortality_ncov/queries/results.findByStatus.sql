SELECT SUM(Covid19Positive) Covid19PositiveNumber,
    SUM(Covid19Negative) Covid19NegativeNumber,
    CAST(SUM(Covid19Positive) AS DECIMAL) / NULLIF(SUM(Covid19Positive) + SUM(Covid19Negative), 0) * 100 AS Covid19PositivePercent,
    CAST(SUM(Covid19Negative) AS DECIMAL) / NULLIF(SUM(Covid19Positive) + SUM(Covid19Negative), 0) * 100 AS Covid19NegativePercent
FROM (
        SELECT CASE
                WHEN Covid19Positive = 1
                and Enrolled = 1 THEN 1
                ELSE 0
            END Covid19Positive,
            CASE
                WHEN Covid19Positive = 0
                and enrolled = 1 THEN 1
                else 0
            END Covid19Negative,
            P.Facility as FacilityID,
            P.ReviewDate,
            P.EpiWeek
        FROM [dbo].[FactMortality] p
        where p.Facility = 1
    ) A
    INNER JOIN DimDate D On A.ReviewDate = D.DateKey
    INNER JOIN DimFacility F on A.FacilityId = F.FacilityId --{{WHERE}}--
;