#!/bin/bash

SteamCMD="/home/steam/steamcmd/steamcmd.sh"
GameDir="/home/steam/palworld"

# Download Palworld
echo "[Steam] Downloading Palworld..."
$SteamCMD \
  +force_install_dir ${GameDir} \
  +login anonymous \
  +app_update 2394010 \
  validate \
  +quit
echo "[Steam] Download Completed!"

# Copy Settings.ini
# The md5sum of two blank lines is: 68b329da9893e34099c7d8ad5cb9c940
Settings_sum=$(md5sum "${GameDir}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini" | cut -d" " -f1)
if [ "68b329da9893e34099c7d8ad5cb9c940" = "${Settings_sum}" ]; then
  echo "[PalServer] Initializing Settings.ini..."
  cp -f "${GameDir}/DefaultPalWorldSettings.ini" "${GameDir}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini"
  echo "[PalServer] Initialized Settings.ini!"
fi

# Start Pal Server
/home/steam/scripts/start.sh

# Ensure the Server is up to date
while :; do
  # Fetch Current Version
  current_version=$($SteamCMD \
    +force_install_dir ${GameDir} \
    +login anonymous \
    +app_status 2394010 \
    +quit | \
    awk '/BuildID/{print$8}'\
  )

  # Fetch Remote Version
  remote_version=$($SteamCMD \
    +force_install_dir ${GameDir} \
    +login anonymous \
    +app_info_print 2394010 \
    +quit | \
    grep -A2 "public" | \
    awk -F\" '/buildid/{print$4}' \
  )

  echo "[Updater] Current Version: ${current_version}"
  echo "[Updater] Remote Version : ${remote_version}"
  if [ "${current_version}" -ne "${remote_version}" ]; then
    echo "[Updater] A new version is available!"
    echo "[Updater] Starting Update..."
    $SteamCMD \
      +force_install_dir ${GameDir} \
      +login anonymous \
      +app_update 2394010 \
      validate \
      +quit > /dev/null
    echo "[Updater] Update completed!"
    echo "[Updater] Restarting Server..."
    kill -SIGINT "$(cat /home/steam/palworld.pid)"
    /home/steam/scripts/start.sh
  else
    echo "[Updater] There are no new versions."
    sleep 3h
  fi
done
