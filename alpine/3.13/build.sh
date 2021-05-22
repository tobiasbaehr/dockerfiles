#!/usr/bin/env bash
set -o errexit
docker buildx build --pull --rm -t gzevd/alpine:3.13 .
docker run --rm -it --name alpine gzevd/alpine:3.13
