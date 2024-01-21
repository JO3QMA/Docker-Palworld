#!/bin/bash

# Download Palworld Data
echo "Download Server Data..."
/home/steam/steamcmd/steamcmd.sh \
  +force_install_dir /home/steam/palworld/ \
  +login anonymous \
  +app_update 2394010 \
  validate \
  +quit
echo "Download Done!"

# Settings.ini Copy
if [ ! -s "/home/steam/palworld/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini" ]; then
  echo "Init Settings.ini"
  \cp -f /home/steam/palworld/DefaultPalWorldSettings.ini /home/steam/palworld/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
fi

# Start Pal Server
echo "Start Server..."
/home/steam/scripts/start.sh

# Current Version
current_version=$(/home/steam/steamcmd/steamcmd.sh \
  +force_install_dir /home/steam/palworld/ \
  +login anonymous \
  +app_status 2394010 \
  +quit | awk '/BuildID/{print$8}')

# Remove Version
remote_version=$(/home/steam/steamcmd/steamcmd.sh \
  +force_install_dir /home/steam/palworld/ \
  +login anonymous \
  +app_info_print 2394010 \
  +quit | grep -A2 "public" | awk -F\" '/buildid/{print$4}')

# Update
echo "Current Version: ${current_version}"
echo "Remote Version : ${remote_version}"
if [ "${current_version}" -ne "${remote_version}" ]; then
  echo "A new version is available."
  echo "Start the update."
  /home/steam/steamcmd/steamcmd.sh \
    +force_install_dir /home/steam/palworld/ \
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