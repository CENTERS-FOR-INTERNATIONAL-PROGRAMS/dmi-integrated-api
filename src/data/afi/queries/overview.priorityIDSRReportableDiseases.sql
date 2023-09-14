SELECT A.DengueNumber,
    A.RiftValleyFeverNumber,
    A.TotalDengueAndRiftValleyFeverNumber,
    CAST(
        round(
            (
                (A.DengueNumber * 100.0) / A.TotalDengueAndRiftValleyFeverNumber
            ),
            2
        ) as decimal(5, 2)
    ) DenguePercentage,
    CAST(
        round(
            (
                (A.RiftValleyFeverNumber * 100.0) / A.TotalDengueAndRiftValleyFeverNumber
            ),
            2
        ) as decimal(5, 2)
    ) RiftValleyFeverPercentage
FROM (
        SELECT Sum(
                CASE
                    WHEN Target = 'Dengue' then 1
                    Else 0
                End
            ) DengueNumber,
            Sum(
                CASE
                    WHEN Target = 'Rift Valley Fever' then 1
                    Else 0
                End
            ) RiftValleyFeverNumber,
            Sum(
                CASE
                    WHEN Target = 'Rift Valley Fever'
                    or Target = 'Dengue' then 1
                    Else 0
                End
            ) TotalDengueAndRiftValleyFeverNumber
        FROM [dbo].[kemri_tac_results]
    ) A;