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

# Supported build platforms

* Ubuntu 20.04

# Building

To build use

    ./build.sh <build-directory>

Build artefacts can be located from

    $HOME/.local/share/containers/storage/volumes/podman-builds/_data
