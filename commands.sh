#!/bin/bash

if [ $UID != 0 ]; then
  printf "Please run this script with sudo:\nsudo $0 $*\n"
  exit 1
fi
case "$1" in
  "ls")
    echo "====== List of users ======"
    sudo docker-compose exec meemo ./meemo/admin users;;
  "add")
    echo "====== Adding user ======"
    USER="$2"
    case "$USER" in
      "") echo "Usage: sudo $0 $1 username password" >&2
        exit 1;;
    esac
    PASSWORD="$3"
    echo "Adding user $USER with password $PASSWORD"
    sudo docker-compose exec meemo ./meemo/admin user-add -u $USER -p $PASSWORD --display-name $USER;;
  "edit")
    echo "====== Editing user ======"
    USER="$2"
    case "$USER" in
      "") echo "Usage: sudo $0 $1 username password" >&2
        exit 1;;
    esac
    # docker-compose exec meemo ./admin users | grep $USER
    PASSWORD="$3"
    echo "Editing user $USER with password $PASSWORD"
    sudo docker-compose exec meemo ./meemo/admin user-edit -u $USER -p $PASSWORD --display-name $USER;;
  "remove")
    echo "====== Removing user ======"
    USER="$2"
    case "$USER" in
      "") echo "Usage: sudo $0 $1 username" >&2
        exit 1;;
    esac
    sudo docker-compose exec meemo ./meemo/admin user-del -u $USER;;
  *) echo "Usage: sudo $0 ls|add|edit|remove"
esac
