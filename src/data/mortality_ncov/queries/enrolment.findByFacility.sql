SELECT SUM(EnrolledNumber) EnrolledNumber,
    SUM(PositiveNumber) PositiveNumber,
    Facility
FROM (
        SELECT CASE
                WHEN Enrolled = 1
                and SampleTested = 1
                and barcode is not null then 1
                else 0
            end EnrolledNumber,
            CASE
                WHEN Covid19Positive = 1
                and SampleTested = 1
                and barcode is not null then 1
                else 0
            end PositiveNumber,
            (
                SELECT FacilityName
                FRoM [dbo].[DimFacility]
                WHERE FacilityId = Facility
            ) Facility,
            P.Facility as FacilityID,
            P.ReviewDate,
            P.EpiWeek
        FROM [dbo].[FactMortality] p
    ) A
    INNER JOIN DimDate D On A.ReviewDate = D.DateKey
    INNER JOIN DimFacility F on A.FacilityId = F.FacilityId --{{WHERE}}--
Group by Facility;