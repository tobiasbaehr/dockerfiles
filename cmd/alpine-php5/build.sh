#!/usr/bin/env bash
set -o errexit
docker build --pull --rm -t gzevd/cmd:legacy .
docker run --rm -it --name cmd --user=dev gzevd/cmd:legacy zsh -l
