#!/bin/sh
#
# Proof of concept script for publishing packages generated with podman-builds
# using aptly

# Publish Ubuntu 22.04 packages
aptly repo create default_repo_jammy
aptly repo add default_repo_jammy /home/ubuntu/output/ubuntu-22.04/
aptly snapshot create default_snapshot_jammy from repo default_repo_jammy
aptly publish snapshot -distribution="jammy" default_snapshot_jammy filesystem:jammy:jammy

# Publish Ubuntu 23.10 packages
aptly repo create default_repo_mantic
aptly repo add default_repo_mantic /home/ubuntu/output/ubuntu-23.10/
aptly snapshot create default_snapshot_mantic from repo default_repo_mantic
aptly publish snapshot -distribution="mantic" default_snapshot_mantic filesystem:mantic:mantic
