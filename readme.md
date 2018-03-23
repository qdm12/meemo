# Meemo on Docker

Runs a lightweight Meemo server with database on Docker with docker-compose.

Manage your todo list, bookmarks and data in the Markdown format with [**Meemo**](https://github.com/nebulade/meemo).

[![Docker Meemo](https://github.com/qdm12/meemo/raw/master/readme/title.png)](https://hub.docker.com/r/qmcgaw/meemo/)

Docker build:
[![Build Status](https://travis-ci.org/qdm12/meemo.svg?branch=master)](https://travis-ci.org/qdm12/meemo)

Meemo build:
[![Build Status](https://travis-ci.org/nebulade/meemo.svg?branch=master)](https://travis-ci.org/nebulade/meemo)

This image is **172 MB** and consumes **58 MB** of RAM (and 87MB for MongoDB)

It is based on:
- Alpine Linux
- NodeJS
- [Meemo]((https://github.com/nebulade/meemo)) and its NodeJS dependencies

It also depends on a MongoDB database which is launched with Docker Compose.

## Installation

[![Docker container](https://github.com/qdm12/meemo/raw/master/readme/docker.png)](https://www.docker.com/)

1. On your host machine, create the following:
    - The users file `yourpath/users.json`
    - The data directory `yourpath/data`
    - The data directory `yourpath/database`
1. Make sure you have [Docker](https://docs.docker.com/install/) installed
1. Download [**docker-compose.yml**](https://github.com/qdm12/meemo/blob/master/docker-compose.yml) on your host
1. Modify the following:
    - `yourpath/users.json` to match your real path
    - `yourpath/data` to match your real path
    - `yourpath/database` to match your real path
    - The port mapping if you want `3000:3000`
1. Launch the MongoDB database and Meemo container with:

    ```
    sudo docker-compose up -d
    ```
    
1. You can now access Meemo at [localhost:3000](localhost:3000)

## Configuration

For your convenience, a shell script [**commands.sh**](https://github.com/qdm12/meemo/blob/master/commands.sh) can be executed on your host

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