# podman-builder

Podman-based builder for various projects. Running this as root
is _not_ recommended.

# Prerequisites

First install podman. Then create a volume shared with containers, so
that you can get the build artefacts:

    $ podman volume create podman-builds

# Supported projects

* [azure-metrics-exporter](https://github.com/webdevops/azure-metrics-exporter.git)
* [cloudwatch-exporter](https://github.com/prometheus/cloudwatch_exporter)
* [promtotwilio](https://github.com/Swatto/promtotwilio)
* [cppcms](https://github.com/artyom-beilis/cppcms)
* [aws-sdk-cpp](https://github.com/aws/aws-sdk-cpp)
* [jwt-cpp](https://github.com/Thalhammer/jwt-cpp)
* [date](https://github.com/HowardHinnant/date)
* [librdkafka](https://github.com/confluentinc/librdkafka.git)
* kafka-ic (Apache Kafka package by Instaclustr)

# Supported build platforms

* Ubuntu 20.04
* Ubuntu 23.10

# Prerequisites for building kafka-ic

You must put the Instaclustr-provided tarball into "kafka-ic" directory named
as "kafka-ic.tar.gz" before initiating a build.

# Building

To build use

    ./build.sh <build-directory> <distro>

The suffices of the Containerfiles tell which distros are supported for each
project.

Build artefacts can be located from

    $HOME/.local/share/containers/storage/volumes/podman-builds/_data

# Aptly support

This repository includes support for running [aptly](https://www.aptly.info/),
the "Swiss army knife for Debian repository management". This is mainly meant
for testing purposes, though it could be used for production as well.

To build the aptly container image:

    podman build -f Containerfile.aptly -t aptly .

To login interactively to aptly:

    podman run -h aptly -v podman-builds:/home/ubuntu/output -it localhost/aptly

Then to create a repository and publish it inside the container with the
default (test) settings:

    ./publish.sh
