#!/bin/bash

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

start () {
  docker rm -f phpmyadmin >/dev/null 2>&1
  docker run --detach --env VIRTUAL_HOST=phpmyadmin.dev \
    --hostname phpmyadmin.dev \
    --link mysql:mysql_5_5 \
    --link mariadb_10_0:mariadb_10_0 \
    --publish-all \
    --name phpmyadmin reinblau/phpmyadmin >/dev/null
}

main () {
  rbrequire --project=mysql
  rbrequire --project=mariadb
  start
}

main
