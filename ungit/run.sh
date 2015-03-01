#!/bin/bash

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

start () {
  docker ps | grep "reinblau/ungit" >/dev/null || docker start ungit >/dev/null 2>&1 || \
  docker run --detach --env VIRTUAL_HOST=ungit.dev --env VIRTUAL_PORT=8448 \
  --hostname ungit.dev --publish-all --user dev \
  --volume /data/www/:/var/www/ \
  --volume /data/user/.ssh/:/home/dev/.ssh/ \
  --volume /data/user/.gitconfig:/home/dev/.gitconfig \
  --workdir /var/www/ --name ungit reinblau/ungit >/dev/null
}

main () {
  start
}

main
