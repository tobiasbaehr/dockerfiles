#!/usr/bin/env bash
set -o errexit
docker build --rm -t gzevd/openproject-ce .
docker run -it --rm --name=openproject-ce -v "$(pwd)"/createBackup.sh:/usr/local/bin/createBackup gzevd/openproject bash
