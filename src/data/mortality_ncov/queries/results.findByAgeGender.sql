SELECT SUM(Covid19PositiveNumber) Covid19PositiveNumber,
    AgeGroup,
    Gender
FROM (
        SELECT CASE
                WHEN Covid19Positive = 1
                and Enrolled = 1 then 1
                else 0
            end Covid19PositiveNumber,
            (
                SELECT AgeGroup
                FRoM [dbo].[DimAgeGroup]
                where AgeGroupId = p.AgeGroup
            ) AgeGroup,
            (
                SELECT SexValue
                FRoM [dbo].[DimSex]
                where SexId = p.Sex
            ) Gender,
            P.Facility as FacilityID,
            P.ReviewDate,
            P.EpiWeek
        FROM [dbo].[FactMortality] p
        WHERE AgeGroup is not null
    ) A
    INNER JOIN DimDate D On A.ReviewDate = D.DateKey
    INNER JOIN DimFacility F on A.FacilityId = F.FacilityId --{{WHERE}}--
GROUP BY AgeGroup,
    Gender;