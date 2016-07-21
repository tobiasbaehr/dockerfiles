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
    tig\
    locales\
    zsh

RUN sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen &&\
    locale-gen de_DE.UTF-8 &&\
    update-locale LANG=de_DE.UTF-8

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
    php5-intl\
    php5-readline\
    php5-curl\
    php5-sqlite &&\
    echo "date.timezone=Europe/Berlin" >> /etc/php5/cli/php.ini

RUN cd /tmp && curl -sSL https://getcomposer.org/installer > composer-setup.php &&\
    echo "1a60761d857099fd58b947c9976c867174312c0d7e48a242d3807d00269dc0683738d5f2442f966443aef7797d9b02c37062b55db814a6591307e1c0a38fe1f0  composer-setup.php" | sha512sum -c - \
    && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer

RUN curl -sSL https://drupalconsole.com/installer -o /usr/local/bin/drupal && chmod +x /usr/local/bin/drupal

RUN cd /tmp && curl -sSL https://github.com/drush-ops/drush/releases/download/8.1.2/drush.phar -o drush &&\
    echo "80e346ec9fb6b13a5a7c1893a89e59f5d8456c89d54fecac64ff161fba390b719b1d3b01aef5f1c62326ba84fa72604cedc79b2339c6cc4336b6723600d49b39  drush"  | sha512sum -c - \
    && mv drush /usr/local/bin/drush &&\
    chmod +x /usr/local/bin/drush &&\
    curl -sSL http://codeception.com/codecept.phar -o /usr/local/bin/codecept &&\
    chmod +x /usr/local/bin/codecept

# Contrib drush commands
RUN mkdir -p /usr/share/drush/commands && cd /usr/share/drush/commands &&\
    drush -q dl registry_rebuild-7.x-2.x-dev site_audit grn-7.x-2.x-dev composer_generate-7.x-1.2

# PHPQA Analyzer CLI tool - https://github.com/jmolivas/phpqa
RUN cd /usr/local/src && git clone --branch update --quiet --depth=1 https://github.com/tobiasbaehr/phpqa.git &&\
    cd phpqa &&\
    rm composer.lock &&\
    rm -rf .git &&\
    composer install --no-dev --no-interaction --prefer-dist --no-ansi &&\
    ln -s /usr/local/src/phpqa/bin/phpqa /usr/local/bin/phpqa

# icdiff - https://github.com/jeffkaufman/icdiff
RUN curl -sSL https://github.com/jeffkaufman/icdiff/archive/master.zip -o /tmp/icdiff.zip &&\
    unzip -q /tmp/icdiff.zip -d /tmp/ &&\
    mv /tmp/icdiff-master/icdiff /usr/local/bin/icdiff &&\
    mv /tmp/icdiff-master/git-icdiff /usr/local/bin/git-icdiff

# Nodejs and npm packages for frontend stuff
RUN rm -rf /var/lib/apt/lists/* && curl -sSL https://deb.nodesource.com/setup_5.x | bash - &&\
  DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq nodejs &&\
  npm install --production --no-color --no-progress -g npm &&\
  npm install --production --no-color --no-progress -g grunt-cli &&\
  npm install --production --no-color --no-progress -g bower &&\
  npm install --production --no-color --no-progress -g gulp &&\
  npm install --production --no-color --no-progress -g npm-run &&\
  npm install --production --no-color --no-progress -g caniuse-cmd

# sassc
RUN cd /tmp && git clone https://github.com/sass/sassc && cd sassc &&\
    git clone https://github.com/sass/libsass &&\
    SASS_LIBSASS_PATH=/tmp/sassc/libsass make &&\
    mv /tmp/sassc/bin/sassc /usr/local/bin/sassc

RUN useradd dev -m -s /usr/bin/zsh &&\
    git clone --quiet --depth=1 https://github.com/zsh-users/antigen.git /home/dev/antigen &&\
    usermod -a -G sudo dev &&\
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev &&\
    chmod 0440 /etc/sudoers.d/dev &&\
    git clone --quiet --depth=1 https://github.com/reinblau/yadd.git /home/dev/yadd &&\
    rm -rf /home/dev/yadd/.git

ADD .zshrc /home/dev/.zshrc

RUN chown -R dev: /home/dev/ &&\
    su dev -c "source /home/dev/.zshrc" &&\
    chown -R dev: /home/dev/

RUN rm -rf /tmp/* &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /root/.npm &&\
    rm -rf /root/.gem &&\
    rm -rf /root/.drush &&\
    rm -rf /root/.composer
