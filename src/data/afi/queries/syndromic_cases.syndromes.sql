SELECT A.MERSCovNumber,
    A.SARINumber,
    (A.UF + A.UF2) AS UFNumber,
    DFNumber,
    (
        A.MERSCovNumber + A.SARINumber + A.UF + A.UF2 + A.DFNumber
    ) TotalNumber,
    CAST(
        round(
            (
                (A.MERSCovNumber * 100.0) /(
                    A.MERSCovNumber + A.SARINumber + A.UF + A.UF2 + A.DFNumber
                )
            ),
            2
        ) as decimal(5, 2)
    ) MERSCovPercentage,
    CAST(
        round(
            (
                (A.SARINumber * 100.0) /(
                    A.MERSCovNumber + A.SARINumber + A.UF + A.UF2 + A.DFNumber
                )
            ),
            2
        ) as decimal(5, 2)
    ) SARIPercentage,
    CAST(
        round(
            (
                ((A.UF + A.UF2) * 100.0) /(
                    A.MERSCovNumber + A.SARINumber + A.UF + A.UF2 + A.DFNumber
                )
            ),
            2
        ) as decimal(5, 2)
    ) UFPercentage,
    CAST(
        round(
            (
                (DFNumber * 100.0) /(
                    A.MERSCovNumber + A.SARINumber + A.UF + A.UF2 + A.DFNumber
                )
            ),
            2
        ) as decimal(5, 2)
    ) DFPercentage
FROM (
        SELECT SUM(
                CASE
                    WHEN A.[merscov_status] = '1.0' THEN 1
                    ELSE 0
                End
            ) as MERSCovNumber,
            SUM(
                CASE
                    WHEN A.sariStatus = '1.0'
                    AND A.merscov_status <> '1.0' THEN 1
                    ELSE 0
                END
            ) SARINumber,
            SUM(
                CASE
                    WHEN B.Cough = '1.0'
                    AND CAST(B.Coughdays AS decimal) > 10
                    and CAST(Coughdays AS decimal) < = 14 THEN 1
                    ELSE 0
                END
            ) UF,
            SUM(
                CASE
                    WHEN A.sariStatus <> '1.0'
                    AND A.Fevercriteria = '1.0'
                    AND B.Diarrhea = '1.0'
                    AND (
                        B.Loosestools <> '1.0'
                        or B.Diarrhea <> '1.0'
                    ) THEN 1
                    ELSE 0
                END
            ) UF2,
            SUM(
                CASE
                    WHEN A.sariStatus <> '1.0'
                    AND B.Diarrhea = '1.0'
                    AND B.Loosestools = '1.0' THEN 1
                    ELSE 0
                END
            ) DFNumber
        FROM [dbo].[FactPhysicalAbstraction] A
            INNER JOIN [dbo].[FactHistoryPhyExam] B ON A.PID = B.PID
            INNER JOIN [dbo].[FactEnrollAndHouseholdInfo] C ON A.PID = C.PID
    ) A;