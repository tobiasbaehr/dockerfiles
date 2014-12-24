#!/usr/bin/env bash
#set -o errexit
#set -x
set -o nounset

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

if [ "$(docker images | grep sylvainlasnier/memcached)" ];then
  docker pull sylvainlasnier/memcached
fi

if [ "$(docker images | grep reinblau/solr3)" ];then
  docker pull reinblau/solr3
fi
