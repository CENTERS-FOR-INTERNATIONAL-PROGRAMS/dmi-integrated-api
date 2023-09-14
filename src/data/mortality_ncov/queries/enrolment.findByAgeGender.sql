SELECT SUM(EnrolledNumber) EnrolledNumber,
    Gender,
    AgeGroup
FROM (
        SELECT CASE
                WHEN enrolled = 1
                and barcode is not null then 1
                else 0
            end EnrolledNumber,
            (
                SELECT SexValue
                from [dbo].[DimSex]
                where SexId = sex
            ) Gender,
            (
                SELECT AgeGroup
                from [dbo].[DimAgeGroup]
                where AgeGroupId = P.AgeGroup
            ) AgeGroup,
            P.Facility as FacilityID,
            P.ReviewDate,
            P.EpiWeek
        FROM [dbo].[FactMortality] P
        WHERE sex is not null
    ) A
    INNER JOIN DimDate D On A.ReviewDate = D.DateKey
    INNER JOIN DimFacility F on A.FacilityId = F.FacilityId --{{WHERE}}--
Group by Gender,
    AgeGroup;