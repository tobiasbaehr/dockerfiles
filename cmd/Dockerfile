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
    bzip2\
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
    php5-readline\
    tig

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

RUN curl -sSL https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer;

RUN curl -sSL http://drupalconsole.com/installer | php && mv console.phar /usr/local/bin/drupal

RUN wget -q https://github.com/drush-ops/drush/releases/download/8.0.1/drush.phar -O /usr/local/bin/drush &&\
    chmod +x /usr/local/bin/drush &&\
    wget -q https://raw.githubusercontent.com/drush-ops/drush/master/drush.complete.sh -O /etc/bash_completion.d/drush &&\
    wget -q http://codeception.com/codecept.phar -O /usr/local/bin/codecept &&\
    chmod +x /usr/local/bin/codecept

# Contrib drush commands
RUN mkdir -p /usr/share/drush/commands && cd /usr/share/drush/commands &&\
    drush -q dl registry_rebuild site_audit grn drupalgeddon composer_generate

RUN cd /usr/local/src && git clone https://github.com/jmolivas/phpqa.git &&\
    cd phpqa &&\
    composer install --no-dev --no-interaction --prefer-dist &&\
    ln -s /usr/local/src/phpqa/bin/phpqa /usr/local/bin/phpqa


# icdiff - https://github.com/jeffkaufman/icdiff

RUN wget -q https://github.com/jeffkaufman/icdiff/archive/master.zip -O /tmp/icdiff.zip &&\
    unzip -q /tmp/icdiff.zip -d /tmp/ &&\
    mv /tmp/icdiff-master/icdiff /usr/local/bin/icdiff &&\
    mv /tmp/icdiff-master/git-icdiff /usr/local/bin/git-icdiff

# Nodejs and npm packages for frontend stuff
RUN rm -rf /var/lib/apt/lists/* && curl -sL https://deb.nodesource.com/setup_5.x | bash - &&\
  DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq nodejs &&\
  npm install --production -g npm &&\
  npm install --production -g grunt-cli &&\
  npm install --production -g bower &&\
  npm install --production -g gulp &&\
  npm install --production -g caniuse-cmd &&\
  npm completion > /etc/bash_completion.d/npm

RUN useradd dev -m -s /bin/bash &&\
    usermod -a -G sudo dev &&\
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev &&\
    chmod 0440 /etc/sudoers.d/dev &&\
    git clone --quiet https://github.com/reinblau/yadd.git /home/dev/yadd &&\
    rm -rf /home/dev/yadd/.git &&\
    echo 'export NVM_DIR="$HOME/.nvm"' >> /home/dev/.bashrc &&\
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm' >> /home/dev/.bashrc &&\
    echo '[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # This loads nvm bash_completion' >> /home/dev/.bashrc


RUN rm -rf /tmp/* &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /root/.npm &&\
    rm -rf /root/.gem &&\
    rm -rf /root/.drush &&\
    rm -rf /root/.composer
