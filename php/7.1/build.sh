#!/usr/bin/env bash
set -o errexit
docker build --rm -t gzevd/php:7.1-alpine-apache .
docker run --rm -it --name php-7.1-alpine-apache gzevd/php:7.1-alpine-apache sh -l