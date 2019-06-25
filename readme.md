# Meemo on Docker

*Lightweight Meemo 1.9.2 server with database on Docker with docker-compose*

Manage your todo list, bookmarks and data in the Markdown format with [**Meemo**](https://github.com/nebulade/meemo)

[![Docker Meemo](https://github.com/qdm12/meemo/raw/master/title.png)](https://hub.docker.com/r/qmcgaw/meemo/)

Docker build:
[![Docker Build Status](https://img.shields.io/docker/build/qmcgaw/meemo.svg)](https://hub.docker.com/r/qmcgaw/meemo)

Meemo build (external):
[![Build Status](https://travis-ci.org/nebulade/meemo.svg?branch=master)](https://travis-ci.org/nebulade/meemo)

[![GitHub last commit](https://img.shields.io/github/last-commit/qdm12/meemo.svg)](https://github.com/qdm12/meemo/commits)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/y/qdm12/meemo.svg)](https://github.com/qdm12/meemo/commits)
[![GitHub issues](https://img.shields.io/github/issues/qdm12/meemo.svg)](https://github.com/qdm12/meemo/issues)

[![Docker Pulls](https://img.shields.io/docker/pulls/qmcgaw/meemo.svg)](https://hub.docker.com/r/qmcgaw/meemo)
[![Docker Stars](https://img.shields.io/docker/stars/qmcgaw/meemo.svg)](https://hub.docker.com/r/qmcgaw/meemo)
[![Docker Automated](https://img.shields.io/docker/automated/qmcgaw/meemo.svg)](https://hub.docker.com/r/qmcgaw/meemo)

[![Image size](https://images.microbadger.com/badges/image/qmcgaw/meemo.svg)](https://microbadger.com/images/qmcgaw/meemo)
[![Image version](https://images.microbadger.com/badges/version/qmcgaw/meemo.svg)](https://microbadger.com/images/qmcgaw/meemo)

[![Donate PayPal](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://paypal.me/qdm12)

| Image size | RAM usage | CPU usage |
| --- | --- | --- |
| 101MB | 70MB | Low |

It is based on:

- [Meemo](https://github.com/nebulade/meemo) and its NodeJS dependencies
- [Alpine 3.9](https://alpinelinux.org)
- [NodeJS](https://pkgs.alpinelinux.org/package/v3.9/main/x86_64/nodejs)

It also depends on a MongoDB database which is launched with Docker Compose.

## Setup

1. Ensure [Docker](https://docs.docker.com/install) and [Docker-Compose](https://docs.docker.com/compose/install) are installed
1. On your host machine, create the following files and directories

    ```sh
    # users file
    touch users.json
    # data and database directory
    mkdir data database
    # set ownership to map container user ID 1000
    chown 1000 users.json data database
    # set permissions
    chmod 400 mkdir
    chmod 700 data database
    ```

1. <details><summary>CLICK IF YOU HAVE AN ARM DEVICE</summary><p>

    - If you have a ARM 32 bit v6 architecture

        ```sh
        docker build -t qmcgaw/meemo \
        --build-arg BASE_IMAGE=arm32v6/alpine \
        https://github.com/qdm12/meemo.git
        ```

    - If you have a ARM 32 bit v7 architecture

        ```sh
        docker build -t qmcgaw/meemo \
        --build-arg BASE_IMAGE=arm32v7/alpine \
        https://github.com/qdm12/meemo.git
        ```

    - If you have a ARM 64 bit v8 architecture

        ```sh
        docker build -t qmcgaw/meemo \
        --build-arg BASE_IMAGE=arm64v8/alpine \
        https://github.com/qdm12/meemo.git
        ```

    </p></details>

1. Download [**docker-compose.yml**](https://raw.githubusercontent.com/qdm12/meemo/master/docker-compose.yml) on your host, modify it as you wish:

    ```sh
    wget https://raw.githubusercontent.com/qdm12/meemo/master/docker-compose.yml
    vi docker-compose.yml
    # For ARM, you might change the mongo image to an ARM mongo image
    ```

1. Launch the MongoDB database and Meemo container with

    ```sh
    docker-compose up -d
    ```

1. You can check logs with

    ```sh
    docker-compose logs -f
    ```

1. Meemo is at [localhost:3000](localhost:3000) (depending on your mapped port in docker-compose.yml)

## Configuration

Provided your Meemo container is still named `meemo`, the shell script [**commands.sh**](https://raw.githubusercontent.com/qdm12/meemo/master/commands.sh) can be executed on your host.

The following options are provided:

- List users

    ```sh
    ./commands.sh ls
    ```

- Add user

    ```sh
    ./commands.sh add username password
    ```

- Edit user

    ```sh
    ./commands.sh edit username password
    ```

- Remove user

    ```sh
    ./commands.sh remove username
    ```

All the changes are saved to `users.json`

## Environment variables

| Environment variable | Default | Description |
| --- | --- | --- |
| `PORT` | `3000` | TCP port to listen on internally (should not be changed) |
| `BIND_ADDRESS` | `0.0.0.0` (all) | Address to listen on internally (should not be changed) |
| `APP_ORIGIN` | `http://localhost` | Used to share tasks etc. |
| `MONGODB_URL` | `mongodb://mongodb:27017/meemo` | Location of the Mongo database (should not be changed) |
| `ATTACHMENT_DIR` | `/data` | Attachment storage directory (should not be changed) |
| `LOCAL_AUTH_FILE` | `/users.conf` | Users configuration file location (should not be changed) |
| `NODE_ENV` | `production` | Should not be changed |

## TODOs

- [ ] Mail environment variables & test
- [ ] LDAP environment variables & test
- [ ] Build binary meemo + Scratch container

## License

This repository is under an [MIT license](https://github.com/qdm12/meemo/master/LICENSE)
