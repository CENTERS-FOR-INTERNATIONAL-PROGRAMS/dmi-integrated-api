SELECT Sum(
        CASE
            WHEN Result = 'NEG' THEN 1
            ELSE 0
        END
    ) AS NegativeNumber,
    Sum(
        CASE
            WHEN Target = 'Plasmodium' THEN 1
            ELSE 0
        END
    ) AS PlasmodiumNumber,
    Sum(
        CASE
            WHEN Target = 'HIV-1' THEN 1
            ELSE 0
        END
    ) AS HIV1Number,
    Sum(
        CASE
            WHEN Target = 'Salmonella' THEN 1
            ELSE 0
        END
    ) AS SalmonellaNumber,
    Sum(
        CASE
            WHEN Target = 'Rickettsia' THEN 1
            ELSE 0
        END
    ) AS RickettsiaNumber,
    Sum(
        CASE
            WHEN Target = 'Dengue' THEN 1
            ELSE 0
        END
    ) AS DengueNumber,
    Sum(
        CASE
            WHEN Target = 'Brucella' THEN 1
            ELSE 0
        END
    ) AS BrucellaNumber,
    Sum(
        CASE
            WHEN Target = 'Chikungunya' THEN 1
            ELSE 0
        END
    ) AS ChikungunyaNumber,
    Sum(
        CASE
            WHEN Target = 'S. pneumoniae' THEN 1
            ELSE 0
        END
    ) AS SPneumoniaeNumber,
    Sum(
        CASE
            WHEN Target = 'Leishmania' THEN 1
            ELSE 0
        END
    ) AS LeishmaniaNumber,
    Sum(
        CASE
            WHEN Target = 'Bartonella' THEN 1
            ELSE 0
        END
    ) AS BartonellaNumber,
    Sum(
        CASE
            WHEN Target = 'Leptospira' THEN 1
            ELSE 0
        END
    ) AS LeptospiraNumber,
    Sum(
        CASE
            WHEN Target = 'C. burnetii' THEN 1
            ELSE 0
        END
    ) AS CburnetiiNumber,
    Sum(
        CASE
            WHEN Target = 'Rift Valley Fever' THEN 1
            ELSE 0
        END
    ) AS RiftValleyFeverNumber,
    Sum(
        CASE
            WHEN Target = 'B. pseudomallei' THEN 1
            ELSE 0
        END
    ) AS BpseudomelleNumber,
    COUNT(*) AS TotalCount,
    (
        Sum(
            CASE
                WHEN Target = 'Plasmodium' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS PlasmodiumPercentage,
    (
        Sum(
            CASE
                WHEN Target = 'HIV-1' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS HIV1Percentage,
    (
        Sum(
            CASE
                WHEN Target = 'Salmonella' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS SalmonellaPercentage,
    (
        Sum(
            CASE
                WHEN Target = 'Salmonella' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS SalmonellaPercentage,
    (
        Sum(
            CASE
                WHEN Target = 'Rickettsia' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS RickettsiaPercentage,
    (
        Sum(
            CASE
                WHEN Target = 'Dengue' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS DenguePercentage,
    (
        Sum(
            CASE
                WHEN Target = 'Brucella' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS BrucellaPercentage,
    (
        Sum(
            CASE
                WHEN Target = 'Chikungunya' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS ChikungunyaPercentage,
    (
        Sum(
            CASE
                WHEN Target = 'S. pneumoniae' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS SPneumoniaePercentage,
    (
        Sum(
            CASE
                WHEN Target = 'Leishmania' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS LeishmaniaPercentage,
    (
        Sum(
            CASE
                WHEN Target = 'Bartonella' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS BartonellaPercentage,
    (
        Sum(
            CASE
                WHEN Target = 'Leptospira' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS LeptospiraPercentage,
    (
        Sum(
            CASE
                WHEN Target = 'C. burnetii' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS CburnetiiPercentage,
    (
        Sum(
            CASE
                WHEN Target = 'Rift Valley Fever' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS RiftValleyFeverPercentage,
    (
        Sum(
            CASE
                WHEN Target = 'B. pseudomallei' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS BPseudomalleiPercentage,
    (
        Sum(
            CASE
                WHEN Result = 'NEG' THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) AS NegativePercentage
FROM [dbo].[kemri_tac_results];