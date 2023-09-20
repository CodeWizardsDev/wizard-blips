local QBCore = exports['qb-core']:GetCoreObject()
local blips = {}

Citizen.CreateThread(function()
    generateBlips()
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(InfoGang)
    removeBlips()
    generateBlips()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(InfoJob)
    removeBlips()
    generateBlips()
end)

function generateBlips()
    removeBlips()

    local playerData = QBCore.Functions.GetPlayerData()

    if Config.EnableSingle then
        for _, v in pairs(Config.Singles) do
            local isValidBlip = true

            if v.gang and (not playerData.gang or playerData.gang.name ~= v.gang or 
                (v.ganggrade and playerData.gang.grade.level < v.ganggrade)) then
                isValidBlip = false
            end

            if v.job and (not playerData.job or playerData.job.name ~= v.job or 
                (v.jobgrade and playerData.job.grade.level < v.jobgrade)) then
                isValidBlip = false
            end

            if isValidBlip then
                local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
                SetBlipAlpha(blip, v.opacity * 10)
                SetBlipSprite(blip, v.sprite)
                SetBlipColour(blip, v.color)
                SetBlipAsShortRange(blip, v.shortrange)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.name)
                EndTextCommandSetBlipName(blip)

                if v.display == 'none' then
                    SetBlipDisplay(blip, 0)
                elseif v.display == 'all' then
                    SetBlipDisplay(blip, v.selectable and 2 or 8)
                elseif v.display == 'main' then
                    SetBlipDisplay(blip, 3)
                elseif v.display == 'minimap' then
                    SetBlipDisplay(blip, 5)
                else
                    SetBlipDisplay(blip, 2)
                end

                if v.route then
                    SetBlipRoute(blip, true)
                    if v.routecolor then
                        SetBlipRouteColour(blip, v.routecolor)
                    end
                else
                    SetBlipRoute(blip, false)
                end

                if v.flashing then
                    SetBlipFlashes(blip, true)
                    SetBlipFlashInterval(blip, v.flashinginv and v.flashinginv * 1000 or 1000)
                else
                    SetBlipFlashes(blip, false)
                end

                if v.shrink then
                    Citizen.CreateThread(function()
                        local scaleValues = {v.scale - 0.5, v.scale - 0.4, v.scale - 0.3, v.scale - 0.2, v.scale - 0.1,
                            v.scale, v.scale + 0.1, v.scale + 0.2, v.scale + 0.3, v.scale + 0.4, v.scale + 0.5, v.scale + 0.4,
                            v.scale + 0.3, v.scale + 0.2, v.scale + 0.1, v.scale, v.scale - 0.1, v.scale - 0.2, v.scale - 0.3,
                            v.scale - 0.4, v.scale - 0.5}

                        while v.shrink do
                            for _, scale in ipairs(scaleValues) do
                                SetBlipScale(blip, scale)
                                Citizen.Wait(50)
                            end
                        end
                    end)
                else
                    SetBlipScale(blip, v.scale)
                end
                table.insert(blips, blip)
            end
        end
    end

    if Config.EnableRadius then
        for _, v in pairs(Config.Radiuses) do
            local blip = AddBlipForRadius(v.coords.x, v.coords.y, v.coords.z, v.radius)
            SetBlipSprite(blip, v.sprite)
            SetBlipColour(blip, v.color)
            SetBlipAlpha(blip, v.opacity * 10)
            table.insert(blips, blip)
        end
    end
end

function removeBlips()
    for _, blip in ipairs(blips) do
        RemoveBlip(blip)
    end
    blips = {}
end