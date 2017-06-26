#!/usr/bin/env bash
set -o errexit
docker build --rm -t reinblau/cmd:alpine .
# docker run --rm -it --name cmd --user=dev reinblau/cmd:alpine /bin/zsh -l
