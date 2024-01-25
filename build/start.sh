#!/bin/bash

# Argument
SV_Arg=""

if [ "${MULTITHREAD}" = true ]; then
  SV_Arg+="-useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"
fi

if [ -n "${PORT}" ]; then
  SV_Arg+=" -port=${PORT}"
fi

if [ -n "${PLAYERS}" ]; then
  SV_Arg+=" -players=${PLAYERS}"
fi

if [ -n "${SERVER_NAME}" ]; then
  SV_Arg+=" -servername=${SERVER_NAME}"
fi

if [ -n "${SERVER_PASS}" ]; then
  SV_Arg+=" -serverpassword=${SERVER_PASS}"
fi

if [ -n "${ADMIN_PASS}" ]; then
  SV_Arg+=" -adminpassword=${ADMIN_PASS}"
fi

if [ "${COMMUNITY_SERVER}" = true ]; then
  SV_Arg+=" EpicApp=PalServer"
  if [ -n "${PUBLIC_IP}" ]; then
    SV_Arg+=" -publicip=${PUBLIC_IP}"
  fi
  if [ -n "${PUBLIC_PORT}" ]; then
    SV_Arg+=" -publicport=${PUBLIC_PORT}"
  fi
fi

# Show Server Argument
echo "Server Arg: ${SV_Arg}"

# Start Pal Server
echo "[PalServer] Starting..."

/home/steam/palworld/PalServer.sh \
  "${SV_Arg}" &
echo $! > /home/steam/palworld.pid

echo "[PalServer] Started!"
