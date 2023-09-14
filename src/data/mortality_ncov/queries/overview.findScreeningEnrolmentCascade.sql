SELECT SUM(TotalScreened) ScreenedNumber,
    SUM(Eligible) EligibleNumber,
    SUM(Enrolled) EnrolledNumber,
    SUM(Tested) TestedNumber,
    SUM(Positive) PositiveNumber
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