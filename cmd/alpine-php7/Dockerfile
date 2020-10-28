FROM gzevd/alpine:3.8

RUN set -xe; \
  apk add --update --no-cache --virtual .persistent-deps \
  git \
  sudo \
  rsync \
  curl \
  nano \
  bzip2 \
  nodejs \
  nodejs-npm \
  zsh \
  sassc \
  ruby \
  git-lfs \
  openssh-client \
  mysql-client \
  postgresql-client \
  php7-cli \
  php7-mcrypt \
  php7-gd \
  php7-curl \
  php7-json \
  php7-phar \
  php7-openssl \
  php7-ctype \
  php7-zip \
  php7-zlib \
  php7-pdo_mysql \
  php7-dom \
  php7-xml \
  php7-iconv \
  php7-mbstring \
  php7-simplexml \
  php7-memcached \
  php7-tokenizer \
  php7-xmlwriter \
  php7-fileinfo \
  && echo "date.timezone=Europe/Berlin" >> /etc/php7/php.ini \
  && echo "memory_limit=256M" >> /etc/php7/php.ini

RUN set -xe; \
  cd /tmp && curl -sSL https://getcomposer.org/installer > composer-setup.php \
  && echo "7d13a47927d4e7e8abc9c70f62ea69c033dcb223b73a18cb5a3fda2d14d09c237966f1a3882c88764e190cc864077c3d5b944fc3c0c344b8a80b89e3794d84a2  composer-setup.php" | sha512sum -c - \
  && php composer-setup.php --check \
  && php composer-setup.php --version="1.10.16" --install-dir=/usr/local/bin/ --filename=composer \
  && rm -rf /tmp/composer-setup.php \
  && set +x \
  && printf "$(composer --version)\n\n"\
  && composer diagnose

RUN set -xe; \
  cd /tmp \
	&& curl -sSL https://github.com/drush-ops/drush/releases/download/8.4.5/drush.phar -o /usr/local/bin/drush8 \
  && chmod +x /usr/local/bin/drush8 \
  && echo "f1a5e094cc34ff23f31f987543b9ea914e8405af78946031d2a07daf7cf5b72ed2c7956ef6e4656793a9312fcfe477cfc9ba52124b2db25319be1a210ef26a2e  /usr/local/bin/drush8"  | sha512sum -c -

RUN set -xe; \
  cd /tmp \
	&& curl -sSL https://github.com/drush-ops/drush-launcher/releases/download/0.7.3/drush.phar -o /usr/local/bin/drush \
  && chmod +x /usr/local/bin/drush \
  && echo "a25bd9eb75fa60ec5d7c87feded09f3d4e2cc3b3541a8ec9fb16db2cf56c894fe99b2b91ea164b07f9f4124c6fa651b716ddd3b9854923a198cb8d822535ecfd  /usr/local/bin/drush"  | sha512sum -c -

ENV DRUSH_LAUNCHER_FALLBACK /usr/local/bin/drush8

# Setup dev user
RUN set -xe; \
  adduser dev -s /bin/zsh -D \
  && su -l dev -c "git clone --quiet --depth=1 https://github.com/zsh-users/antigen.git /home/dev/antigen" \
  && echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev \
  && chmod 0440 /etc/sudoers.d/dev

COPY .zshrc /home/dev/.zshrc

RUN set -xe; \
    chown dev: /home/dev/.zshrc \
    && su -l dev -c "source /home/dev/.zshrc" \
    && find /home/dev/ -type d -name \.git -exec rm -rf -- {} +

COPY .gemrc /etc/gemrc
RUN set -xe; \
    export CONFIGURE_OPTS="--disable-install-doc"; \
    apk add --no-cache \
    gmp \
    yaml \
    ruby-json \
    ruby-bigdecimal \
    && apk add --no-cache --virtual .build-deps \
    ruby-dev \
    build-base \
    openssl-dev \
    && gem update --clear-sources --quiet --system 2.7.9 \
    && gem update --clear-sources --quiet --force \
    && gem install --clear-sources --quiet compass jekyll jekyll-sitemap jekyll-feed\
    && gem update --clear-sources --quiet --force \
    && gem cleanup \
    && apk del --no-cache .build-deps \
    && rm -rf /tmp/* \
    && rm -rf /home/root/.gem/

RUN set -xe; \
  npm install --production --no-color --no-progress -g npm yarn gulp-cli\
  && rm -rf /root/.npm \
  && rm -rf /usr/share/man/* \
  && rm -rf /tmp/*
