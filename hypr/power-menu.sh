#!/usr/bin/env bash
set -euo pipefail

choice=$(printf 'Lock\nSuspend\nReboot\nShutdown\nLogout\n' | fuzzel --dmenu --config /home/dhaval/forge/fuzzel/fuzzel.ini --prompt='Power: ' --lines=5 --width=18)

case "$choice" in
  Lock)
    command -v hyprlock >/dev/null 2>&1 && hyprlock -c /home/dhaval/forge/hypr/hyprlock.conf || loginctl lock-session
    ;;
  Suspend)
    systemctl suspend
    ;;
  Reboot)
    systemctl reboot
    ;;
  Shutdown)
    systemctl poweroff
    ;;
  Logout)
    command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit
    ;;
esac
