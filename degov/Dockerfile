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
    exim

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
  && echo "3b9638533b7c43c80fbde4ce9f11a5c90a62b2fdf157bc1d860938042abdab5560f665b8e802e2af49e416db450cc814d0af8ca1dfaa762032220cb9fa961274  composer-setup.php" | sha512sum -c - \
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
  