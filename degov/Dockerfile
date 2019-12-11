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
    exim \
    jq \
    wget \
    html2text \
    git-lfs \
    openjdk8-jre

RUN set -xe; \
  apk add --no-cache --virtual .build-dependencies \
    $PHPIZE_DEPS \
  && docker-php-source extract \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd pdo_mysql \
  && pecl install apcu \
  && docker-php-ext-enable opcache apcu \
  && docker-php-source delete \
  && apk del --no-cache .build-dependencies \
  && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

COPY ./degov.ini /usr/local/etc/php/conf.d/degov.ini

RUN set -xe; \
  cd /tmp && curl -sSL https://getcomposer.org/installer > composer-setup.php \
  && echo "7aa79073bc48a1d215730ba5b0866424d4c0942a83946c10609c1225f328585f4b3f0e0e1e84de37c691ab74abccc0b6b1f0bf2f051e3eab66b8dfd67f2f4201  composer-setup.php" | sha512sum -c - \
  && php composer-setup.php --check \
  && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer \
  && chmod +x /usr/local/bin/composer \
  && set +x \
  && printf "$(composer --ansi --version)\n\n"\
  && composer --ansi diagnose \
  && rm -rf /tmp/composer-setup.php

RUN set -xe; \
  cd /tmp \
  && curl -sSL https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar -o /usr/local/bin/drush \
  && chmod +x /usr/local/bin/drush \
  && echo "820f5428ac5fa41072717123020a5aebc92400a2d58445c8aae639a73faad479aeeb17847f1c0ce9fd73255204ae68a2134d7dc1619727fc216c890ef7fb9089  /usr/local/bin/drush"  | sha512sum -c -
  