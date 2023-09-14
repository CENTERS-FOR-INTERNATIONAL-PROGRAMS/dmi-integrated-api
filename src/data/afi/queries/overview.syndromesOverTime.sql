SELECT sum(MERSCov) MERSCovNumber,
    Sum(SARI) SARINumber,
    sum((UF + UF2)) as UFNumber,
    SUM(DF) DFNumber,
    SUM(
        CASE
            WHEN MERSCov = 0
            AND SARI = 0
            and UF = 0
            and UF2 = 0
            and DF = 0 then 1
            else 0
        END
    ) as [NonUFSARIDFMERSCVONumber],
    WeekNumber
FROM (
        SELECT (
                SELECT WeekNumber
                From [dbo].[DimEpiweek]
                Where C.InterviewDate BETWEEN StartDAte and EndDate
            ) AS WeekNumber,
            CASE
                WHEN A.[merscov_status] = '1.0' THEN 1
                ELSE 0
            End MERSCov,
            CASE
                WHEN A.sariStatus = '1.0'
                AND A.merscov_status <> '1.0' THEN 1
                ELSE 0
            END SARI,
            CASE
                WHEN B.Cough = '1.0'
                AND CAST(B.Coughdays AS decimal) > 10
                and CAST(Coughdays AS decimal) < = 14 THEN 1
                ELSE 0
            END UF,
            CASE
                WHEN A.sariStatus <> '1.0'
                AND A.Fevercriteria = '1.0'
                AND B.Diarrhea = '1.0'
                AND (
                    B.Loosestools <> '1.0'
                    or B.Diarrhea <> '1.0'
                ) THEN 1
                ELSE 0
            END UF2,
            CASE
                WHEN A.sariStatus <> '1.0'
                AND B.Diarrhea = '1.0'
                AND B.Loosestools = '1.0' THEN 1
                ELSE 0
            END DF
        FROM [dbo].[FactPhysicalAbstraction] A
            INNER JOIN [dbo].[FactHistoryPhyExam] B ON A.PID = B.PID
            INNER JOIN [dbo].[FactEnrollAndHouseholdInfo] C ON A.PID = C.PID
    ) A
WHERE WeekNumber is not null
GROUP BY WeekNumber
ORDER BY WeekNumber;