#!/usr/bin/env bash
set -o errexit
docker build --rm -t gzevd/cmd .
docker run --rm -it --name cmd --user=dev gzevd/cmd zsh -l
