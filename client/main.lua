local QBCore = exports['qb-core']:GetCoreObject()

canStart = true
ongoing = false
fixed = false
local alreadyEnteredZone = false

CreateThread(function()
    ItCompJob = AddBlipForCoord(1205.75, 320.16, 23.69)
    SetBlipSprite (ItCompJob, 606)
    SetBlipDisplay(ItCompJob, 4)
    SetBlipScale  (ItCompJob, 0.8)
    SetBlipAsShortRange(ItCompJob, true)
    SetBlipColour(ItCompJob, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Totally Wireless")
    EndTextCommandSetBlipName(ItCompJob)
end)

CreateThread(function()
    hashKey = RequestModel(GetHashKey(Config.TaskPed))


    while not HasModelLoaded(GetHashKey(Config.TaskPed)) do
        Wait(1)
    end

    local npc = CreatePed(4, Config.TaskPedHash, Config.TaskPedLocation, false, true)
    
    SetEntityHeading(npc, Config.TaskPedHeading)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
end)

CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.TaskPed, {
    	options = {
    		{
    			event = 'justbiz:takejob',
    			icon = 'far fa-clipboard',
    			label = 'Request',
                job = 'twit'
    		},
            {
                event = 'justbiz:finishjob',
                icon = 'far fa-clipboard',
                label = 'Finish Job',
                job = 'twit'
            },
    	},
    	distance = 2.5,
    })
end)

RegisterNetEvent('justbiz:takejob')
AddEventHandler('justbiz:takejob', function()
    checkedmon = false
    checkedgpu = false
    checkedcpu = false
    checkedssd = false

    if canStart then
        canStart = false
        ongoing = true
        SetTimeout(2000, function()
            TriggerEvent('justbiz:getrandomloc')
        end)
    else
        QBCore.Functions.Notify('Your job is still in progress.', 'error')
    end
end)

local s = math.random(1,4)

RegisterNetEvent('justbiz:finishjob')
AddEventHandler('justbiz:finishjob', function()
    if ongoing == true then
        if fixed == true then
            TriggerEvent('qb-menu:withdraw')
        else
            QBCore.Functions.Notify('You are not done yet!', 'error')
        end
    else
        QBCore.Functions.Notify('You need to start job first!', 'error')
    end
end)

RegisterNetEvent("justbiz:getrandomloc")
AddEventHandler("justbiz:getrandomloc", function()
    local missionTarget = Config.Locations[math.random(#Config.Locations)]
    TriggerEvent("justbiz:createblipandroute", missionTarget)
    TriggerEvent("justbiz:createentry", missionTarget)
end)

RegisterNetEvent("justbiz:createblipandroute")
AddEventHandler("justbiz:createblipandroute", function(missionTarget)
    QBCore.Functions.Notify('You received a job, talk to Kevin before you leave', "success")
    targetBlip = AddBlipForCoord(missionTarget.location.x, missionTarget.location.y, missionTarget.location.z)
    SetBlipSprite(targetBlip, 374)
    SetBlipColour(targetBlip, 11)
    SetBlipAlpha(targetBlip, 90)
    SetBlipScale(targetBlip, 0.5)
    SetBlipRoute(targetBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.BlipName)
    EndTextCommandSetBlipName(targetBlip)
end)


CreateThread(function()
    local missionTarget = Config.Locations[#Config.Locations]

    for i,v in ipairs(missionTarget.comp) do

        exports['qb-target']:AddCircleZone('CheckPC', vector3(v.x, v.y, v.z), 1.0,{
            name = 'CheckPC',
            debugPoly = false, 
            useZ=true
        }, {
            options = {{
                label = 'Check PC',
                icon = 'fa-solid fa-hand-holding',
                action = function()
                    openfixmenu() 
                end}},
                job = 'twit',
            distance = 2.0
        })
    end
end)

RegisterNetEvent('qb-menu:FixMenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header = 'Available Options',
            isMenuHeader = true
        },
        {
            header = 'Check Monitor',
            params = {
                event = "justbiz:checkmonitor"
            }
        },
        {
            header = 'Check GPU',
            params = {
                event = "justbiz:checkgpu"
            }
        },
        {
            header = 'Check CPU',
            params = {
                event = "justbiz:checkcpu"
            }
        },
        {
            header = 'Check SSD',
            params = {
                event = "justbiz:checkssd"
            }
        },
        {
            header = 'Close (ESC)',
            isMenuHeader = true
        }
    })
end)

