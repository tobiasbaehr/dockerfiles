FROM debian:jessie-slim

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq\
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
    tig\
    locales\
    zsh\
    ca-certificates\
    apt-transport-https\
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
  echo 'alias ll="ls -lah --color=auto"' >> /etc/bash.bashrc &&\
  echo 'precedence ::ffff:0:0/96 100' >> /etc/gai.conf

RUN set -xe \
    && buildDeps=" \
      fontforge\
      zlib1g-dev \
      make \
      gcc \
      " \
    && apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq $buildDeps \
    && wget https://people.mozilla.com/~jkew/woff/woff-code-latest.zip \
    && echo "3a2d5c0f495f8dda2b311d80b6a1e4ad5b98fd098cc5573e92e5e7193d0f0746f8e3e90f7b1dddbaad8c336a68874a32c028ac650c067cfb2cce2f540411e2f9  woff-code-latest.zip" | sha512sum -c - \
    && unzip woff-code-latest.zip -d sfnt2woff \
    && cd sfnt2woff \
    && make \
    && mv sfnt2woff /usr/local/bin/ \
    && cd / && rm woff-code-latest.zip \
    && rm -rf sfnt2woff \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/log/* \
    && rm -rf /var/cache/* \
    && rm -rf /tmp/*

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
    echo "e56b2c87bd9dc948f8464df64080d271f5bc63d84a5febf06a68e648c56d5daddbd05e68e5559cac64e14cc0736f28d480ded563d809e4a2796d19bc4f1ba28d  composer-setup.php" | sha512sum -c - \
    && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer &&\
    rm -rf /root/.composer/ &&\
    rm -rf /tmp/*

RUN curl -sSL https://drupalconsole.com/installer -o /usr/local/bin/drupal && chmod +x /usr/local/bin/drupal

RUN cd /tmp && curl -sSL https://github.com/drush-ops/drush/releases/download/8.1.12/drush.phar -o /usr/local/bin/drush &&\
    chmod +x /usr/local/bin/drush &&\
    echo "d282af8064d40119c1fbb93796ad4ae7aaeab0f4cbf420759a7fab0a50a847eb1880c86ce63e9863bafcb63fddd134ee4d7ae3bf4ed557dd0f06dfcedb76632b  /usr/local/bin/drush"  | sha512sum -c -

# Contrib drush commands
RUN mkdir -p /usr/share/drush/commands && cd /usr/share/drush/commands &&\
    drush -q dl registry_rebuild-7.x-2.x-dev site_audit grn-7.x-2.x-dev composer_generate-7.x-1.2 &&\
    rm -rf /root/.drush

# Nodejs and npm packages for frontend stuff
RUN curl -sSL https://deb.nodesource.com/setup_4.x | bash - &&\
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq nodejs &&\
    npm install --production --no-color --no-progress -g npm &&\
    npm install --production --no-color --no-progress -g grunt-cli bower gulp npm-run caniuse-cmd yarn &&\
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false lsb-release &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /var/log/* &&\
    rm -rf /var/cache/* &&\
    rm -rf /tmp/* &&\
    rm -rf /root/.npm

# sassc
RUN set -xe \
    && buildDeps=" \
      make \
      g++ \
    " \
    && apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq $buildDeps \
    && cd /tmp && git clone https://github.com/sass/sassc && cd sassc \
    && git clone https://github.com/sass/libsass \
    && SASS_LIBSASS_PATH=/tmp/sassc/libsass make -s \
    && mv /tmp/sassc/bin/sassc /usr/local/bin/sassc \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/log/* \
    && rm -rf /var/cache/* \
    && rm -rf /tmp/*

#Setup dev user
RUN useradd dev -m -s /usr/bin/zsh &&\
    su dev -c "git clone --quiet --depth=1 https://github.com/zsh-users/antigen.git /home/dev/antigen" &&\
    usermod -a -G sudo dev &&\
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev &&\
    chmod 0440 /etc/sudoers.d/dev

COPY .zshrc /home/dev/.zshrc

RUN su dev -c "source /home/dev/.zshrc" &&\
    find /home/dev/ -type d -name \.git -exec rm -rf -- {} +

RUN set -xe \
    && buildDeps=" \
      ruby-dev\
      ruby-build\
      libssl-dev \
    " \
    && apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq $buildDeps \
    && su -l dev -c "git clone https://github.com/rbenv/rbenv.git .rbenv" \
    && su -l dev -c "mkdir -p .rbenv/plugins/" \
    && su -l dev -c "git clone https://github.com/rbenv/ruby-build.git .rbenv/plugins/ruby-build"\
    && su -l dev -c ".rbenv/bin/rbenv install 2.4.0" \
    && su -l dev -c ".rbenv/bin/rbenv global 2.4.0" \
    && su -l dev -c ".rbenv/shims/gem update --quiet --no-document" \
    && su -l dev -c ".rbenv/shims/gem install --quiet --no-document compass" \
    && su -l dev -c ".rbenv/shims/gem install --quiet --no-document fontcustom" \
    && su -l dev -c ".rbenv/shims/gem install --quiet --no-document jekyll" \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/log/* \
    && rm -rf /var/cache/* \
    && rm -rf /home/dev/.gem \
    && rm -rf /tmp/*

USER dev
