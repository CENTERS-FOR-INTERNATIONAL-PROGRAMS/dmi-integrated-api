SELECT EnrolledNumber,
    HaveADiagnosisNumber,
    CAST(
        round(
            ((HaveADiagnosisNumber * 100.0) / EnrolledNumber),
            2
        ) as decimal(5, 2)
    ) OfEnrolledHaveADocumentedPercentage
FROM (
        SELECT COUNT(PID) EnrolledNumber,
            (
                SELECT Count(PID)
                FROM [dbo].[FactPhysicalAbstraction]
                WHERE Admissiondiagnosis != ' '
            ) HaveADiagnosisNumber
        FROM [dbo].[FactEnrollAndHouseholdInfo]
    ) A;