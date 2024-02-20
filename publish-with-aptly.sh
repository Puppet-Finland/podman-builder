#!/bin/sh
aptly repo create default_repo
aptly repo add default_repo /home/ubuntu/output/ubuntu-23.10/
aptly snapshot create default_snapshot from repo default_repo
aptly publish snapshot -distribution="mantic" default_snapshot filesystem:foo:mantic
aptly publish snapshot -distribution="mantic" default_snapshot filesystem:bar:mantic
