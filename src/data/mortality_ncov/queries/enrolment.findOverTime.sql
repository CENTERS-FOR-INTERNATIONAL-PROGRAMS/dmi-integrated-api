SELECT SUM(EligibleNumber) EligibleNumber,
    SUM(TestedNumber) TestedNumber,
    SUM(EnrolledNumber) EnrolledNumber,
    EpiWeek,
    [Month],
    [Year]
FROM (
        SELECT CASE
                WHEN Eligible = 1 then 1
                else 0
            end EligibleNumber,
            CASE
                WHEN enrolled = 1 then 1
                else 0
            end TestedNumber,
            CASE
                WHEN enrolled = 1 then 1
                else 0
            end EnrolledNumber,
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