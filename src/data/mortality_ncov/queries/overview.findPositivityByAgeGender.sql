SELECT Sum(PositiveNumber) PositiveNumber,
    Sex,
    AgeGroup
FROM (
        SELECT CASE
                WHEN Covid19Positive = 1
                and SampleTested is not null
                and barcode is not null then 1
                else 0
            end PositiveNumber,
            P.Facility as FacilityID,
            P.ReviewDate,
            (
                SELECT SexValue
                from [dbo].[DimSex]
                where SexId = sex
            ) Sex,
            (
                SELECT AgeGroup
                from [dbo].[DimAgeGroup]
                where AgeGroupId = p.AgeGroup
            ) AgeGroup,
            EpiWeek
        FROM [dbo].[FactMortality] p
    ) A
    INNER JOIN DimDate D On A.ReviewDate = D.DateKey
    INNER JOIN DimFacility F on A.FacilityId = F.FacilityId --{{WHERE}}--
Group by Sex,
    AgeGroup