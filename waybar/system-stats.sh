#!/usr/bin/env sh

cpu=$(top -bn1 | awk -F'[, %]+' '/Cpu/ {print int(100-$8)}')
ram=$(free -m | awk '/Mem:/ {printf "%.1f", $3/1024}')
temp=""
for sensor in /sys/class/thermal/thermal_zone*/temp; do
  [ -r "$sensor" ] || continue
  temp=$(awk '{printf "%.0f", $1/1000}' "$sensor")
  break
done

if [ -n "$temp" ]; then
  printf '⚙ %sGB | %s%% | %sC\n' "$ram" "$cpu" "$temp"
else
  printf '⚙ %sGB | %s%%\n' "$ram" "$cpu"
fi
