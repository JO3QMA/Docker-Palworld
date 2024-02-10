#!/bin/bash

# In the "/Script/OnlineSubsystemUtils.IpNetDriver" section of "Engine.ini",
#  specify "NetServerMaxTickRate" to set the server tick rate (Framerate).

declare -r ENGINE_INI="/home/steam/palworld/Pal/Saved/Config/LinuxServer/Engine.ini"

# Engine.ini existence check
if [ ! -f "${ENGINE_INI}" ]; then
  echo "[Config] Engine.ini does not exist."
  echo "[Config] Skip Engine.ini changes."
  exit 0
fi

# [/Script/OnlineSubsystemUtils.IpNetDriver]
## NetServerMaxTickRate
crudini --set --format=ini "${ENGINE_INI}" "[/Script/OnlineSubsystemUtils.IpNetDriver]" "NetServerMaxTickRate" "${TICKRATE}"
