SELECT SUM(ScreenedNumber) ScreenedNumber,
    SUM(EligibleNumber) EligibleNumber,
    SUM(EnrolledNumber) EnrolledNumber,
    SUM(Covid19PositiveNumber) Covid19PositiveNumber,
    Facility
FROM (
        SELECT CASE
                WHEN Screened = 1 then 1
                else 0
            end ScreenedNumber,
            CASE
                WHEN Eligible = 1 then 1
                else 0
            end EligibleNumber,
            CASE
                WHEN Enrolled = 1
                and barcode is not null then 1
                else 0
            end EnrolledNumber,
            CASE
                WHEN Covid19Positive = 1
                and barcode is not null then 1
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