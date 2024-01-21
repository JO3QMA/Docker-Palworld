#!/bin/bash

# Start Pal Server
/home/steam/palworld/PalServer.sh \
  EpicApp=PalServer \
  -publicport=8211 \
  -useperfthreads \
  -NoAsyncLoadingThread \
  -UseMultithreadForDS &
echo $! > /home/steam/palworld.pid