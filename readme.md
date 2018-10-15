# Meemo on Docker

Lightweight Meemo 1.8.1 server with database on Docker with docker-compose.

Manage your todo list, bookmarks and data in the Markdown format with [**Meemo**](https://github.com/nebulade/meemo).

[![Docker Meemo](https://github.com/qdm12/meemo/raw/master/readme/title.png)](https://hub.docker.com/r/qmcgaw/meemo/)

Docker build:
[![Build Status](https://travis-ci.org/qdm12/meemo.svg?branch=master)](https://travis-ci.org/qdm12/meemo)
[![Docker Build Status](https://img.shields.io/docker/build/qmcgaw/cloudflare-dns-server.svg)](https://hub.docker.com/r/qmcgaw/cloudflare-dns-server)

Meemo build:
[![Build Status](https://travis-ci.org/nebulade/meemo.svg?branch=master)](https://travis-ci.org/nebulade/meemo)

[![GitHub last commit](https://img.shields.io/github/last-commit/qdm12/cloudflare-dns-server.svg)](https://github.com/qdm12/cloudflare-dns-server/commits)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/y/qdm12/cloudflare-dns-server.svg)](https://github.com/qdm12/cloudflare-dns-server/commits)
[![GitHub issues](https://img.shields.io/github/issues/qdm12/cloudflare-dns-server.svg)](https://github.com/qdm12/cloudflare-dns-server/issues)

[![Docker Pulls](https://img.shields.io/docker/pulls/qmcgaw/cloudflare-dns-server.svg)](https://hub.docker.com/r/qmcgaw/cloudflare-dns-server)
[![Docker Stars](https://img.shields.io/docker/stars/qmcgaw/cloudflare-dns-server.svg)](https://hub.docker.com/r/qmcgaw/cloudflare-dns-server)
[![Docker Automated](https://img.shields.io/docker/automated/qmcgaw/cloudflare-dns-server.svg)](https://hub.docker.com/r/qmcgaw/cloudflare-dns-server)

[![](https://images.microbadger.com/badges/image/qmcgaw/meemo.svg)](https://microbadger.com/images/qmcgaw/meemo)
[![](https://images.microbadger.com/badges/version/qmcgaw/meemo.svg)](https://microbadger.com/images/qmcgaw/meemo)

| Download size | Image size | RAM usage | CPU usage |
| --- | --- | --- | --- |
| 54.3MB | 153MB | 70MB | Very low |

It is based on:
- [Meemo](https://github.com/nebulade/meemo) and its NodeJS dependencies
- Alpine Linux 3.8
- NPM

It also depends on a MongoDB database which is launched with Docker Compose.

## Installation

[![Docker container](https://github.com/qdm12/meemo/raw/master/readme/docker.png)](https://www.docker.com/)

1. On your host machine, create the following:
    - The users file `yourpath/users.json`
    - The data directory `yourpath/data`
    - The data directory `yourpath/database`
1. Make sure you have [Docker](https://docs.docker.com/install/) installed
1. Download [**docker-compose.yml**](https://raw.githubusercontent.com/qdm12/meemo/master/docker-compose.yml) on your host
1. In *docker-compose.yml*, modify the following:
    - `yourpath/users.json` to match your real path
    - `yourpath/data` to match your real path
    - `yourpath/database` to match your real path
    - Optionally, the port mapping `3000:3000/tcp`
1. Launch the MongoDB database and Meemo container with:

    ```
    sudo docker-compose up -d
    ```
    
1. You can now access Meemo at [localhost:3000](localhost:3000) (depending on your port in docker-compose.yml)

## Configuration

For your convenience, a shell script [**commands.sh**](https://raw.githubusercontent.com/qdm12/meemo/master/commands.sh) can be executed on your host

The following options are provided:
- List users

    ```shell   
    sudo ./commands.sh ls
    ```

- Add user

    ```shell   
    sudo ./commands.sh add username password
    ```

- Edit user

    ```shell   
    sudo ./commands.sh edit username password
    ```

- Remove user

    ```shell   
    sudo ./commands.sh remove username
    ```

All the changes are saved to `yourpath/users.json`.