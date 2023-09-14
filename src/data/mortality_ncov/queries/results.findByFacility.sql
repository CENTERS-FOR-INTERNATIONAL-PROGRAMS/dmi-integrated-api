SELECT SUM(SampleTestedNumber) SampleTestedNumber,
    SUM(Covid19PositiveNumber) Covid19PositiveNumber,
    (
        SUM(SampleTestedNumber) - SUM(Covid19PositiveNumber)
    ) Covid19NegativeNumber,
    Facility
FROM (
        SELECT CASE
                WHEN SampleTested = 1
                and SampleTested is not null
                and barcode is not null then 1
                else 0
            end SampleTestedNumber,
            CASE
                WHEN Covid19Positive = 1
                and Enrolled = 1 then 1
                else 0
            end Covid19PositiveNumber,
            (
                SELECT FacilityName
                FRoM [dbo].[DimFacility]
                where FacilityId = Facility
            ) Facility,
            P.Facility as FacilityID,
            P.ReviewDate,
            P.EpiWeek
        FROM [dbo].[FactMortality] p
    ) A
    INNER JOIN DimDate D On A.ReviewDate = D.DateKey
    INNER JOIN DimFacility F on A.FacilityId = F.FacilityId --{{WHERE}}--
GROUP BY Facility;