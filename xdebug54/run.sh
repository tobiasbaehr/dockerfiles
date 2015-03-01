#!/bin/bash
#set -x

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"
__P__="webgrind"


build_project() {
  if [ ! -f "/data/php54/conf/20-xdebug.ini" ];then
    mkdir -p /data/php54/conf/
    cp "${__DIR__}/20-xdebug.ini" /data/php54/conf/20-xdebug.ini
  fi
  if [[ ! -d "/data/www/${__P__}" ]];then
    git clone --config core.filemode=false https://github.com/jokkedk/${__P__}.git /data/www/${__P__}/
    chown -R vagrant: /data/www/${__P__}/
  fi
}

start () {
  docker rm -f xdebug54 >/dev/null 2>&1
  docker run --detach --env VIRTUAL_HOST=xdebug54.dev \
    --env APACHE_USER_UID=1000 --hostname xdebug54.dev \
    --link mysql:db --publish-all \
    --volume /data/www/:/var/www/ \
    --volume /data/php54/conf/20-xdebug.ini:/etc/php5/apache2/conf.d/20-xdebug.ini \
    --name xdebug54 reinblau/xdebug54 >/dev/null
}

main () {
  build_project
  start
}

main
