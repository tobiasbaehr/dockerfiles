#!/usr/bin/env bash
#set -o errexit
#set -x

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

start () {
  cd "${__DIR__}" && crane lift
}

update () {
 echo "TODO"
}

main () {
  rbrequire mysql
  start
}

main
