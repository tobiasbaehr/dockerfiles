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
    vim\
    tig\
    locales\
    zsh &&\
    optipng &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /var/log/* &&\
    rm -rf /var/cache/* &&\
    rm -rf /tmp/*

# locale stuff
RUN sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen &&\
  locale-gen de_DE.UTF-8 &&\
  update-locale LANG=de_DE.UTF-8 &&\
  echo "Europe/Berlin" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata &&\
  echo 'alias ll="ls -lah --color=auto"' >> /etc/bash.bashrc

# Ruby gems
RUN gem update --quiet --no-document --system &&\
    gem update --quiet --no-document &&\
    gem install --quiet --no-document compass &&\
    gem install --quiet --no-document bundler &&\
    gem install --quiet --no-document singularitygs &&\
    gem install --quiet --no-document fontcustom &&\
    rm -rf /root/.gem

# mkdocs
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq\
    python-pip &&\
    pip install -q mkdocs &&\
    apt-get purge python-pip -yqq &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /var/log/* &&\
    rm -rf /var/cache/* &&\
    rm -rf /tmp/*

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq\
    fontforge\
    zlib1g-dev &&\
    wget http://people.mozilla.com/~jkew/woff/woff-code-latest.zip &&\
    echo "3a2d5c0f495f8dda2b311d80b6a1e4ad5b98fd098cc5573e92e5e7193d0f0746f8e3e90f7b1dddbaad8c336a68874a32c028ac650c067cfb2cce2f540411e2f9  woff-code-latest.zip" | sha512sum -c - \
    && unzip woff-code-latest.zip -d sfnt2woff &&\
    cd sfnt2woff &&\
    make &&\
    mv sfnt2woff /usr/local/bin/ &&\
    cd / && rm woff-code-latest.zip &&\
    rm -rf sfnt2woff &&\
    apt-get purge zlib1g-dev -yqq &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /var/log/* &&\
    rm -rf /var/cache/* &&\
    rm -rf /tmp/*

# Mysql client && PHP packages for the cli.
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq \
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
    echo "date.timezone=Europe/Berlin" >> /etc/php5/cli/php.ini &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /var/log/* &&\
    rm -rf /var/cache/* &&\
    rm -rf /tmp/*

RUN cd /tmp && curl -sSL https://getcomposer.org/installer > composer-setup.php &&\
    echo "1a60761d857099fd58b947c9976c867174312c0d7e48a242d3807d00269dc0683738d5f2442f966443aef7797d9b02c37062b55db814a6591307e1c0a38fe1f0  composer-setup.php" | sha512sum -c - \
    && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer &&\
    rm -rf /root/.composer/ &&\
    rm -rf /tmp/*

RUN curl -sSL https://drupalconsole.com/installer -o /usr/local/bin/drupal && chmod +x /usr/local/bin/drupal

RUN cd /tmp && curl -sSL https://github.com/drush-ops/drush/releases/download/8.1.5/drush.phar -o /usr/local/bin/drush &&\
    chmod +x /usr/local/bin/drush &&\
    echo "779370cb1c50861af84b1e4d49ae4b3168fa7a11f2151fb93c4c72e32fd2dbec72ff94890e20bf799dfabb66ebe548829a3858360b1564f00adfde9f4a1cbf00  /usr/local/bin/drush"  | sha512sum -c -

# Contrib drush commands
RUN mkdir -p /usr/share/drush/commands && cd /usr/share/drush/commands &&\
    drush -q dl registry_rebuild-7.x-2.x-dev site_audit grn-7.x-2.x-dev composer_generate-7.x-1.2 &&\
    rm -rf /root/.drush

# PHPQA Analyzer CLI tool - https://github.com/tobiasbaehr/phpqa.git (https://github.com/jmolivas/phpqa)
RUN cd /usr/local/src && git clone --branch update --quiet --depth=1 https://github.com/tobiasbaehr/phpqa.git &&\
    cd phpqa &&\
    rm composer.lock &&\
    rm -rf .git &&\
    composer install --no-dev --no-interaction --prefer-dist --no-ansi &&\
    ln -s /usr/local/src/phpqa/bin/phpqa /usr/local/bin/phpqa &&\
    rm -rf /root/.composer/

# icdiff - https://github.com/jeffkaufman/icdiff
RUN curl -sSL https://github.com/jeffkaufman/icdiff/archive/master.zip -o /tmp/icdiff.zip &&\
    unzip -q /tmp/icdiff.zip -d /tmp/ &&\
    mv /tmp/icdiff-master/icdiff /usr/local/bin/icdiff &&\
    mv /tmp/icdiff-master/git-icdiff /usr/local/bin/git-icdiff &&\
    rm -rf /tmp/*

# Nodejs and npm packages for frontend stuff
RUN curl -sSL https://deb.nodesource.com/setup_4.x | bash - &&\
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq nodejs &&\
    npm install --production --no-color --no-progress -g npm &&\
    npm install --production --no-color --no-progress -g grunt-cli bower gulp npm-run caniuse-cmd &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /var/log/* &&\
    rm -rf /var/cache/* &&\
    rm -rf /tmp/* &&\
    rm -rf /root/.npm

# sassc
RUN cd /tmp && git clone https://github.com/sass/sassc && cd sassc &&\
    git clone https://github.com/sass/libsass &&\
    SASS_LIBSASS_PATH=/tmp/sassc/libsass make -s &&\
    mv /tmp/sassc/bin/sassc /usr/local/bin/sassc &&\
    rm -rf /tmp/*

#Setup dev user
RUN useradd dev -m -s /usr/bin/zsh &&\
    su dev -c "git clone --quiet --depth=1 https://github.com/zsh-users/antigen.git /home/dev/antigen" &&\
    usermod -a -G sudo dev &&\
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev &&\
    chmod 0440 /etc/sudoers.d/dev

COPY .zshrc /home/dev/.zshrc

RUN su dev -c "source /home/dev/.zshrc" &&\
    find /home/dev/ -type d -name \.git -exec rm -rf -- {} +
