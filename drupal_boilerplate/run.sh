#!/usr/bin/env bash
set -o errexit
#set -x

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

start () {
  if [[ -z ${SSHDIR} ]];then
    echo "Create the directory ${SSHDIR} in order to start this project - drupal_boilerplate." >&2
    exit 1
  fi
  cd "${__DIR__}" && crane lift
  if [[ -z ${SSHKEY} ]];then
    echo "Could not find your ssh-key in this directory ${SSHDIR}. Therefore the git repository for the project drupal_boilerplate could not be clonen." >&2
    exit 0
  fi
  if [[ ! -d "$DATADIR/www/myproject/.git" ]];then
    echo 'ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $SSHKEY $*' > ssh && chmod +x ssh
    GIT_SSH='./ssh' git clone gitolite@example.com:user/myproject.git "$DATADIR/www/myproject/"
    rm ssh
  fi
}

main () {
  rbrequire mysql
  start
}

main
