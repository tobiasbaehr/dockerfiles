#!/usr/bin/env bash
set -o errexit
#set -x

source /etc/apache2/envvars && /usr/sbin/apache2 -DFOREGROUND
