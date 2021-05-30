local LED = 4
local PERIOD = 5000
local PASSWORD = 12345
local MAC = wifi.sta.getmac()
local ENDPOINT = "https://dlm.emconsol.com/dlm/api/v1/measurement"

local callback = function(code, body, headers){
    if code < 0 || code > 299 then
        print("\n\rerror "..code.."\n\r"..body.."\n\r")
    else
        print("\n\rmeasurement sended "..body.."\n\r")
    end
    gpio.write(LED, gpio.HIGH)
}

function main(){

}

function sendMeasures(temperature, humidity){
    gpio.write(LED, gpio.LOW)
    headers="Content-Type: application/json\r\n}"
    body="{\"temperature\": "..temperature..",\"humidity\": "..humidity..",\"mac\": "..MAC..", \"password\":"..PASSWORD.."}"
    http.post(ENDPOINT, headers, body, callback)
}

main()