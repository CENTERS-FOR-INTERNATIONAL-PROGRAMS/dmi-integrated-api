SELECT SUM(PositiveNumber) PositiveNumber,
    SUM(TestedNumber) TestedNumber,
    EpiWeek,
    [Month],
    [Year]
FROM (
        SELECT CASE
                WHEN Covid19Positive = 1
                and SampleTested is not null
                and barcode is not null then 1
                else 0
            end PositiveNumber,
            CASE
                WHEN SampleTested = 1
                and SampleTested is not null
                and barcode is not null then 1
                else 0
            end TestedNumber,
            P.Facility as FacilityID,
            P.ReviewDate,
            P.EpiWeek
        FROM [dbo].[FactMortality] p
    ) A
    INNER JOIN DimDate D On A.ReviewDate = D.DateKey
    INNER JOIN DimFacility F on A.FacilityId = F.FacilityId --{{WHERE}}--
GROUP BY EpiWeek,
    Month,
    Year;