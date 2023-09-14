SELECT Sum(
        CASE
            WHEN Result = 'NEG' Then 1
            Else 0
        End
    ) NegativeNumber,
    Sum(
        CASE
            WHEN Target = 'Plasmodium' then 1
            Else 0
        End
    ) PlasmodiumNumber,
    Sum(
        CASE
            WHEN Target = 'HIV-1' then 1
            Else 0
        End
    ) HIV1Number,
    Sum(
        CASE
            WHEN Target = 'Salmonella' then 1
            Else 0
        End
    ) SalmonellaNumber,
    Sum(
        CASE
            WHEN Target = 'Rickettsia' then 1
            Else 0
        End
    ) RickettsiaNumber,
    Sum(
        CASE
            WHEN Target = 'Dengue' then 1
            Else 0
        End
    ) DengueNumber,
    Sum(
        CASE
            WHEN Target = 'Brucella' then 1
            Else 0
        End
    ) BrucellaNumber,
    Sum(
        CASE
            WHEN Target = 'S. pneumoniae' then 1
            Else 0
        End
    ) SPneumoniaeNumber,
    Sum(
        CASE
            WHEN Target = 'Chikungunya' then 1
            Else 0
        End
    ) ChikungunyaNumber,
    Sum(
        CASE
            WHEN Target = 'Leishmania' then 1
            Else 0
        End
    ) LeishmaniaNumber,
    Sum(
        CASE
            WHEN Target = 'Bartonella' then 1
            Else 0
        End
    ) BartonellaNumber,
    Sum(
        CASE
            WHEN Target = 'Leptospira' then 1
            Else 0
        End
    ) LeptospiraNumber,
    Sum(
        CASE
            WHEN Target = 'C. burnetii' then 1
            Else 0
        End
    ) CburnetiiNumber,
    Sum(
        CASE
            WHEN Target = 'Rift Valley Fever' then 1
            Else 0
        End
    ) RiftValleyFeverNumber,
    Sum(
        CASE
            WHEN Target = 'B. pseudomallei' then 1
            Else 0
        End
    ) BPseudomalleiNumber
FROM [dbo].[kemri_tac_results];