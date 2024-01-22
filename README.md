# Docker-Palworld

[日本語 README](docs/README_ja.md)

This repository contains the docker related files for running a Palworld server.

## How to start the Palworld Server (using docker compose)
1. Clone this repository
1. `cd` into the cloned repository directory
1. Run `docker compose up -d`

## How to start the Palworld Server (using systemd service)
1. Clone this repository
1. `cd` into the cloned repository directory
1. Run `sudo cp palworld.service /etc/systemd/system/`
1. Run `sudo systemctl enable --now palworld.service`

## Features
* Easy to start the server
* Automatic updates for the server
* Docker health report based on memory usage (beta)
    * if you do not want use this feature, delete `healthcheck` definition in `compose.yml`
