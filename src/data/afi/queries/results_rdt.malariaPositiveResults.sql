SELECT D.PFalciparumNumber,
    D.PanMalariaNumber,
    D.MixedInfectionNumber,
    D.UnspeciatedNumber,
    D.TotalNumber,
    CAST(
        round(((D.PFalciparumNumber * 100.0) / D.TotalNumber), 2) as decimal(5, 2)
    ) PFalciparumPercentage,
    CAST(
        round(((D.PanMalariaNumber * 100.0) / D.TotalNumber), 2) as decimal(5, 2)
    ) PanMalariaPercentage,
    CAST(
        round(((D.MixedInfectionNumber * 100.0) / D.TotalNumber), 2) as decimal(5, 2)
    ) MixedInfectionPercentage,
    CAST(
        round(((D.UnspeciatedNumber * 100.0) / D.TotalNumber), 2) as decimal(5, 2)
    ) UnspeciatedPercentage
FROM (
        SELECT SUM(
                CASE
                    WHEN B.ResultValue = 1
                    and B.MalariaSpecies = 1 THEN 1
                    else 0
                END
            ) PFalciparumNumber,
            SUM(
                CASE
                    WHEN B.ResultValue = 1
                    and B.MalariaSpecies = 2 THEN 1
                    else 0
                END
            ) PanMalariaNumber,
            SUM(
                CASE
                    WHEN B.ResultValue = 1
                    and B.MalariaSpecies = 3 THEN 1
                    else 0
                END
            ) MixedInfectionNumber,
            SUM(
                CASE
                    WHEN B.ResultValue = 1
                    and (
                        B.MalariaSpecies = 9999
                        OR B.MalariaSpecies IS NULL
                    ) THEN 1
                    else 0
                END
            ) UnspeciatedNumber,
            SUM(
                (
                    CASE
                        WHEN B.ResultValue = 1
                        and B.MalariaSpecies = 1 THEN 1
                        else 0
                    END
                ) + (
                    CASE
                        WHEN B.ResultValue = 1
                        and B.MalariaSpecies = 2 THEN 1
                        else 0
                    END
                ) + (
                    CASE
                        WHEN B.ResultValue = 1
                        and B.MalariaSpecies = 3 THEN 1
                        else 0
                    END
                ) + (
                    CASE
                        WHEN B.ResultValue = 1
                        and (
                            B.MalariaSpecies = 9999
                            OR B.MalariaSpecies IS NULL
                        ) THEN 1
                        else 0
                    END
                )
            ) TotalNumber
        FROM [dbo].[FactMalariRdt] A
            INNER JOIN [dbo].[FactLabResult] B ON A.Barcode = B.Barcode
        Where ResultValue IS NOT NULL
    ) D;