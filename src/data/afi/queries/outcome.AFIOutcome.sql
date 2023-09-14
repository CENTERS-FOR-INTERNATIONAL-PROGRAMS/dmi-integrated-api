SELECT COUNT(Pid) AS OutcomeNumber,
    COUNT(Pid) * 100.0 / SUM(COUNT(Pid)) OVER () AS OutcomePercentage,
    CASE
        WHEN Outcome = '1.0' THEN 'Discharged home in stable condition'
        WHEN Outcome = '2.0' THEN 'Discharged home in critical condition'
        WHEN Outcome = '3.0' THEN 'Discharged home against medical advice'
        WHEN Outcome = '4.0' THEN 'Transferred to another hospital'
        WHEN Outcome = '5.0' THEN 'Absconded'
        WHEN Outcome = '6.0' THEN 'Died'
    END AS OutcomeDescription
FROM [dbo].[FactClinicalCourseOutcomes]
WHERE Outcome != '0.0'
    AND Outcome != ' '
    AND Outcome != '9999.0'
    AND Outcome != '999.99'
GROUP BY Outcome;