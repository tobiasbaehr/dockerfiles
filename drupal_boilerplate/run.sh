#!/usr/bin/env bash
set -o errexit
#set -x

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

start () {
  # local project="drupal_boilerplate"
  # if [[ ! -d "/data/www/$project/.git" ]];then
  #   su vagrant -c "git clone --config core.filemode=false gitolite@example.com:user/$project.git /data/www/$project/"
  #   chown -R vagrant: /data/www/$project/
  # fi
  cd "${__DIR__}" && crane run
}

main () {
  rbrequire --project=mysql
  start
}

main
