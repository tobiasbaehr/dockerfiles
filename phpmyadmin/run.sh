#!/usr/bin/env bash
set -o errexit

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

start () {
  cd "${__DIR__}" && crane lift
}

main () {
  rbrequire --project=mysql
  start
}

main
