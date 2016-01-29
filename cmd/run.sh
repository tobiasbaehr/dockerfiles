#!/usr/bin/env bash
if [ ! -d /data/user/.nvm/ ];then
  git clone https://github.com/creationix/nvm.git /data/user/.nvm/ && cd /data/user/.nvm/ && git checkout `git describe --abbrev=0 --tags`
fi

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
--volume /data/user/.nvm/:/home/dev/.nvm/ \
-e GEM_HOME=/home/dev/.gems \
--workdir /var/www test/cmd /usr/bin/zsh -l
