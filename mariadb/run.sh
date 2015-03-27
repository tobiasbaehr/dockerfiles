#!/bin/bash

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

start () {
  if [ ! -d /data/mariadb/ ]; then
    mkdir -p /data/mariadb/10.0/data/
  fi
  docker ps | grep "mariadb:10.0" >/dev/null || docker start mariadb_10_0 >/dev/null 2>&1 || \
  docker run --detach --env MYSQL_ROOT_PASSWORD=root \
    --publish-all \
    --volume /data/mariadb/10.0/data/:/var/lib/mysql \
    --name mariadb_10_0 mariadb:10.0 >/dev/null
}

main () {
  start
}

main
