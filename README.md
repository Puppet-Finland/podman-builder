# podman-builder

Podman-based builder for various projects. Running this as root
is _not_ recommended.

# Prerequisites

First install podman. Then create a volume shared with containers, so
that you can get the build artefacts:

    $ podman volume create podman-builds

# Building

To build use

    ./build-all.sh

Build artefacts can be located from

    $HOME/.local/share/containers/storage/volumes/podman-builds/_data
