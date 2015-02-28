#!/bin/bash

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

start () {
  docker ps | grep "reinblau/solr3" >/dev/null || docker start solr3 >/dev/null 2>&1 || \
  docker run --detach --publish-all --name solr3 reinblau/solr3 >/dev/null
}

main () {
  start
}

main
