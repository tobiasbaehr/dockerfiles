FROM reinblau/php

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

# Mysql
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    mysql-common\
    mysql-client\
    php5-mysql\
    php5-mcrypt\
    nano \
    passwd \
    sudo

ENV COMPOSER_HOME /opt

# Setup https://github.com/drush-ops/drush
RUN composer global require drush/drush:6.3.0

RUN ln -s /opt/vendor/bin/drush /usr/bin/drush

# https://drupal.org/project/registry_rebuild
RUN mkdir -p /usr/share/drush/commands && cd /usr/share/drush/commands && drush dl registry_rebuild

# https://github.com/reinblau/yadd
RUN git clone https://github.com/reinblau/yadd.git /opt/yadd

# Nodejs and npm packages for frontend stuff
RUN echo "deb http://ftp2.de.debian.org/debian wheezy-backports main" >> /etc/apt/sources.list;\
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq nodejs-legacy &&\
    curl --insecure https://www.npmjs.org/install.sh | sudo clean=no sh &&\
    npm install --silent -g grunt-cli \
        grunt-contrib-csslint \
        grunt-contrib-jshint \
        live-reload \
        grunt-contrib-sass

# Ruby stuff
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq ruby-compass &&\
    gem install bundler

RUN useradd dev -m -s /bin/bash &&\
    usermod -a -G sudo dev &&\
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev &&\
    chmod 0440 /etc/sudoers.d/dev

RUN ln -s /opt/yadd/ /home/dev/yadd
