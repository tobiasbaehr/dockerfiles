#!/usr/bin/env bash
set -o errexit
docker build --rm -t reinblau/php:5.6-alpine-apache .
