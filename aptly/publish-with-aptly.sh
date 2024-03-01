#!/bin/sh
#
# Proof of concept script for publishing packages generated with podman-builds
# using aptly

# Unpublish existing repositories
aptly publish drop mantic filesystem:jammy:jammy
aptly publish drop mantic filesystem:mantic:mantic

# Drop existing snapshots
aptly snapshot drop default_snapshot_jammy
aptly snapshot drop default_snapshot_mantic

# Drop repositories
aptly repo drop default_repo_jammy
aptly repo drop default_repo_mantic

# (Re)publish Ubuntu 22.04 packages
aptly repo create default_repo_jammy
aptly repo add default_repo_jammy /home/ubuntu/output/ubuntu-22.04/
aptly snapshot create default_snapshot_jammy from repo default_repo_jammy
aptly publish snapshot -distribution="jammy" default_snapshot_jammy filesystem:jammy:jammy

# (Re)publish Ubuntu 23.10 packages
aptly repo create default_repo_mantic
aptly repo add default_repo_mantic /home/ubuntu/output/ubuntu-23.10/
aptly snapshot create default_snapshot_mantic from repo default_repo_mantic
aptly publish snapshot -distribution="mantic" default_snapshot_mantic filesystem:mantic:mantic
