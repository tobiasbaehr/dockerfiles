#!/usr/bin/env bash
set -o errexit
docker build --rm -t gzevd/duply .
docker run --rm -it --name duply gzevd/duply bash
