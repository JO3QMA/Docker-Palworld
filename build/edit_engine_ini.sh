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


# Optimize other option
if [ "${OPTIMIZE}" = true ]; then
  # [/Script/OnlineSubsystemUtils.IpNetDriver]
  crudini --set --format=ini "${ENGINE_INI}" "/Script/OnlineSubsystemUtils.IpNetDriver" "NetServerMaxTickRate" "${TICKRATE}"

  # [/script/engine.player]
  crudini --set --format=ini "${ENGINE_INI}" "/script/engine.player" "ConfiguredInternetSpeed" "104857600"

  # [/script/socketsubsystemepic.epicnetdriver]
  crudini --set --format=ini "${ENGINE_INI}" "/script/socketsubsystemepic.epicnetdriver" "MaxClientRate" "104857600"

  # [/script/engine.engine]
  crudini --set --format=ini "${ENGINE_INI}" "/script/engine.engine" "bSmoothFrameRate" "true"
  crudini --set --format=ini "${ENGINE_INI}" "/script/engine.engine" "bUseFixedFrameRate" "false"
  crudini --set --format=ini "${ENGINE_INI}" "/script/engine.engine" "SmoothedFrameRateRange" "(Type=Inclusive,Value=30.000000),UpperBound=(Type=Exclusive,Value=${TICKRATE}.000000))"
  crudini --set --format=ini "${ENGINE_INI}" "/script/engine.engine" "MinDesiredFrameRate" "60.000000"
  crudini --set --format=ini "${ENGINE_INI}" "/script/engine.engine" "FixedFrameRate" "${TICKRATE}.000000"
  crudini --set --format=ini "${ENGINE_INI}" "/script/engine.engine" "NetClientTicksPerSecond" "${TICKRATE}"
fi