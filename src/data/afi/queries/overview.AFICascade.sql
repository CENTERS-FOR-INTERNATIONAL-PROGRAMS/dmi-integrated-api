SELECT ScreenedNumber,
    EligibleNumber,
    EnrolledNumber,
    SampledNumber,
    ((EligibleNumber) * 100 /(ScreenedNumber)) EligiblePercentage,
    ((EnrolledNumber) * 100 /(EligibleNumber)) EnrolledPercentage,
    ((SampledNumber) * 100 /(EnrolledNumber)) SampledPercentage
FROM (
        SELECT COUNT(PID) ScreenedNumber,
            (
                SELECT Count(PId)
                FROM [dbo].[FactScreening]
                WHERE Eligible = 1
            ) EligibleNumber,
            (
                SELECT Count(PID)
                FROM [dbo].[FactEnrollAndHouseholdInfo]
            ) EnrolledNumber,
            (
                SELECT Count(DISTINCT(PID))
                FROM [dbo].[FactSampleCollection]
                WHERE Barcode != '0'
                    and PID != ''
            ) SampledNumber
        FROM [dbo].[FactScreening]
    ) A;