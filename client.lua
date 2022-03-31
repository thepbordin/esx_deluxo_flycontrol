-- WROTE BY https://www.facebook.com/thepbordin
-- GITHUB https://github.com/thepbordin
-- PANCAKE 2007 CITY

local isTransfrom, timeuse, canTransform = {}, {}, true

local veh, lastveh
local Config = {}
Config.TimeFlight = 30 -- in secs that DELUXO Can fly
Config.Debug = false -- Enable pancakeNotify Debug




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
                        if Config.Debug then exports['pancake_notify']:Alert("", "Status: true", 1500, 'info') end
                        Citizen.Wait(500)
                    
                    
                    elseif IsControlJustReleased(0, 357) and isTransfrom[lastveh] and canTransform and GetIsVehicleEngineRunning(veh) then
                        isTransfrom[lastveh] = false
                        if Config.Debug then exports['pancake_notify']:Alert("", "Status: false", 1500, 'info') end
                
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
                    if Config.Debug then exports['pancake_notify']:Alert("", "ไม่ได้อยู่บน Deluxo", 1500, 'warn')end
                end
                    SetVehicleHoverTransformPercentage(veh, 0.0)
                    SetVehicleHoverTransformEnabled(veh, false)
                    isTransfrom[lastveh] = false
                    canTransform = false
                    exports['pancake_notify']:Alert("", "พลังงานหมด", 1500, 'warn')
                Citizen.Wait(3000)
                SetVehicleHoverTransformEnabled(veh, true)          
                canTransform = true
                exports['pancake_notify']:Alert("", "พลังงานกลับมาใช้ได้แล้ว", 1500, 'info')

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
                    if Config.Debug then exports['pancake_notify']:Alert("", "TU: "..timeuse[lastveh], 1500, 'info') end
                end
                
                if timeuse[lastveh] == 0 then
                    exports['pancake_notify']:Alert("", "ชาร์จเต็มแล้ว", 1500, 'info')
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
                if Config.Debug then exports['pancake_notify']:Alert("", "TU: "..timeuse[lastveh], 1500, 'info') end
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

