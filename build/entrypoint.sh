#!/bin/bash

SteamCMD="/home/steam/steamcmd/steamcmd.sh"
GameDir="/home/steam/palworld"

# Download Palworld Data
echo "Download Server Data..."
$SteamCMD \
  +force_install_dir ${GameDir} \
  +login anonymous \
  +app_update 2394010 \
  validate \
  +quit
echo "Download Done!"

# Settings.ini Copy
# The two blank lines of md5sum are: 68b329da9893e34099c7d8ad5cb9c940
Settings_sum=$(md5sum "${GameDir}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini" | cut -d" " -f1)
if [ "68b329da9893e34099c7d8ad5cb9c940" = "${Settings_sum}" ]; then
  echo "Init Settings.ini"
  \cp -f "${GameDir}/DefaultPalWorldSettings.ini" "${GameDir}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini"
fi

# Start Pal Server
echo "Start Server..."
/home/steam/scripts/start.sh

# Update
while :; do
  # Current Version
  current_version=$($SteamCMD \
    +force_install_dir ${GameDir} \
    +login anonymous \
    +app_status 2394010 \
    +quit | awk '/BuildID/{print$8}')

  # Remove Version
  remote_version=$($SteamCMD \
    +force_install_dir ${GameDir} \
    +login anonymous \
    +app_info_print 2394010 \
    +quit | grep -A2 "public" | awk -F\" '/buildid/{print$4}')

  echo "Current Version: ${current_version}"
  echo "Remote Version : ${remote_version}"
  if [ "${current_version}" -ne "${remote_version}" ]; then
    echo "A new version is available."
    echo "Start the update."
    $SteamCMD \
      +force_install_dir ${GameDir} \
      +login anonymous \
      +app_update 2394010 \
      validate \
      +quit > /dev/null
    echo "The update is complete."
    echo "Restarting..."
    kill -SIGINT "$(cat /home/steam/palworld.pid)"
    /home/steam/scripts/start.sh
  else
    echo "There are no new versions."
    sleep 10800
  fi
done