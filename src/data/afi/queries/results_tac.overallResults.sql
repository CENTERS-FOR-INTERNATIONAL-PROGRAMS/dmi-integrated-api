SELECT PositiveNumber,
    NegativeNumber,
    (PositiveNumber * 100.0) / TotalCount AS PositivePercentage,
    (NegativeNumber * 100.0) / TotalCount AS NegativePercentage
FROM (
        SELECT SUM(
                CASE
                    WHEN Result = 'POS' THEN 1
                    ELSE 0
                END
            ) PositiveNumber,
            SUM(
                CASE
                    WHEN Result = 'NEG' THEN 1
                    ELSE 0
                END
            ) NegativeNumber,
            COUNT(*) AS TotalCount
        FROM [dbo].[kemri_tac_results]
    ) A;