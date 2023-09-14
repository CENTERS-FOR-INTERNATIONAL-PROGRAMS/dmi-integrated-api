SELECT TotalEnrolledNumber,
    MaleEnrolledNumber,
    FemaleEnrolledNumber,
    CAST(
        round(
            ((MaleEnrolledNumber * 100.0) / TotalEnrolledNumber),
            2
        ) as decimal(5, 2)
    ) MaleEnrolledPercentage,
    CAST(
        round(
            ((FemaleEnrolledNumber * 100.0) / TotalEnrolledNumber),
            2
        ) as decimal(5, 2)
    ) FemaleEnrolledPercentage
FROM (
        SELECT COUNT(PID) TotalEnrolledNumber,
            COUNT(
                CASE
                    WHEN Gender = '1.0' then Gender
                end
            ) MaleEnrolledNumber,
            COUNT(
                CASE
                    WHEN Gender = '2.0' then Gender
                end
            ) FemaleEnrolledNumber
        FROM FactEnrollAndHouseholdInfo
    ) A;