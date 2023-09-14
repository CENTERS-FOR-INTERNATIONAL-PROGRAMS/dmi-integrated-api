SELECT Count(pid) [Weight],
    Otheradmissiondiagnosis
FROM (
        SELECT pid,
            CASE
                WHEN Admissiondiagnosis LIKE '\"' + '%' THEN STUFF(Admissiondiagnosis, 1, 1, '')
                WHEN ISNUMERIC(Admissiondiagnosis) = 1 THEN NULL
                ELSE Admissiondiagnosis
            END AS AdmisionDiagnosis,
            CASE
                WHEN Otheradmissiondiagnosis LIKE '\"%'
                AND Otheradmissiondiagnosis LIKE '%\"' THEN SUBSTRING(
                    Otheradmissiondiagnosis,
                    2,
                    LEN(Otheradmissiondiagnosis) - 2
                )
                WHEN Otheradmissiondiagnosis LIKE '\"%' THEN RIGHT(
                    Otheradmissiondiagnosis,
                    LEN(Otheradmissiondiagnosis) - 1
                )
                WHEN Otheradmissiondiagnosis LIKE '%\"' THEN LEFT(
                    Otheradmissiondiagnosis,
                    LEN(Otheradmissiondiagnosis) - 1
                )
                ELSE Otheradmissiondiagnosis
            END AS Otheradmissiondiagnosis
        FROM [dbo].[FactPhysicalAbstraction]
        WHERE Otheradmissiondiagnosis != ' '
    ) A
WHERE AdmisionDiagnosis IS NOT NULL
GROUP BY Otheradmissiondiagnosis;