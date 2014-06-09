#!/usr/bin/env bash
set -o errexit
#set -x

TAG="tobiasb/phpmyadmin"
NAME="phpmyadmin"

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

build() {
  if [ "$(docker inspect ${TAG} > /dev/null 2>&1)" ];then
    docker build -t ${TAG} --rm=true ${__DIR__}
  fi
}

start () {
  docker run -d --hostname="phpmyadmin.dev" -e VIRTUAL_HOST="phpmyadmin.dev" --publish-all --link mysql:db --name=${NAME} -v /data/log/apache2:/var/log/apache2 ${TAG}
}

restart () {
  if [ "$(docker inspect ${NAME} > /dev/null 2>&1)" ];then
    start
  else
    docker restart ${NAME}
  fi
}

main () {
  rbresolve mysql
  crane lift --manifest="${__DIR__}/crane.yml" 2> /dev/null || true
  #build
  #restart
}

main
