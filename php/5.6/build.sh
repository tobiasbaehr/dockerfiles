#!/usr/bin/env bash
set -o errexit
docker build --rm -t gzevd/php:5.6-alpine-apache .
docker run --rm -it --name php-5.6-alpine-apache gzevd/php:5.6-alpine-apache sh -l
