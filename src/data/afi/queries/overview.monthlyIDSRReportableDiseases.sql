SELECT A.HIV1Number,
    A.PlasmodiumNumber,
    A.SPneumonieNumber,
    A.LeishmaniaNumber,
    A.TotalNumber,
    CAST(
        round(((A.HIV1Number * 100.0) / A.TotalNumber), 2) as decimal(5, 2)
    ) HIV1Percentage,
    CAST(
        round(((A.PlasmodiumNumber * 100.0) / A.TotalNumber), 2) as decimal(5, 2)
    ) PlasmodiumPercentage,
    CAST(
        round(((A.SPneumonieNumber * 100.0) / A.TotalNumber), 2) as decimal(5, 2)
    ) SPneumoniePercentage,
    CAST(
        round(((A.LeishmaniaNumber * 100.0) / A.TotalNumber), 2) as decimal(5, 2)
    ) LeishmaniaPercentage
FROM (
        SELECT Sum(
                CASE
                    WHEN Target = 'HIV-1' then 1
                    Else 0
                End
            ) HIV1Number,
            Sum(
                CASE
                    WHEN Target = 'Plasmodium' then 1
                    Else 0
                End
            ) PlasmodiumNumber,
            Sum(
                CASE
                    WHEN Target = 'S. pneumoniae' then 1
                    Else 0
                End
            ) SPneumonieNumber,
            Sum(
                CASE
                    WHEN Target = 'Leishmania' then 1
                    Else 0
                End
            ) LeishmaniaNumber,
            Sum(
                CASE
                    WHEN Target = 'HIV-1'
                    or Target = 'Plasmodium'
                    or Target = 'S. pneumoniae'
                    or Target = 'Leishmania' then 1
                    Else 0
                End
            ) TotalNumber
        FROM [dbo].[kemri_tac_results]
    ) A;