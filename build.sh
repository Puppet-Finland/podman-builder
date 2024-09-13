#!/bin/sh

usage() {
    echo "Usage: build.sh -p <project-directory> -o <operating system> [-n]"
    echo
    echo "Parameters:"
    echo "  -p: the project's build directory"
    echo "  -o: operating system to build for; Containerfile.<os> needs to be present in the project directory"
    echo "  -n: rebuild container image from scratch (passes --no-cache to podman build)"
    echo
    echo "Example:"
    echo "  build.sh -p cppcms -o ubuntu-24.04"
    echo
    exit 1
}

NO_CACHE="no"
PROJECT_DIR=""
OS=""

while getopts "p:o:n" o; do
    case "${o}" in
        p)
            PROJECT_DIR=${OPTARG}
            ;;
        o)  OS=${OPTARG}
            ;;
        n)  NO_CACHE="yes"
            ;;
        h)  usage
            ;;
        *)  usage
            ;;
    esac
done

PARAMS_DEFINED="yes"

if [ "${PROJECT_DIR}" = "" ]; then
    echo "ERROR: must pass project directory with the -p argument "
    PARAMS_DEFINED="no"
fi

if [ "${OS}" = "" ]; then
    echo "ERROR: must pass operating system version with the -o argument "
    PARAMS_DEFINED="no"
fi

if [ "${PARAMS_DEFINED}" = "no" ]; then
    exit 1
fi

if ! [ -d "${PROJECT_DIR}" ]; then
    echo "ERROR: build directory ${PROJECT_DIR} not found!"
    exit 1
fi

PROJECT=$(basename $PROJECT_DIR)

# Check that distro is supported
test -f "${PROJECT_DIR}/Containerfile.${OS}"

if [ $? -ne 0 ]; then
    echo "ERROR: unsupported operating system ${OS} for project ${PROJECT}!"
    echo
    echo "Supported distros are:"
    ls $PROJECT_DIR/Containerfile.*|cut -d "/" -f 2|cut -d "." -f 2-
    echo
    usage
fi

IMAGE="${PROJECT}-${OS}-build"
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

if [ "${NO_CACHE}" = "yes" ]; then
    EXTRA_BUILD_PARAMS="--no-cache"
fi

podman build $PROJECT_DIR/ $EXTRA_BUILD_PARAMS -f "Containerfile.${OS}" -t $IMAGE || exit 1
podman container rm $CONTAINER

# Check if the system is using selinux. If yes, we need to add the "z"
# parameter to the volume mount or writing output files will fail.
VOLUME_OPTIONS=""
getenforce > /dev/null 2>&1 && VOLUME_OPTIONS=":z"

podman run -i --name $CONTAINER --env-file=${PROJECT_DIR}/build-defaults.env $CUSTOM_ENV_FILE_PARAM -v podman-builds:/output$VOLUME_OPTIONS "localhost/$IMAGE"
