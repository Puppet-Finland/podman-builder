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

if grep "CLONE_WITH_SSH=yes" "${PROJECT_DIR}/build-defaults.env"; then
# Copy SSH files to the build context
    for p in PODMAN_BUILDER_SSH_KEY_PATH PODMAN_BUILDER_SSH_CONFIG PODMAN_BUILDER_SSH_KNOWN_HOSTS; do
        eval current_path=\"\$$p\"

        if ! [ "${current_path}" = "" ] && [ -r "${current_path}" ]; then
            cp -uv "${current_path}" "${PROJECT_DIR}/"
        else
            echo "NOTICE: environment variable ${p} not set! This is only a problem if project ${PROJECT} requires using Git over SSH!"
        fi
    done
fi

podman build $PROJECT_DIR/ -f "Containerfile.${DISTRO}" -t $IMAGE
podman container rm $CONTAINER

# Check if the system is using selinux. If yes, we need to add the "z"
# parameter to the volume mount or writing output files will fail.
VOLUME_OPTIONS=""
getenforce && VOLUME_OPTIONS=":z"

podman run -it --name $CONTAINER --env-file=${PROJECT_DIR}/build-defaults.env $CUSTOM_ENV_FILE_PARAM -v podman-builds:/output$VOLUME_OPTIONS "localhost/$IMAGE"
