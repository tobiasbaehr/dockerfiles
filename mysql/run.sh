#!/usr/bin/env bash
set -o errexit

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

start () {
  if [ ! -d /data/mysql/ ]; then
    mkdir -p /data/mysql/
  fi
  cp "${__DIR__}/my.cnf" /data/mysql/my.cnf
  docker ps -a | grep "mysql:5.5" >/dev/null || docker start mysql >/dev/null 2>&1 || \
  docker run --detach --env MYSQL_ROOT_PASSWORD=root \
    --publish-all --sig-proxy \
    --volume /data/lib/mysql:/var/lib/mysql \
    --volume /data/mysql/my.cnf:/etc/mysql/conf.d/custom.cnf \
    --name mysql mysql:5.5 >/dev/null
}

main () {
  start
}

main
