#!/usr/bin/env bash
set -o errexit

cd /usr/src/app
RAILS_ENV=production bundle exec rake backup:database:create[/backup/db/db.backup]

for Currentfile in {Gemfile.local,Gemfile.plugins,config/database.yml,config/configuration.yml,config/settings.yml}; do
    if [ -f $Currentfile ];then
      cp $Currentfile /backup/config/
    fi
done

cp -pR /var/db/openproject/files /backup
