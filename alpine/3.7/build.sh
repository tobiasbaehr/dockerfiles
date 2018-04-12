#!/usr/bin/env bash
set -o errexit
docker build --pull --rm -t gzevd/alpine:3.7 .
docker run --rm -it --name alpine gzevd/alpine:3.7
