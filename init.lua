local LED = 4
local SSID = "ssid"
local PASS = "password"
local status = gpio.HIGH
print('init.lua ver 1.2.2')
wifi.setmode(wifi.STATION)
print('set mode=STATION (mode='..wifi.getmode()..')')
print('MAC:  ',wifi.sta.getmac())
print('chip: ',node.chipid())
print('heap: ',node.heap())
print('Sebastian A. Bordi')
-- wifi config start
station_cfg={}
station_cfg.ssid=SSID
station_cfg.pwd=PASS
wifi.setmode(wifi.STATION)
wifi.sta.config(station_cfg)
wifi.sta.connect()
print('Conecting to Wifi')
while true 
    ipAdd = wifi.sta.getip()
    if ipAdd ~= nil then
        break
    end
    for i = 0, 500, +1
    do
        tmr.delay(1000)
    end
    -- toogle LED (pin 4) status
    if status == gpio.HIGH then 
        status = gpio.LOW
    else
        status = gpio.HIGH
    end
    gpio.write(LED, status)
    print('.') 
end
print('Wifi Connected')
-- wifi config end
-- inicia main.lua--
if file.open("main.lua") then
    print('Opening File main.lua')
    file.close()
    dofile("main.lua")
else
    print('main.lua could not be opened')
end