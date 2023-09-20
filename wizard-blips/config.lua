Config = {}

Config.EnableSingle = true
Config.Singles = {
    [1] = {
        name = 'Prison',                                        -- Blip name on the map
        
        display = 'all',                                        ---- 'none' = Won't show at all
                                                                ---- 'all' = Shows on both main map and minimap
                                                                ---- 'main' = Shows on main map only
                                                                ---- 'minimap' = Shows on main map only

        selectable = true,                                      -- Should we allow players to select this blip on map while display = 'all'? (while false, we will it remove from blips list on the map)
                        
        
        sprite = 252,                                           -- Blip type
        color = 47,                                             -- Blip color
        opacity = 100,                                          -- Blip Opacity (0 - 100)
        scale = 0.8,                                            -- Blip scale
        shortrange = true,                                      -- While true, we will pin the blip on minimap   
        flashing = false,                                       -- While true, blip will start flashing
        flashinginv = 1,                                        -- While flashing is true, blip flashing invertal (IN SECONDS)
        shrink = false,                                         -- While true, blip will shrink slowly (MAY CAUSE HIGH RESMON)
        route = false,                                          -- While true, we will set this blip as waypoint route
        routecolor = 1,                                         -- While routecolor is true, what is your favorite color for route?
        coords = vector3(1845.903, 2585.873, 45.672)
    },
    
    [2] = {
        name = 'LostMC - Garage',                               -- Blip name on the map
        
        display = 'all',                                        ---- 'none' = Won't show at all
                                                                ---- 'all' = Shows on both main map and minimap
                                                                ---- 'main' = Shows on main map only
                                                                ---- 'minimap' = Shows on main map only

        selectable = true,                                      -- Should we allow players to select this blip on map while display = 'all'? (while false, we will it remove from blips list on the map)
                        
        
        gang = 'lostmc',
        ganggrade = 0,
        sprite = 357,                                           -- Blip type
        color = 28,                                             -- Blip color
        opacity = 100,                                          -- Blip Opacity (0 - 100)
        scale = 0.8,                                            -- Blip scale
        shortrange = true,                                      -- While true, we will pin the blip on minimap   
        flashing = false,                                       -- While true, blip will start flashing
        flashinginv = 1,                                        -- While flashing is true, blip flashing invertal (IN SECONDS)
        shrink = false,                                         -- While true, blip will shrink slowly (MAY CAUSE HIGH RESMON)
        route = false,                                          -- While true, we will set this blip as waypoint route
        routecolor = 1,                                         -- While routecolor is true, what is your favorite color for route?
        coords = vector3(112.28, 3613.63, 40.27)
    },
    [3] = {                                                     -- SIMPLE EXAMPLE FOR ALL AMBULANCE GRADES
        name = 'Ambulabce - Garage',                            -- Blip name on the map

        display = 'all',                                        ---- 'none' = Won't show at all
                                                                ---- 'all' = Shows on both main map and minimap
                                                                ---- 'main' = Shows on main map only
                                                                ---- 'minimap' = Shows on main map only

        selectable = true,                                      -- Should we allow players to select this blip on map while display = 'all'? (while false, we will it remove from blips list on the map)
        job = 'ambulance',                                      -- Required job to show blip
        jobgrade = 0,                                           -- Required job grade to show blip, 0 for all grades
        sprite = 357,                                           -- Blip type
        color = 1,                                              -- Blip color
        opacity = 100,                                          -- Blip Opacity (0 - 100)
        scale = 0.8,                                            -- Blip scale
        shortrange = true,                                      -- While true, we will pin the blip on minimap   
        flashing = false,                                       -- While true, blip will start flashing
        flashinginv = 1,                                        -- While flashing is true, blip flashing invertal (IN SECONDS)
        shrink = false,                                         -- While true, blip will shrink slowly (MAY CAUSE HIGH RESMON)
        route = false,                                          -- While true, we will set this blip as waypoint route
        routecolor = 1,                                         -- While routecolor is true, what is your favorite color for route?
        coords = vector3(297.8, -607.31, 43.37)                 -- Blip location on the map!
    },
}

Config.EnableRadius = true
Config.Radiuses = {
    [1] = {
        sprite = 9,
        color = 1,
        coords = vector3(-778.03, -375.33, 69.45),
        radius = 100.0,
        opacity = 9,
    },
}