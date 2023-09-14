SELECT AgeGroup,
    Gender,
    COUNT(PID) EnrolledNumber
FROM(
        SELECT Pid,
            CASE
                Gender
                when '1.0' THEN 'Male'
                When '2.0' THEN 'Female'
            END Gender,
            CASE
                WHEN CAST(Ageyrs AS decimal) BETWEEN 0 and 4 THEN '0-4Yrs'
                WHEN CAST(Ageyrs AS decimal) BETWEEN 5 and 14 THEN '5-14Yrs'
                WHEN CAST(Ageyrs AS decimal) BETWEEN 15 and 34 THEN '15-34Yrs'
                WHEN CAST(Ageyrs AS decimal) BETWEEN 35 and 64 THEN '35-64Yrs'
                WHEN CAST(Ageyrs AS decimal) BETWEEN 65 and 84 THEN '65-84Yrs'
                WHEN CAST(Ageyrs AS decimal) BETWEEN 85 and 105 THEN '85+'
            END AgeGroup
        FROM FactEnrollAndHouseholdInfo
        WHERE Gender = '1.0'
            OR Gender = '2.0'
    ) A
Where AgeGroup is not null
Group by AgeGroup,
    Gender;