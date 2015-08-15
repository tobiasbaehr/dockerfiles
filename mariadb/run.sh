#!/bin/bash

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

start () {
  if [ ! -d /data/mariadb/ ]; then
    mkdir -p /data/mariadb/10.0/data/
  fi
  cd $__DIR__ && crane run
}

main () {
  start
}

main
