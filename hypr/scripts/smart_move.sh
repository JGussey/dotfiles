#!/bin/bash
# $1 is the target workspace passed from Super+Shift+[0-9]

INFO=$(hyprctl activewindow)

# -------------------------------------------------------------
# 1. THE MASTER VIP ROSTER (Add or remove games here anytime)
# -------------------------------------------------------------
GAMES=(
    "aimlabs"
    "alan wake"
    "arc raiders"
    "clair obscur"
    "expedition 33"
    "counter-strike"
    "cs2"
    "crimson desert"
    "dark souls"
    "deadlock"
    "delta force"
    "divinity"
    "dune"
    "elden ring"
    "enshrouded"
    "factorio"
    "fellowship"
    "final fantasy"
    "ffxiv"
    "gray zone"
    "gzw"
    "guild wars"
    "gw2"
    "hellblade"
    "helldivers"
    "hogwarts"
    "hollow knight"
    "silksong"
    "kingdom come"
    "marvel rivals"
    "nba 2k"
    "palworld"
    "project: gorgon"
    "quinfall"
    "star wars"
    "swtor"
    "terraria"
    "division 2"
    "valheim"
    "warframe"
    "world of warcraft"
    "wow"
)

# Compile array into a single supersonic regex: "aimlabs|alan wake|arc raiders|..."
PATTERN=$(IFS="|"; echo "${GAMES[*]}")

# -------------------------------------------------------------
# 2. THE CHECK (Executes in roughly 0.001 seconds)
# -------------------------------------------------------------
if echo "$INFO" | grep -iqE "$PATTERN"; then
    # Dynamically pluck the exact rendered Window Title for the notification
    GAME_TITLE=$(echo "$INFO" | grep -i "title:" | head -n 1 | sed 's/^\s*title:\s*//')
    
    notify-send -t 1500 "VIP Game Locked" "$GAME_TITLE is pinned to DP-1"
    exit 0
fi

# -------------------------------------------------------------
# 3. THE EJECTOR SEAT (If it wasn't on the list, yeet it)
# -------------------------------------------------------------
hyprctl dispatch "hl.dsp.window.move({ workspace = $1 })"
