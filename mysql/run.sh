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
  cd "${__DIR__}" && crane lift
}

main () {
  start
}

main
