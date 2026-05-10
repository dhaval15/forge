#!/usr/bin/env bash
set -euo pipefail

command -v hyprlock >/dev/null 2>&1 && hyprlock -c /home/dhaval/forge/hypr/hyprlock.conf || loginctl lock-session
