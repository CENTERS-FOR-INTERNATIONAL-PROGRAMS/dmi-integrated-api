SELECT D.NegativeNumber,
    D.PositiveNumber,
    D.TotalNumber,
    CAST(
        round(((D.NegativeNumber * 100.0) / D.TotalNumber), 2) as decimal(5, 2)
    ) NegativePercentage,
    CAST(
        round(((D.PositiveNumber * 100.0) / D.TotalNumber), 2) as decimal(5, 2)
    ) PositivePercentage
FROM (
        SELECT COUNT(
                CASE
                    WHEN B.ResultValue = 2 THEN B.ResultValue
                END
            ) NegativeNumber,
            COUNT(
                CASE
                    WHEN B.ResultValue = 1 THEN B.ResultValue
                END
            ) PositiveNumber,
            COUNT(
                CASE
                    WHEN B.ResultValue = 1
                    Or B.ResultValue = 2 THEN B.ResultValue
                END
            ) TotalNumber
        FROM [dbo].[FactMalariRdt] A
            INNER JOIN [dbo].[FactLabResult] B ON A.Barcode = B.Barcode
        Where ResultValue IS NOT NULL
    ) D;