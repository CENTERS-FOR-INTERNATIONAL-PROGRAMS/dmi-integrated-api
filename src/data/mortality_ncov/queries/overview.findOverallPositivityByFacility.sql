SELECT SUM(TestedNumber) TestedNumber,
    SUM(PositiveNumber) PositiveNumber,
    Facility
FROM (
        SELECT CASE
                WHEN SampleTested = 1
                and barcode is not null then 1
                else 0
            end TestedNumber,
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
GROUP BY Facility;