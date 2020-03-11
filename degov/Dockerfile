FROM php:7.3-cli-alpine

# Upgrade
RUN set -xe; \
  apk update \
  && apk upgrade \
  && rm -rf /var/cache/* \
  && mkdir -p /var/cache/apk
#Set timezone
RUN set -xe; \
  apk add --update --no-cache tzdata;\
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
  && echo "Europe/Berlin" > /etc/timezone; \
  apk del --no-cache tzdata

ENV TZ /etc/localtime

# Install default packages
RUN set -xe; \
  apk add --update --no-cache \
    tar \
    patch \
    coreutils \
    less \
    sed \
    bash \
    curl \
    mysql-client \
    git \
    screen \
    openssh-client \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libxml2-dev \
    exim \
    jq \
    wget \
    git-lfs \
    openjdk8-jre \
    shadow \
    rsync

RUN set -xe; \
  usermod --shell /bin/bash root

RUN set -xe; \
  apk add --no-cache --virtual .build-dependencies \
    $PHPIZE_DEPS \
  && docker-php-source extract \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd pdo_mysql soap \
  && pecl install --configureoptions=enable-apcu-debug=no apcu \
  && docker-php-ext-enable opcache apcu \
  && docker-php-source delete \
  && apk del --no-cache .build-dependencies \
  && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

COPY ./degov.ini /usr/local/etc/php/conf.d/degov.ini

RUN set -xe; \
  cd /tmp && curl -sSL https://getcomposer.org/installer > composer-setup.php \
  && echo "c5043a2d448546b322cfad449e8936348d3ef1700ba44d1eb7b683943224ddd505649b54872c7d82b3e562f98b90dd8fcb5c1c61414fbd206659727c83a198ec  composer-setup.php" | sha512sum -c - \
  && php composer-setup.php --check \
  && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer \
  && chmod +x /usr/local/bin/composer \
  && set +x \
  && printf "$(composer --ansi --version)\n\n"\
  && composer --ansi diagnose \
  && rm -rf /tmp/composer-setup.php

RUN set -xe; \
  cd /tmp \
  && touch ~/.profile \
  && wget https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh \
  && echo "b81f23c4b60dbf03d91deec2c0853fcc6f503528624648fedc3b58949f0cf87a1cffc96d5f13e0b855998e195d077a8162bff901620a857c4b9b8942ddf220f1  install.sh"  | sha512sum -c - \
  && bash install.sh \
  && rm install.sh
