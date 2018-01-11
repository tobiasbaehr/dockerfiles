#!/usr/bin/env bash
set -o errexit
docker build --rm -t gzevd/php:5.5-alpine-apache .
