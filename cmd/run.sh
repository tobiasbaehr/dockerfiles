#!/usr/bin/env bash

docker run --hostname cmd.dev \
--interactive --link mysql:db --link mariadb_10_0:mariadb_10_0 \
--rm --tty --user dev \
--volume /data/www/:/var/www/ \
--volume /data/user/.ssh/:/home/dev/.ssh/ \
--volume /data/user/.gitconfig:/home/dev/.gitconfig \
--volume /data/user/yaddprojects:/home/dev/yaddprojects/ \
--volume /data/user/.drush/:/home/dev/.drush/ \
--volume /data/user/.gems/:/home/dev/.gems/ \
--volume /data/user/.composer/:/home/dev/.composer/ \
-e GEM_HOME=/home/dev/.gems \
--workdir /var/www reinblau/cmd
