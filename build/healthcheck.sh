#!/bin/bash

# Check memory leak
if [ $((free --giga | grep -v total | grep -v Swap | awk '{print $2}')) -gt 16 ]; then
  exit 1
fi

exit 0
