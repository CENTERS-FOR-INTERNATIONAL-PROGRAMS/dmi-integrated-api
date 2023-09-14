SELECT SUM(TotalScreened) TotalScreened,
    SUM(Eligible) Eligible,
    CAST(
        (
            SUM(Eligible) * 100.0 / NULLIF(SUM(TotalScreened), 0)
        ) AS INT
    ) PercentEligible,
    SUM(Enrolled) Enrolled,
    CAST(
        (SUM(Enrolled) * 100.0 / NULLIF(SUM(Eligible), 0)) AS INT
    ) PercentEnrolled,
    SUM(Tested) Tested,
    CAST(
        (SUM(Tested) * 100.0 / NULLIF(SUM(enrolled), 0)) AS INT
    ) PercentTested,
    SUM(Positive) Positive,
    CAST(
        (SUM(Positive) * 100.0 / NULLIF(SUM(Tested), 0)) AS INT
    ) PercentPositive
FROM (
        SELECT CASE
                WHEN Screened = 1 THEN 1
                ELSE 0
            END TotalScreened,
            CASE
                WHEN Eligible = 1 THEN 1
                ELSE 0
            END Eligible,
            CASE
                WHEN Enrolled = 1
                and Enrolled is not null
                and barcode is not null then 1
                else 0
            end Enrolled,
            CASE
                WHEN SampleTested = 1
                and SampleTested is not null
                and barcode is not null then 1
                else 0
            end Tested,
            CASE
                WHEN Covid19Positive = 1
                and SampleTested is not null
                and barcode is not null then 1
                else 0
            end Positive,
            P.Facility as FacilityID,
            P.ReviewDate,
            p.EpiWeek
        FROM [dbo].[FactMortality] p
    ) A
    INNER JOIN DimDate D On A.ReviewDate = D.DateKey
    INNER JOIN DimFacility F on A.FacilityID = F.FacilityID --{{WHERE}}--
;