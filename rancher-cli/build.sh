#!/usr/bin/env bash
set -o errexit
#set -x
docker build --rm -t gzevd/rancher-cli .

#docker run -it --env RANCHER_ACCESS_KEY=${RANCHER_ACCESS_KEY:-} --env RANCHER_SECRET_KEY=${RANCHER_SECRET_KEY:-} gzevd/rancher-cli:latest "$@"
