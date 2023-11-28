#!/bin/sh

usage() {
    echo "Usage: build.sh <directory>"
    exit 1
}

if [ "$1" = "" ]; then
    usage
fi

if ! [ -d "./${1}" ]; then
    echo "ERROR: build directory ${1} not found!"
    exit 1
fi

PROJECT=$(echo $1|tr -d "/")
DISTRO="ubuntu-20.04"

# Ubuntu 20.04 (64-bit)
podman container rm $PROJECT-$DISTRO
podman build $PROJECT/ -t $PROJECT
podman run --name $PROJECT-$DISTRO -v podman-builds:/home/ubuntu/output $PROJECT:latest
