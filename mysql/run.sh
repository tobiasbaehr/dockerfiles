#!/usr/bin/env bash
set -o errexit
#set -x

TAG="reinblau/mysql"
NAME="mysql"

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

build() {
  if [ "$(docker inspect ${TAG} > /dev/null 2>&1)" ];then
    docker build -t ${TAG} --rm=true ${__DIR__}
  fi
}

start () {
  docker run -d --publish-all --name=${NAME} -v /data/log/mysql:/var/log/mysql -v /data/lib/mysql:/var/lib/mysql ${TAG}
}

restart () {
  if [ "$(docker inspect ${NAME} > /dev/null 2>&1)" ];then
    start
  else
    docker restart ${NAME}
  fi
}

main () {
  crane lift --manifest="${__DIR__}/crane.yml" 2> /dev/null || true
  #build
  #restart
}

main
