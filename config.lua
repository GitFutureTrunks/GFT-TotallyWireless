Config = {}
Config.TaskPed = '' -- Add any ped you want - https://docs.fivem.net/docs/game-references/ped-models/
Config.TaskPedHash = '' -- Add any ped you want put the above ped here
Config.TaskPedLocation = vector3(0, 0, 0) -- Add location here
Config.TaskPedHeading = 0 -- Where the ped is facing
Config.Phone = 'qb-phone' -- you can change this phone by going into the client/main.lua lines: 491 & 492
Config.Locations = {
    { -- Make sure location & Comp are the same coords
        location = vector3(0, 0, 0),
        comp = {
            vector3(0, 0, 0),
        }
    },
    -- { -- Add as many locations as you want!
    --     location = vector3(0, 0, 0),
    --     comp = {
    --         vector3(0, 0, 0),
    --     }
    -- },
}
