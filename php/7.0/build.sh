#!/usr/bin/env bash
set -o errexit
docker build --rm -t reinblau/php:7.0-alpine-apache .
