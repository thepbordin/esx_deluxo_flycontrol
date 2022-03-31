# ✈️esx_deluxo_flycontrol 
 This resource controls "Deluxo" flight machanic (time and cooldown) in esx fivem servers,
 plese feel free to use, edit.

## Features
- Limit "Deluxo" flying time in seconds
- Slowly recharge flying time

## Requirement 
- ESX
- pNotify
## Defult Config

```
local Config = {}
Config.Locale = 'en'
Config.TimeFlight = 30 -- in secs that DELUXO Can fly
Config.Debug = false -- Enable pNotify debug Caution: All players can see this 

Locales['en'] = {
    ["not_in_deluxo"] = "You're not in Deluxo!",
    ["out_of_fly_energy"] = "Energy ran out!",
    ["energy_recharged"] = "Energy recharged!",
    ["energy_full_recharged"] = "Energy fully recharged!"
}

Locals['th'] = {
    ["not_in_deluxo"] = "ไม่ได้อยู่ในรถ Deluxo",
    ["out_of_fly_energy"] = "พลังงานหมด",
    ["energy_recharged"] = "พลังงานพร้อมใช้งานแล้ว",
    ["energy_full_recharged"] = "พลังงานชาร์จเต็มแล้ว"
}
```
