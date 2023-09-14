SELECT EnrolledNumber,
    HaveADiagnosisNumber,
    CAST(
        round(
            ((HaveADiagnosisNumber * 100.0) / EnrolledNumber),
            2
        ) as decimal(5, 2)
    ) OfEnrolledHaveOutcomePercentage
FROM (
        SELECT COUNT(PID) EnrolledNumber,
            (
                SELECT Count(PID)
                FROM [dbo].[FactClinicalCourseOutcomes]
                WHERE Outcome <> '0.0 '
            ) HaveADiagnosisNumber
        FROM [dbo].[FactEnrollAndHouseholdInfo]
    ) A;