#!/usr/bin/env bash
set -o errexit
docker build --rm -t reinblau/cmd:alpine .
docker run --rm --user=dev -it reinblau/cmd:alpine /bin/zsh -l