RegisterNetEvent('justbiz:checkmonitor')
AddEventHandler('justbiz:checkmonitor', function()
    if checkedmon == false then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
                QBCore.Functions.Progressbar("pickup", 'Checking', 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },{
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                    flags = 8,
                    }
                )
                Wait(10000)
                if s == 1 then
                    TriggerEvent('qb-menu:ImBroken')
                else
                    QBCore.Functions.Notify('This part is not broken')
                    checkedmon = true
                end
            else
                QBCore.Functions.Notify('You dont have a toolbox', 'error')
            end
        end, 'tw_toolbox')
    else
        QBCore.Functions.Notify('You already checked this part', 'error')
    end
end)

RegisterNetEvent('justbiz:checkgpu')
AddEventHandler('justbiz:checkgpu', function()
    if checkedgpu == false then
        if checkedmon == true then
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
                if HasItem then
                    QBCore.Functions.Progressbar("pickup", 'Checking', 10000, true, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },{
                        animDict = "mini@repair",
                        anim = "fixing_a_ped",
                        flags = 8,
                        }
                    )
                    Wait(10000)
                    if s == 2 then
                        TriggerEvent('qb-menu:ImBroken')
                    else
                        QBCore.Functions.Notify('This part is not broken')
                        checkedgpu = true
                    end
                else
                    QBCore.Functions.Notify('You dont have a toolbox', 'error')
                end
            end, 'tw_toolbox')
        else
            QBCore.Functions.Notify('Check monitor!', 'error')
        end
    else
        QBCore.Functions.Notify('You already checked this part', 'error')
    end
end)

RegisterNetEvent('justbiz:checkcpu')
AddEventHandler('justbiz:checkcpu', function()
    if checkedcpu == false then
        if checkedgpu == true then
            if checkedmon == true then
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
                    if HasItem then
                        QBCore.Functions.Progressbar("pickup", 'Checking', 10000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },{
                            animDict = "mini@repair",
                            anim = "fixing_a_ped",
                            flags = 8,
                            }
                        )
                        Wait(10000)
                        if s == 3 then
                            TriggerEvent('qb-menu:ImBroken')
                        else
                            QBCore.Functions.Notify('This part is not broken')
                            checkedcpu = true
                        end
                    else
                        QBCore.Functions.Notify('You dont have a toolbox', 'error')
                    end
                end, 'tw_toolbox')
            else
                QBCore.Functions.Notify('Check monitor!', 'error')
            end
        else
            QBCore.Functions.Notify('Check GPU!', 'error')
        end
    else
        QBCore.Functions.Notify('You already checked this part', 'error')
    end
end)

RegisterNetEvent('justbiz:checkssd')
AddEventHandler('justbiz:checkssd', function()
    if checkedssd == false then
        if checkedcpu == true then
            if checkedgpu == true then
                if checkedmon == true then
                    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
                        if HasItem then
                            QBCore.Functions.Progressbar("pickup", 'Checking', 10000, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            },{
                                animDict = "mini@repair",
                                anim = "fixing_a_ped",
                                flags = 8,
                                }
                            )
                            Wait(10000)
                            if s == 4 then
                                TriggerEvent('qb-menu:ImBroken')
                            else
                                QBCore.Functions.Notify('This part is not broken')
                                checkedssd = true
                            end
                        else
                            QBCore.Functions.Notify('You dont have a toolbox', 'error')
                        end
                    end, 'tw_toolbox')
                else
                    QBCore.Functions.Notify('Check monitor!', 'error')
                end
            else
                QBCore.Functions.Notify('Check GPU!', 'error')
            end
        else
            QBCore.Functions.Notify('Check CPU!', 'error')
        end
    else
        QBCore.Functions.Notify('You already checked this part', 'error')
    end
end)


