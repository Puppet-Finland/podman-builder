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
* [prometheus](https://prometheus.io/)
* [alertmanager](https://prometheus.io/)
* [node_exporter](https://prometheus.io/)
* [blackbox_exporter](https://prometheus.io/)
* [promtotwilio](https://github.com/Swatto/promtotwilio)
* [cppcms](https://github.com/artyom-beilis/cppcms)
* [aws-sdk-cpp](https://github.com/aws/aws-sdk-cpp)
* [jwt-cpp](https://github.com/Thalhammer/jwt-cpp)
* [date](https://github.com/HowardHinnant/date)
* [librdkafka](https://github.com/confluentinc/librdkafka.git)
* kafka-ic (Apache Kafka package by Instaclustr)

# Supported build platforms

Depending on the project one or more of the following operating systems may be
supported:

* Ubuntu 20.04
* Ubuntu 22.04
* Ubuntu 23.10
* Ubuntu 24.04
* Rocky Linux 9

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

# Customizing build parameters outside of Git

To customize a build's environment variables outside of Git (e.g. for CI/CD)
add a file *build-customizations.env* to the project directory next to
*build-defaults.env*. Any values found in *build-customizations.env* will be
used and preferred over the defaults.

# Debugging

To extract a Debian package contents use dpkg-deb:

    $ dpkg-deb -e <file>

To extract Debian control files, postinst scripts and all that:

    $ dpkg-deb -x <file> .

To extract an RPM package install *rpmdevtools* and then:

    $ rpmdev-extract <file>

To list files without extracting them:

    $ rpm -qp --list <file>

To list config files:

    $ rpm -qp --configfiles <file>

Then to show scripts:

    $ rpm -qp --scripts <file>

To show dependencies:

    $ rpm -qp --requires <file>

See "man rpm" for other possible queries.

# Aptly support

This repository includes support for running [aptly](https://www.aptly.info/),
the "Swiss army knife for Debian repository management". This is mainly meant
for testing purposes, though it could be used for production as well.

## GnuPG setup

You need a GnuPG keypair to use aptly. If you don't have one, create it first
on a real computer (for reliable entropy source):

    gpg --generate-key

Then export the private and public keys:

    gpg --armor --export-secret-keys your-key-fingerprint > private.asc
    gpgp --armor --export your-key-fingerprint > public.asc

Copy both files to *podman-builds/aptly*.

## Building aptly container image

To build the aptly container image:

    podman build -f Containerfile.aptly -t aptly .

## Running aptly container

To login interactively to aptly:

    podman run -h aptly -v podman-builds:/home/ubuntu/output -it localhost/aptly

## Publishing packages with aptly

Then to create a repository and publish it inside the container with the
default (test) settings:

    ./publish.sh

This will prompt you for your GnuPG passphrase.

The packages will be published to the following locations:

* Ubuntu 22.04 ("jammy")
    * /home/ubuntu/output/aptly/jammy (container)
    * $HOME/.local/share/containers/storage/volumes/podman-builds/\_data/aptly/jammy (host)
* Ubuntu 23.10 ("mantic")
    * /home/ubuntu/output/aptly/mantic (container)
    * $HOME/.local/share/containers/storage/volumes/podman-builds/\_data/aptly/mantic (host)
* Ubuntu 24.04 ("noble")
    * /home/ubuntu/output/aptly/noble (container)
    * $HOME/.local/share/containers/storage/volumes/podman-builds/\_data/aptly/noble (host)

## Publishing to S3

If you have an apt repository in an AWS S3 bucket, possibly behind a Cloudfront
distribution (see [terraform-cloudfront_bucket](https://github.com/Puppet-Finland/terraform-cloudfront_bucket)) you can add an S3 publishing endpoint to aptly.conf:

    "S3PublishEndpoints": {
      "repo.example.org": {
        "region": "eu-central-1",
        "bucket": "repo.example.org-managed",
        "endpoint": "",
        "awsAccessKeyID": "access-key-id",
        "awsSecretAccessKey": "secret-access-key",
        "prefix": "podman-builds",
        "acl": "",
        "storageClass": "",
        "encryptionMethod": "",
        "plusWorkaround": false,
        "disableMultiDel": false,
        "forceSigV2": false,
        "debug": false
      }
    },

To publish your repository directly (without creating a snapshot) do

    aptly publish repo -distribution="noble" default_repo_noble s3:repo.example.org:

To add a package:

    aptly repo add default_repo_noble /home/ubuntu/output/ubuntu-24.04/websocketpp/websocketpp_0.8.2-1_amd64.deb

To remove a package:

    aptly repo remove default_repo_noble websocketpp

To publish the updated repository after adding and/or removing packages:

    aptly publish update noble s3:repo.example.org:

If you have Cloudfront in front of your S3 bucket you will need to invalidate
the cache whenever you update the repository packages:

    aws cloudfront create-invalidation --distribution-id <distribution-id> --paths "/*"

If you skip this step the systems using your repository will exhibit strange
behavior as they're using an older cached copies of the apt repository files.
