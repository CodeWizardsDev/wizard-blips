local Framework = nil
local PlayerData = {}
local blips = {}

Citizen.CreateThread(function()
    if Config.Framework == 'esx' then
        while Framework == nil do
            Framework = exports["es_extended"]:getSharedObject()
            Citizen.Wait(0)
        end
        while Framework.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end
        PlayerData = Framework.GetPlayerData()
    else
        Framework = exports['qb-core']:GetCoreObject()
        PlayerData = Framework.Functions.GetPlayerData()
    end
    generateBlips()
end)

if Config.Framework == 'esx' then
    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        PlayerData.job = job
        Wait(100)
        removeBlips()
        generateBlips()
    end)
else
    RegisterNetEvent('QBCore:Client:OnGangUpdate')
    AddEventHandler('QBCore:Client:OnGangUpdate', function(InfoGang)
        PlayerData.gang = InfoGang
        Wait(100)
        removeBlips()
        generateBlips()
    end)
    RegisterNetEvent('QBCore:Client:OnJobUpdate')
    AddEventHandler('QBCore:Client:OnJobUpdate', function(InfoJob)
        PlayerData.job = InfoJob
        Wait(100)
        removeBlips()
        generateBlips()
    end)
end

function generateBlips()
    removeBlips()
    if Config.Framework == 'esx' then
        PlayerData = Framework.GetPlayerData()
    else
        PlayerData = Framework.Functions.GetPlayerData()
    end
    if Config.EnableSingle then
        for _, v in pairs(Config.Singles) do
            local isValidBlip = true
            if v.gang and Config.Framework == 'qb' and (not PlayerData.gang or PlayerData.gang.name ~= v.gang or 
                (v.ganggrade and PlayerData.gang.grade.level < v.ganggrade)) then
                isValidBlip = false
            elseif v.gang and Config.Framework == 'qbx' and (not PlayerData.gang or PlayerData.gang.name ~= v.gang or 
                (v.ganggrade and PlayerData.gang.grade.level < v.ganggrade)) then
                isValidBlip = false
            end
            if v.job then
                if Config.Framework == 'esx' and (not PlayerData.job or PlayerData.job.name ~= v.job or 
                    (v.jobgrade and PlayerData.job.grade < v.jobgrade)) then
                    isValidBlip = false
                elseif Config.Framework == 'qb' and (not PlayerData.job or PlayerData.job.name ~= v.job or 
                    (v.jobgrade and PlayerData.job.grade.level < v.jobgrade)) then
                    isValidBlip = false
                elseif Config.Framework == 'qbx' and (not PlayerData.job or PlayerData.job.name ~= v.job or 
                    (v.jobgrade and PlayerData.job.grade.level < v.jobgrade)) then
                    isValidBlip = false
                end
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