RegisterNetEvent('qb-menu:ImBroken', function(data)
    exports['qb-menu']:openMenu({
        {
            header = 'Theres something wrong, let me replace it',
            isMenuHeader = true
        },
        {
            header = 'Replace part',
            params = {
                event = "justbiz:replace"
            }
        },
    })
end)

RegisterNetEvent('qb-menu:withdraw', function(data)
    exports['qb-menu']:openMenu({
        {
            header = 'Available Options',
            isMenuHeader = true
        },
        {
            header = 'Withdraw money',
            params = {
                event = "qb-menu:cashbank"
            }
        },
    })
end)

RegisterNetEvent('qb-menu:cashbank', function(data)
    exports['qb-menu']:openMenu({
        {
            header = 'Available Options',
            isMenuHeader = true
        },
        {
            header = 'Cash',
            params = {
                event = "justbiz:finishjob2",
                canStart = true
            }
        },
        {
            header = 'Bank',
            params = {
                event = "justbiz:finishjob3",
                canStart = true
            }
        },
    })
end)

RegisterNetEvent('justbiz:finishjob2')
AddEventHandler('justbiz:finishjob2', function()
    TriggerServerEvent('justbiz:server:cash', 520)
    canStart = true
    ongoing = false
    fixed = false
end)

RegisterNetEvent('justbiz:finishjob3')
AddEventHandler('justbiz:finishjob3', function()
    TriggerServerEvent('justbiz:server:bank', 520)
    canStart = true
    ongoing = false
    fixed = false
end)

RegisterNetEvent('justbiz:replace')
AddEventHandler('justbiz:replace', function()
    if s == 1 then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
                QBCore.Functions.Progressbar("pickup", 'Replacing part', 20000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },{
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                    flags = 8,
                    }
                )
                Wait(20000)
                TriggerServerEvent('justbiz:server:takeitem', "tw_monitor", 1)
                TriggerEvent('justbiz:fixedpc')
                fixed = true
                RemoveBlip(targetBlip)
            else
                QBCore.Functions.Notify('You dont have a monitor', 'error')
            end
        end, 'tw_monitor')
    elseif s == 2 then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
                QBCore.Functions.Progressbar("pickup", 'Replacing part', 20000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },{
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                    flags = 8,
                    }
                )
                Wait(20000)
                TriggerServerEvent('justbiz:server:takeitem', "tw_graphiccard", 1)
                TriggerEvent('justbiz:fixedpc')
                fixed = true
                RemoveBlip(targetBlip)
            else
                QBCore.Functions.Notify('You dont have a graphics card', 'error')
            end
        end, 'tw_graphiccard')
    elseif s == 3 then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
                QBCore.Functions.Progressbar("pickup", 'Replacing part', 20000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },{
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                    flags = 8,
                    }
                )
                Wait(20000)
                TriggerServerEvent('justbiz:server:takeitem', "tw_cpu", 1)
                TriggerEvent('justbiz:fixedpc')
                fixed = true
                RemoveBlip(targetBlip)
            else
                QBCore.Functions.Notify('You dont have a cpu', 'error')
            end
        end, 'tw_cpu')
    elseif s == 4 then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
                QBCore.Functions.Progressbar("pickup", 'Replacing part', 20000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },{
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                    flags = 8,
                    }
                )
                Wait(20000)
                TriggerServerEvent('justbiz:server:takeitem', "tw_ssd", 1)
                TriggerEvent('justbiz:fixedpc')
                fixed = true
                RemoveBlip(targetBlip)
            else
                QBCore.Functions.Notify('You dont have a ssd', 'error')
            end
        end, 'tw_ssd')
    end
end)

RegisterNetEvent('justbiz:fixedpc')
AddEventHandler('justbiz:fixedpc', function()
    if Config.Phone == 'qb-phone' then
        if Config.Phone == "qb-phone" then
            TriggerServerEvent('qb-phone:server:sendNewMail', {
                sender =  'Nathan (Coworker)',
                subject = 'Customer Satisfied',
                message = 'Great work out there! Come back to collect your cash',
            })
        end
    end
end)

function openfixmenu()
    if fixed == true then
        QBCore.Functions.Notify('Already fixed', 'error')
    else
        TriggerEvent('qb-menu:FixMenu')
    end
end
