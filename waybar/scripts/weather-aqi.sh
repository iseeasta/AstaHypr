#!/usr/bin/env bash

LAT="28.6692"
LON="77.4538"

WEATHER=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&current=temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,wind_speed_10m&timezone=Asia%2FKolkata")

AQI=$(curl -s "https://air-quality-api.open-meteo.com/v1/air-quality?latitude=${LAT}&longitude=${LON}&current=us_aqi,pm2_5,pm10,carbon_monoxide,nitrogen_dioxide,ozone&timezone=Asia%2FKolkata")

temp=$(echo "$WEATHER" | jq -r '.current.temperature_2m')
feels=$(echo "$WEATHER" | jq -r '.current.apparent_temperature')
humidity=$(echo "$WEATHER" | jq -r '.current.relative_humidity_2m')
wind=$(echo "$WEATHER" | jq -r '.current.wind_speed_10m')
code=$(echo "$WEATHER" | jq -r '.current.weather_code')

aqi=$(echo "$AQI" | jq -r '.current.us_aqi')
pm25=$(echo "$AQI" | jq -r '.current.pm2_5')
pm10=$(echo "$AQI" | jq -r '.current.pm10')
co=$(echo "$AQI" | jq -r '.current.carbon_monoxide')
no2=$(echo "$AQI" | jq -r '.current.nitrogen_dioxide')
o3=$(echo "$AQI" | jq -r '.current.ozone')

hour=$(date +%H)

# Time of day greeting + icon
if   (( hour >= 5  && hour < 12 )); then daypart="Morning"; day_icon="🌅"
elif (( hour >= 12 && hour < 17 )); then daypart="Afternoon"; day_icon="🌤"
elif (( hour >= 17 && hour < 20 )); then daypart="Evening"; day_icon="🌇"
else daypart="Night"; day_icon="🌙"
fi

# Full WMO weather code mapping
case "$code" in
    0) icon="☀️"; desc="Clear sky" ;;
    1) icon="🌤"; desc="Mainly clear" ;;
    2) icon="⛅"; desc="Partly cloudy" ;;
    3) icon="☁️"; desc="Overcast" ;;
    45) icon="🌫"; desc="Fog" ;;
    48) icon="🌫"; desc="Depositing rime fog" ;;
    51) icon="🌦"; desc="Light drizzle" ;;
    53) icon="🌦"; desc="Moderate drizzle" ;;
    55) icon="🌧"; desc="Dense drizzle" ;;
    56|57) icon="🌧"; desc="Freezing drizzle" ;;
    61) icon="🌦"; desc="Slight rain" ;;
    63) icon="🌧"; desc="Moderate rain" ;;
    65) icon="🌧"; desc="Heavy rain" ;;
    66|67) icon="🌧"; desc="Freezing rain" ;;
    71) icon="🌨"; desc="Slight snow" ;;
    73) icon="❄️"; desc="Moderate snow" ;;
    75) icon="❄️"; desc="Heavy snow" ;;
    77) icon="❄️"; desc="Snow grains" ;;
    80) icon="🌦"; desc="Slight rain showers" ;;
    81) icon="🌧"; desc="Moderate rain showers" ;;
    82) icon="⛈"; desc="Violent rain showers" ;;
    85|86) icon="🌨"; desc="Snow showers" ;;
    95) icon="⛈"; desc="Thunderstorm" ;;
    96|99) icon="⛈"; desc="Thunderstorm with hail" ;;
    *) icon="🌡"; desc="Unknown" ;;
esac

if (( $(echo "$aqi <= 50" | bc -l) )); then aqi_label="Good 🟢"
elif (( $(echo "$aqi <= 100" | bc -l) )); then aqi_label="Moderate 🟡"
elif (( $(echo "$aqi <= 150" | bc -l) )); then aqi_label="Unhealthy (SG) 🟠"
elif (( $(echo "$aqi <= 200" | bc -l) )); then aqi_label="Unhealthy 🔴"
elif (( $(echo "$aqi <= 300" | bc -l) )); then aqi_label="Very Unhealthy 🟣"
else aqi_label="Hazardous 🔴"
fi

text="${icon} ${temp}°C | AQI ${aqi}"

tooltip="${day_icon} Good ${daypart}, Asta!\n"
tooltip+="Ghaziabad, UP\n"
tooltip+="\n"
tooltip+="${icon} ${desc}\n"
tooltip+="Temperature: ${temp}°C (feels like ${feels}°C)\n"
tooltip+="Humidity: ${humidity}%\n"
tooltip+="Wind: ${wind} km/h\n"
tooltip+="\n"
tooltip+="🌫 Air Quality Index: ${aqi} — ${aqi_label}\n"
tooltip+="PM2.5: ${pm25} µg/m³\n"
tooltip+="PM10: ${pm10} µg/m³\n"
tooltip+="CO: ${co} µg/m³\n"
tooltip+="NO2: ${no2} µg/m³\n"
tooltip+="O3: ${o3} µg/m³"

tooltip_json=$(echo "$tooltip" | sed ':a;N;$!ba;s/\n/\\n/g')

echo "{\"text\": \"${text}\", \"tooltip\": \"${tooltip_json}\"}"