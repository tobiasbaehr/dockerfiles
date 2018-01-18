#!/usr/bin/env bash
set -o errexit

if [ ! -d /root/.duply/default ]; then
  duply default create
fi

function setup() {
  echo "${DUPLY_GPG_KEY}" > /root/pgp.asc
  gpg --import /root/pgp.asc
  #echo -e "pinentry-mode loopback\nuse-agent" > /root/.gnupg/gpg.conf

export DUPLY_GPG_ID="$(gpg --fingerprint --with-colon | grep ''^pub'' | cut -d: -f5 | cut -c 9-17)"

cat >/root/.duply/default/conf <<EOF
# GPG
GPG_KEYS_ENC='${DUPLY_GPG_ID}'
GPG_KEY_SIGN='${DUPLY_GPG_ID}'
GPG_PW='${DUPLY_GPG_PW}'
GPG_OPTS='--pinentry-mode loopback'

# Base directory to backup
SOURCE='/backup'

# Target for backup
export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
TARGET=s3://${AWS_ACCESS_KEY_ID}:${AWS_SECRET_ACCESS_KEY}@${DUPLY_S3_HOST}/${DUPLY_S3_BUCKET}/backups

VOLSIZE=100
DUPL_PARAMS="$DUPL_PARAMS --volsize $VOLSIZE "

# Backup retention
MAX_AGE=2M
MAX_FULL_BACKUPS=2
MAX_FULLS_WITH_INCRS=1
MAX_FULLBKP_AGE=1M
DUPL_PARAMS="$DUPL_PARAMS --full-if-older-than $MAX_FULLBKP_AGE "
EOF
}
case "$1" in
    'bash')
      exec bash
    ;;
    '/bin/bash')
      exec bash
    ;;
    *)
    setup
    exec duply default backup
esac
