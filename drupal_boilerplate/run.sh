#!/usr/bin/env bash
set -o errexit
#set -x

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

start () {
  # local project="drupal_boilerplate"
  # if [[ ! -d "$DATADIR/www/$project/.git" ]];then
  #   echo 'ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $SSHKEY $*' > ssh && chmod +x ssh
  #   GIT_SSH='./ssh' git clone gitolite@example.com:user/$project.git "$DATADIR/www/$project/"
  #   rm ssh
  #   cd "$DATADIR/www/$project/" && git config core.filemode false
  #   chown -R vagrant: "$DATADIR/www/$project/"
  # fi
  cd "${__DIR__}" && crane lift
}

main () {
  rbrequire --project=mysql --ssh --gitconfig
  start
}

main
