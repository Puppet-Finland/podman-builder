#!/bin/sh

usage() {
    echo "Usage: build.sh <directory> <distro>"
    echo
    echo "Example: build.sh cppcms ubuntu-23.10"
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
test -f "${PROJECT}/Containerfile.${DISTRO}"

if [ $? -ne 0 ]; then
    echo "ERROR: unsupported distro ${DISTRO} for project ${PROJECT}!"
    echo
    echo "Supported distros are:"
    ls $PROJECT/Containerfile.*|cut -d "/" -f 2|cut -d "." -f 2-
    echo
    usage
fi

IMAGE="${PROJECT}-${DISTRO}-build"
CONTAINER="${IMAGE}-instance"

podman build $PROJECT/ -f "Containerfile.${DISTRO}" -t $IMAGE
podman container rm $CONTAINER
podman run -it --name $CONTAINER --env-file=${PROJECT}/build-defaults.env -v podman-builds:/output "localhost/$IMAGE"
