SELECT WeekNumber,
    SUM(PlasmodiumNumber) AS PlasmodiumNumber,
    SUM(HIV1Number) AS HIV1Number,
    SUM(SalmonellaNumber) AS SalmonellaNumber,
    SUM(RickettsiaNumber) AS RickettsiaNumber,
    SUM(DengueNumber) AS DengueNumber,
    SUM(BrucellaNumber) AS BrucellaNumber,
    SUM(ChikungunyaNumber) AS ChikungunyaNumber,
    SUM(SPneumonieNumber) AS SPneumonieNumber,
    SUM(LeishmaniaNumber) AS LeishmaniaNumber,
    SUM(BartonellaNumber) AS BartonellaNumber,
    SUM(LeptospiraNumber) AS LeptospiraNumber,
    SUM(CburnetiiNumber) AS CburnetiiNumber,
    SUM(RiftValleyFeverNumber) AS RiftValleyFeverNumber,
    SUM(BpseudomelleNumber) AS BpseudomelleNumber,
    (SUM(PlasmodiumNumber) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS PlasmodiumPercentage,
    (SUM(HIV1Number) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS HIV1Percentage,
    (SUM(SalmonellaNumber) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS SalmonellaPercentage,
    (SUM(RickettsiaNumber) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS RickettsiaPercentage,
    (SUM(DengueNumber) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS DenguePercentage,
    (SUM(BrucellaNumber) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS BrucellaPercentage,
    (SUM(ChikungunyaNumber) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS ChikungunyaPercentage,
    (SUM(SPneumonieNumber) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS SPneumoniePercentage,
    (SUM(LeishmaniaNumber) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS LeishmaniaPercentage,
    (SUM(BartonellaNumber) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS BartonellaPercentage,
    (SUM(LeptospiraNumber) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS LeptospiraPercentage,
    (SUM(CburnetiiNumber) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS CburnetiiPercentage,
    (SUM(RiftValleyFeverNumber) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS RiftValleyFeverPercentage,
    (SUM(BpseudomelleNumber) * 100.0) / NULLIF(SUM(TotalPerWeek), 0) AS BpseudomellePercentage
FROM (
        SELECT (
                SELECT WeekNumber
                FROM [dbo].[DimEpiweek]
                WHERE C.InterviewDate BETWEEN StartDate AND EndDate
            ) AS WeekNumber,
            CASE
                WHEN Target = 'Plasmodium' THEN 1
                ELSE 0
            END AS PlasmodiumNumber,
            CASE
                WHEN Target = 'HIV-1' THEN 1
                ELSE 0
            END AS HIV1Number,
            CASE
                WHEN Target = 'Salmonella' THEN 1
                ELSE 0
            END AS SalmonellaNumber,
            CASE
                WHEN Target = 'Rickettsia' THEN 1
                ELSE 0
            END AS RickettsiaNumber,
            CASE
                WHEN Target = 'Dengue' THEN 1
                ELSE 0
            END AS DengueNumber,
            CASE
                WHEN Target = 'Brucella' THEN 1
                ELSE 0
            END AS BrucellaNumber,
            CASE
                WHEN Target = 'Chikungunya' THEN 1
                ELSE 0
            END AS ChikungunyaNumber,
            CASE
                WHEN Target = 'S. pneumoniae' THEN 1
                ELSE 0
            END AS SPneumonieNumber,
            CASE
                WHEN Target = 'Leishmania' THEN 1
                ELSE 0
            END AS LeishmaniaNumber,
            CASE
                WHEN Target = 'Bartonella' THEN 1
                ELSE 0
            END AS BartonellaNumber,
            CASE
                WHEN Target = 'Leptospira' THEN 1
                ELSE 0
            END AS LeptospiraNumber,
            CASE
                WHEN Target = 'C. burnetii' THEN 1
                ELSE 0
            END AS CburnetiiNumber,
            CASE
                WHEN Target = 'Rift Valley Fever' THEN 1
                ELSE 0
            END AS RiftValleyFeverNumber,
            CASE
                WHEN Target = 'B. pseudomallei' THEN 1
                ELSE 0
            END AS BpseudomelleNumber,
            CASE
                WHEN Target IN (
                    'Plasmodium',
                    'HIV-1',
                    'Salmonella',
                    'Rickettsia',
                    'Dengue',
                    'Brucella',
                    'Chikungunya',
                    'S. pneumoniae',
                    'Leishmania',
                    'Bartonella',
                    'Leptospira',
                    'C. burnetii',
                    'Rift Valley Fever',
                    'B. pseudomallei'
                ) THEN 1
                ELSE 0
            END AS TotalPerWeek
        FROM [dbo].[kemri_tac_results] A
            INNER JOIN [dbo].[FactEnrollAndHouseholdInfo] C ON A.PIDNumber = C.PID
    ) A
GROUP BY WeekNumber
ORDER BY WeekNumber ASC;