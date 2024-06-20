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

PROJECT_DIR=$1
if ! [ -d "${1}" ]; then
    echo "ERROR: build directory ${1} not found!"
    exit 1
fi

PROJECT=$(basename $1)
DISTRO=$2

# Check that distro is supported
test -f "${PROJECT_DIR}/Containerfile.${DISTRO}"

if [ $? -ne 0 ]; then
    echo "ERROR: unsupported distro ${DISTRO} for project ${PROJECT}!"
    echo
    echo "Supported distros are:"
    ls $PROJECT_DIR/Containerfile.*|cut -d "/" -f 2|cut -d "." -f 2-
    echo
    usage
fi

IMAGE="${PROJECT}-${DISTRO}-build"
CONTAINER="${IMAGE}-instance"

if [ -r "${PROJECT_DIR}/build-customizations.env" ]; then
    CUSTOM_ENV_FILE_PARAM="--env-file=${PROJECT_DIR}/build-customizations.env"
else
    CUSTOM_ENV_FILE_PARAM=""
fi

podman build $PROJECT_DIR/ -f "Containerfile.${DISTRO}" -t $IMAGE
podman container rm $CONTAINER
podman run -it --name $CONTAINER --env-file=${PROJECT_DIR}/build-defaults.env $CUSTOM_ENV_FILE_PARAM -v podman-builds:/output "localhost/$IMAGE"
