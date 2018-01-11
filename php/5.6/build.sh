#!/usr/bin/env bash
set -o errexit
docker build --rm -t gzevd/php:5.6-alpine-apache .
