FROM reinblau/debian

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

# Mysql client && PHP packages for the cli.
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq \
    mysql-common\
    mysql-client\
    php5-cli\
    php5-mysql\
    php5-mcrypt\
    php5-gd\
    php5-curl\
    nano\
    passwd\
    sudo\
    git-core\
    openssh-client\
    patch\
    less\
    rsync\
    python\
    ruby-compass &&\
    gem install bundler

# Setup Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer;

ENV DRUSH6 6.5.0

RUN wget -q https://github.com/drush-ops/drush/archive/$DRUSH6.zip -O /usr/local/src/$DRUSH6.zip &&\
  cd /usr/local/src && unzip $DRUSH6.zip &&\
  rm $DRUSH6.zip &&\
  ln -s /usr/local/src/drush-$DRUSH6/drush /usr/local/bin/drush

ENV DRUSH7 7.0.0-alpha7

RUN wget -q https://github.com/drush-ops/drush/archive/$DRUSH7.zip -O /usr/local/src/$DRUSH7.zip &&\
  cd /usr/local/src && unzip $DRUSH7.zip &&\
  rm $DRUSH7.zip &&\
  cd drush-$DRUSH7 && composer install --no-dev &&\
  ln -s /usr/local/src/drush-$DRUSH7/drush /usr/local/bin/drush7

# https://drupal.org/project/registry_rebuild
RUN mkdir -p /usr/share/drush/commands && cd /usr/share/drush/commands && drush dl registry_rebuild site_audit

# https://github.com/reinblau/yadd
RUN git clone --branch=drush https://github.com/reinblau/yadd.git /usr/share/drush/commands/yadd

# icdiff - https://github.com/jeffkaufman/icdiff

RUN wget -q https://github.com/jeffkaufman/icdiff/archive/master.zip -O /tmp/icdiff.zip &&\
    unzip /tmp/icdiff.zip -d /tmp/ &&\
    mv /tmp/icdiff-master/icdiff /usr/local/bin/icdiff &&\
    mv /tmp/icdiff-master/git-icdiff /usr/local/bin/git-icdiff

# Nodejs and npm packages for frontend stuff
RUN echo "deb http://ftp2.de.debian.org/debian wheezy-backports main" >> /etc/apt/sources.list;\
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq nodejs-legacy &&\
    curl --insecure https://www.npmjs.org/install.sh | sudo clean=no sh &&\
    npm install --silent -g grunt-cli \
        grunt-contrib-csslint \
        grunt-contrib-jshint \
        live-reload \
        grunt-contrib-sass

RUN useradd dev -m -s /bin/bash &&\
    usermod -a -G sudo dev &&\
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev &&\
    chmod 0440 /etc/sudoers.d/dev &&\
    git clone https://github.com/reinblau/yadd.git /home/dev/yadd &&\
    usermod -a -G www-data dev &&\
    rm -rf /tmp/*
