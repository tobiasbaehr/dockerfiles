FROM gzevd/alpine:3.13

RUN apk add --update --no-cache --virtual .persistent-deps \
  git \
  sudo \
  rsync \
  curl \
  nano \
  bzip2 \
  nodejs \
  nodejs-npm \
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

WORKDIR /tmp

RUN curl --silent --show-error https://getcomposer.org/installer --output composer-setup.php \
  && echo "3137ad86bd990524ba1dedc2038309dfa6b63790d3ca52c28afea65dcc2eaead16fb33e9a72fd2a7a8240afaf26e065939a2d472f3b0eeaa575d1e8648f9bf19  composer-setup.php" | sha512sum -c - \
  && php composer-setup.php --check \
  && php composer-setup.php --1 --install-dir=/usr/local/bin/ --filename=composer \
  && chmod +x /usr/local/bin/composer \
  && set +x \
  && printf "%s\n\n" "$(composer --ansi --version)" \
  && composer --ansi diagnose \
  && rm -rf composer-setup.php

RUN curl --silent --show-error --location https://github.com/drush-ops/drush/releases/download/8.4.8/drush.phar --output /usr/local/bin/drush8 \
  && chmod +x /usr/local/bin/drush8 \
  && echo "5a2c1cf587a3f57e50b553a4cc2e0e846e7bf0c20f705017295b77755b408da077e038bb67fd1abc3f5484eb49d8ca21bbecba6b1b8032ee582ecd3be8594d2d  /usr/local/bin/drush8"  | sha512sum -c -

RUN curl --silent --show-error --location https://github.com/drush-ops/drush-launcher/releases/download/0.9.0/drush.phar --output /usr/local/bin/drush \
  && chmod +x /usr/local/bin/drush \
  && echo "abc7138f6c86d2d9f157a6507889819ccc422ec053daaabe9778e48d58ea8a3d185353388b995ac5e81856578a5f52a2d8ea625693c8bf255c9bd1b94ee550bc  /usr/local/bin/drush"  | sha512sum -c -

ENV DRUSH_LAUNCHER_FALLBACK /usr/local/bin/drush8

# Setup dev user
RUN adduser dev -s /bin/bash -D \
  && echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev \
  && chmod 0440 /etc/sudoers.d/dev

COPY .gemrc /etc/gemrc
RUN apk add --no-cache \
    gmp \
    yaml \
    ruby-json \
    ruby-bigdecimal \
    && apk add --no-cache --virtual .build-deps \
    ruby-dev \
    build-base \
    openssl-dev \
    && gem update --clear-sources --quiet --system \
    && gem update --clear-sources --quiet --force \
    && gem install --clear-sources --quiet compass jekyll jekyll-sitemap jekyll-feed\
    && gem update --clear-sources --quiet --force \
    && gem cleanup \
    && apk del --no-cache .build-deps \
    && rm -rf /tmp/* \
    && rm -rf /home/root/.gem/

RUN npm install --production --no-color --no-progress -g gulp-cli\
  && rm -rf /root/.npm \
  && rm -rf /usr/share/man/* \
  && rm -rf /tmp/*
