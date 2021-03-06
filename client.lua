-- WROTE BY https://www.facebook.com/thepbordin
-- GITHUB https://github.com/thepbordin
-- PANCAKE 2007 CITY

local isTransfrom, timeuse, canTransform = {}, {}, true
local veh, lastveh
Citizen.CreateThread(function()

    while true do
    Citizen.Wait(7)
        
        ped = GetPlayerPed(-1)
        veh = GetVehiclePedIsIn(ped)
        lastveh = GetVehiclePedIsIn(ped, true)
        tryingtoenter = GetVehiclePedIsTryingToEnter(ped)
        
        if veh ~= nil then
            if GetPedInVehicleSeat(veh, -1) == ped then
                if CheckIsVehDeluxo(veh) then
                    if IsControlJustReleased(0, 357) and not isTransfrom[lastveh] and canTransform and GetIsVehicleEngineRunning(veh) then
                        isTransfrom[lastveh] = true
                        timeuse[lastveh] = timeuse[lastveh] or 0
                        if Config.Debug then 
                            exports.pNotify:SendNotification({text = "Status: true", type = "info"})
                        end
                        Citizen.Wait(500)
                    
                    
                    elseif IsControlJustReleased(0, 357) and isTransfrom[lastveh] and canTransform and GetIsVehicleEngineRunning(veh) then
                        isTransfrom[lastveh] = false
                        if Config.Debug then 
                            exports.pNotify:SendNotification({text = "Status: false", type = "info"})
                        end
                
                    end
                end 
                local isDead = IsEntityDead(ped)
                if isDead then -- isn't dead
                    SetVehicleHoverTransformPercentage(lastveh, 0.0) 
                    SetVehicleHoverTransformEnabled(lastveh, true)
                    isTransfrom[lastveh] = false
                end
            end
            
        end
        if lastveh ~= nil then 
            if GetPedInVehicleSeat(lastveh, -1) == 0 then -- isn't in veh
                SetVehicleHoverTransformPercentage(lastveh, 0.0) 
                SetVehicleHoverTransformEnabled(lastveh, true)
                isTransfrom[lastveh] = false
            end
            
        end
        
    end
end)



Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        if isTransfrom[lastveh] and timeuse[lastveh] then
            if timeuse[lastveh] >= Config.TimeFlight then
                while not CheckIsVehDeluxo(veh) do
                    Citizen.Wait(400)
                    if Config.Debug then 
                        exports.pNotify:SendNotification({text = Locales[Config.Locale]["not_in_deluxo"], type = "error"})
                    end
                end
                    SetVehicleHoverTransformPercentage(veh, 0.0)
                    SetVehicleHoverTransformEnabled(veh, false)
                    isTransfrom[lastveh] = false
                    canTransform = false
                    exports.pNotify:SendNotification({text = Locales[Config.Locale]["out_of_fly_energy"], type = "info"})
                Citizen.Wait(3000)
                SetVehicleHoverTransformEnabled(veh, true)          
                canTransform = true
                exports.pNotify:SendNotification({text = Locales[Config.Locale]["energy_recharged"], type = "success"})

            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if timeuse[lastveh] ~= nil and isTransfrom[lastveh] ~= nil then
            if timeuse[lastveh] > 0 and isTransfrom[lastveh] == false then
                SetVehicleHoverTransformPercentage(veh, 0.0)
                Citizen.Wait(1000)
                if timeuse[lastveh] ~= nil then
                    timeuse[lastveh] = timeuse[lastveh] - 1
                    if Config.Debug then 
                        exports.pNotify:SendNotification({text = "TU:"..timeuse[lastveh], type = "info"})
                    end
                end
                
                if timeuse[lastveh] == 0 then
                    exports.pNotify:SendNotification({text = Locales[Config.Locale]["energy_full_recharged"], type = "success"})
                    SetVehicleHoverTransformEnabled(lastveh, true)
                    isTransfrom[lastveh] = false
                end
                
            end
        end
        
        
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isTransfrom[lastveh] ~= nil and timeuse[lastveh] ~= nil then 
            while isTransfrom[lastveh] and CheckIsVehDeluxo(veh) and timeuse[lastveh] < Config.TimeFlight do
                
                timeuse[lastveh] = timeuse[lastveh] + 1
                if Config.Debug then 
                    exports.pNotify:SendNotification({text = "TU:"..timeuse[lastveh], type = "info"})
                end
                Citizen.Wait(1000)
                
            end
        end
    end
end)

function CheckIsVehDeluxo(a)
    if GetEntityModel(a) == 1483171323 then
        return true
    else
        return false
    end
end

