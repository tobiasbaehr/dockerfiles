FROM debian:jessie

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq\
    gcc\
    g++\
    make\
    pkg-config\
    ruby-dev\
    ruby\
    unzip\
    wget\
    curl\
    nano\
    passwd\
    sudo\
    git-core\
    openssh-client\
    patch\
    less\
    rsync\
    python\
    bash-completion\
    python-pip\
    vim\
    php5-readline

RUN gem update --quiet --no-document --system &&\
    gem update --quiet --no-document &&\
    gem install --quiet --no-document compass &&\
    gem install --quiet --no-document bundler &&\
    gem install --quiet --no-document singularitygs &&\
    echo "Europe/Berlin" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata &&\
    echo 'alias ll="ls -lah --color=auto"' >> /etc/bash.bashrc &&\
    pip install -q mkdocs

# Mysql client && PHP packages for the cli.
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq \
    mysql-common\
    mysql-client\
    php5-cli\
    php5-mysql\
    php5-mcrypt\
    php5-gd\
    php5-curl

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer;

RUN curl -LSs http://drupalconsole.com/installer | php && mv console.phar /usr/local/bin/drupal

ENV DRUSH6 6.6.0

RUN wget -q https://github.com/drush-ops/drush/archive/$DRUSH6.zip -O /tmp/$DRUSH6.zip &&\
  unzip -q /tmp/$DRUSH6.zip -d /usr/local/src &&\
  rm /tmp/$DRUSH6.zip &&\
  ln -s /usr/local/src/drush-$DRUSH6/drush /usr/local/bin/drush

ENV DRUSH7 7.0.0

RUN wget -q https://github.com/drush-ops/drush/archive/$DRUSH7.zip -O /tmp/$DRUSH7.zip &&\
  unzip -q /tmp/$DRUSH7.zip -d /usr/local/src &&\
  rm /tmp/$DRUSH7.zip &&\
  cd /usr/local/src/drush-$DRUSH7 && composer install --quiet --no-dev &&\
  ln -s /usr/local/src/drush-$DRUSH7/drush /usr/local/bin/drush7

ENV DRUSH8 8.0.0-beta14

RUN wget -q https://github.com/drush-ops/drush/archive/$DRUSH8.zip -O /tmp/$DRUSH8.zip &&\
  unzip -q /tmp/$DRUSH8.zip -d /usr/local/src &&\
  rm /tmp/$DRUSH8.zip &&\
  cd /usr/local/src/drush-$DRUSH8 && composer install --quiet --no-dev &&\
  ln -s /usr/local/src/drush-$DRUSH8/drush /usr/local/bin/drush8 &&\
  cp /usr/local/src/drush-$DRUSH8/drush.complete.sh /etc/bash_completion.d/drush.complete.sh

# Contrib drush commands
RUN mkdir -p /usr/share/drush/commands && cd /usr/share/drush/commands &&\
    drush -q dl registry_rebuild site_audit grn drupalgeddon

# icdiff - https://github.com/jeffkaufman/icdiff

RUN wget -q https://github.com/jeffkaufman/icdiff/archive/master.zip -O /tmp/icdiff.zip &&\
    unzip -q /tmp/icdiff.zip -d /tmp/ &&\
    mv /tmp/icdiff-master/icdiff /usr/local/bin/icdiff &&\
    mv /tmp/icdiff-master/git-icdiff /usr/local/bin/git-icdiff

# Nodejs and npm packages for frontend stuff
RUN rm -rf /var/lib/apt/lists/* && curl -sSL https://deb.nodesource.com/setup | bash - &&\
  DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq nodejs &&\
  npm install --production -g npm &&\
  npm install --production -g grunt-cli &&\
  npm install --production -g bower &&\
  npm install --production -g gulp &&\
  npm completion > /etc/bash_completion.d/npm

RUN useradd dev -m -s /bin/bash &&\
    usermod -a -G sudo dev &&\
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev &&\
    chmod 0440 /etc/sudoers.d/dev &&\
    git clone --quiet https://github.com/reinblau/yadd.git /home/dev/yadd &&\
    rm -rf /home/dev/yadd/.git

RUN DEBIAN_FRONTEND=noninteractive apt-get purge -yqq\
    gcc\
    g++\
    make\
    pkg-config\
    ruby-dev &&\
    apt-get autoremove -yqq &&\
    rm -rf /tmp/* &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /root/.npm &&\
    rm -rf /root/.gem &&\
    rm -rf /root/.drush &&\
    rm -rf /root/.composer
