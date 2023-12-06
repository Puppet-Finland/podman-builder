# podman-builder

Podman-based builder for various projects. Running this as root
is _not_ recommended.

# Prerequisites

First install podman. Then create a volume shared with containers, so
that you can get the build artefacts:

    $ podman volume create podman-builds

# Supported projects

* [azure-metrics-exporter](https://github.com/webdevops/azure-metrics-exporter.git)
* [promtotwilio](https://github.com/Swatto/promtotwilio)
* [cppcms](https://github.com/artyom-beilis/cppcms)
* [aws-sdk-cpp](https://github.com/aws/aws-sdk-cpp)

# Supported build platforms

* Ubuntu 20.04
* Ubuntu 23.10

# Building

To build use

    ./build.sh <build-directory> <distro>

The suffices of the Containerfiles tell which distros are supported for each
project.

Build artefacts can be located from

    $HOME/.local/share/containers/storage/volumes/podman-builds/_data
