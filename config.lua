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

Locales['th'] = {
    ["not_in_deluxo"] = "ไม่ได้อยู่ในรถ Deluxo",
    ["out_of_fly_energy"] = "พลังงานหมด",
    ["energy_recharged"] = "พลังงานพร้อมใช้งานแล้ว",
    ["energy_full_recharged"] = "พลังงานชาร์จเต็มแล้ว"
}