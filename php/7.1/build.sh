#!/usr/bin/env bash
set -o errexit
docker build --rm -t gzevd/php:7.1-alpine-apache .
