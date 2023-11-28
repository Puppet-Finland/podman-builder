#!/bin/sh

usage() {
    echo "Usage: build.sh <directory> <distro>"
    echo
    echo "Example: build.sh cppcms ubuntu-23.10"
    echo "Supported distros: ubuntu-20.04, ubuntu-23.10"
    exit 1
}

if [ "$1" = "" ] || [ "$2" = "" ]; then
    usage
fi

if ! [ -d "./${1}" ]; then
    echo "ERROR: build directory ${1} not found!"
    exit 1
fi

PROJECT=$(echo $1|tr -d "/")
DISTRO=$2

# Check that distro is supported
echo $DISTRO|grep -E "^ubuntu-(20.04|23.10)$" > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "ERROR: unsupported distro ${DISTRO}!"
    usage
fi

# Ubuntu 20.04 (64-bit)
podman container rm $PROJECT-$DISTRO
podman build $PROJECT/ -t $PROJECT
podman run --name $PROJECT-$DISTRO -v podman-builds:/home/ubuntu/output $PROJECT:latest
