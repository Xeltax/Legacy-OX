Config = {
    Gang = {
        ballas = {
            PosCoffre = vector3(354.3, -378.7, 45.3),

            PosGarage = vector3(351.2, -376.7, 45.2),

            PosSpawnCar = vector4(348.5, -380.8, 44.8, 250.0),

            PosBoss = vector3(346.7, -372.4, 45.1),

            VehicleGang = {
                {label = "Primo", model = "primo"},
                {label = "Voodoo", model = "voodoo"},
                {label = "Sanchez", model = "sanchez"}
            },
            
            colorMarker = {
                r = 255,
                g = 10,
                b = 10,
                a = 100
            },
        },

        vagos = {
            PosCoffre = vector3(354.3, -378.7, 45.3),

            PosGarage = vector3(351.2, -376.7, 45.2),

            PosSpawnCar = vector4(348.5, -380.8, 44.8, 250.0),

            PosBoss = vector3(346.7, -372.4, 45.1),

            VehicleGang = {
                {label = "Primo", model = "primo"},
                {label = "Voodoo", model = "voodoo"},
                {label = "Sanchez", model = "sanchez"}
            },

            colorMarker = {
                r = 252,
                g = 186,
                b = 3,
                a = 100
            },
        },

        -- Créer un nouveau gang | Create a new gang
        -- N'oubliez pas de mettre le fichier sql avec les modifications nécessaire si votre gang est mara le job dois être mara et le society society_mara
        --| Don't forget to put the sql file with the necessary modifications if your gang is mara the job must be mara and the society society_mara

        --vagos = { -- Nom du gang cela doit être le nom du job c'est indispensable | Gang name it must be the job name it is essential
        --    PosCoffre = vector3(354.3, -378.7, 45.3), -- Position du coffre | Chest position
        --
        --    PosGarage = vector3(351.2, -376.7, 45.2), -- Position du garage | Garage position
        --
        --    PosSpawnCar = vector4(348.5, -380.8, 44.8, 250.0), -- Position du spawn des véhicules | Vehicle spawn position
        --
        --    PosBoss = vector3(346.7, -372.4, 45.1), -- Positon de l'action patron | Boss action position
        --
        --    VehicleGang = { -- Liste des véhicules du gang | List of gang vehicles
        --        {label = "Primo", model = "primo"},
        --        {label = "Voodoo", model = "voodoo"},
        --        {label = "Sanchez", model = "sanchez"}
        --    },
        --
        --    colorMarker = { -- Couleur des marqueurs | Marker color
        --        r = 252,
        --        g = 186,
        --        b = 3,
        --        a = 100
        --    },
        --},
    },
}