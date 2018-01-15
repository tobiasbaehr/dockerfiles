#!/usr/bin/env bash
set -o errexit
docker build --rm -t gzevd/rancher-cli .

docker run -it gzevd/rancher-cli:latest sh
