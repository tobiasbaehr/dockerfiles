#!/usr/bin/env bash
set -o errexit
docker buildx build --rm -t gzevd/cmd .
docker run --rm -it --name cmd gzevd/cmd bash -l
