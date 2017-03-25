#!/usr/bin/env bash
set -x

REMOTEHOST=${1:-10.200.10.1}
echo xdebug.remote_enable=On > /usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini
echo xdebug.remote_host="$REMOTEHOST" >> /usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini
service apache2 reload
