SELECT SUM(EnrolledMale) EnrolledMale,
    SUM(EnrolledFemale) EnrolledFemale,
    SUM(TestedMale) TestedMale,
    SUM(TestedFemale) TestedFemale,
    SUM(PositiveMale) PositiveMale,
    SUM(PositiveFemale) PositiveFemale
FROM (
        SELECT CASE
                WHEN enrolled = 1
                and Sex = 1
                and barcode is not null then 1
                else 0
            end EnrolledMale,
            CASE
                WHEN enrolled = 1
                and Sex = 2
                and barcode is not null then 1
                else 0
            end EnrolledFemale,
            CASE
                WHEN SampleTested = 1
                and Sex = 1
                and barcode is not null then 1
                else 0
            end TestedMale,
            CASE
                WHEN SampleTested = 1
                and Sex = 2
                and barcode is not null then 1
                else 0
            end TestedFemale,
            CASE
                WHEN Covid19Positive = 1
                and Sex = 1
                and barcode is not null then 1
                else 0
            end PositiveMale,
            CASE
                WHEN Covid19Positive = 1
                and Sex = 2
                and barcode is not null then 1
                else 0
            end PositiveFemale,
            P.Facility as FacilityID,
            P.ReviewDate,
            P.EpiWeek
        FROM [dbo].[FactMortality] p
    ) A
    INNER JOIN DimDate D On A.ReviewDate = D.DateKey
    INNER JOIN DimFacility F on A.FacilityId = F.FacilityId --{{WHERE}}--
;