#!/usr/bin/env bash
set -o errexit
#set -x

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

start () {
  # local project="drupal_boilerplate"
  # if [[ ! -d "$DATADIR/www/$project/.git" ]];then
  #   su vagrant -c "git clone --config core.filemode=false gitolite@example.com:user/$project.git $DATADIR/www/$project/"
  #   chown -R vagrant: $DATADIR/www/$project/
  # fi
  cd "${__DIR__}" && crane lift
}

main () {
  rbrequire --project=mysql
  start
}

main
