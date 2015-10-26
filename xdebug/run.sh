#!/bin/bash
#set -x

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"
__P__="webgrind"


build_project() {
  cp "${__DIR__}/docker-php-pecl-xdebug.ini" /tmp/docker-php-pecl-xdebug.ini
  if [[ ! -d "/data/www/${__P__}" ]];then
    git clone --config core.filemode=false https://github.com/jokkedk/${__P__}.git /data/www/${__P__}/
    chown -R vagrant: /data/www/${__P__}/
  fi
}

start () {
  docker rm -f xdebug >/dev/null 2>&1
  docker run --detach --env VIRTUAL_HOST=xdebug.dd \
    --env --hostname=xdebug.dd \
    --link mysql:db --publish-all \
    --volume /data/www/:/var/www/html/ \
    --volume /tmp/docker-php-pecl-xdebug.ini:/usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini:ro \
    --name xdebug reinblau/xdebug >/dev/null
}

main () {
  build_project
  start
}

main
