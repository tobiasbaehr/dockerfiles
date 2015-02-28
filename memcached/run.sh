#!/bin/bash

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

start () {
  docker run --detach --publish-all --name memcached sylvainlasnier/memcached >/dev/null 2>&1
}

main () {
  start
}

main
