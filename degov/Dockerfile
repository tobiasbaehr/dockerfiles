FROM php:7.3-cli

SHELL ["/bin/bash", "-o", "xtrace", "-o", "pipefail", "-o", "errexit", "-c"]

# Set timezone
RUN cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
  && echo "Europe/Berlin" > /etc/timezone

ENV TZ /etc/localtime

# Install default packages
RUN mkdir -p /usr/share/man/man1mkdir -p /usr/share/man/man1; \
  apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yq \
    less \
    default-mysql-client \
    git \
    screen \
    openssh-client \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    exim4-base \
    jq \
    wget \
    git-lfs \
    default-jre-headless \
    rsync \
    unzip \
    && apt-get autoclean -y; \
    apt-get autoremove -y; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /var/log/*; \
    rm -rf /var/cache/*; \
    rm -rf /tmp/*


RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    $PHPIZE_DEPS \
  && docker-php-source extract \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd pdo_mysql soap zip exif\
  && pecl install --configureoptions=enable-apcu-debug=no apcu mongodb \
  && docker-php-ext-enable opcache apcu zip mongodb \
  && docker-php-source delete \
  && DEBIAN_FRONTEND=noninteractive apt-get purge -yq $PHPIZE_DEPS \
  && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
  && apt-get autoclean -y; \
  apt-get autoremove -y; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/*; \
  rm -rf /var/cache/*; \
  rm -rf /tmp/*


RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yq \
  dh-autoreconf \
  && apt-get autoclean -y; \
  apt-get autoremove -y; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/*; \
  rm -rf /var/cache/*; \
  rm -rf /tmp/*

COPY ./degov.ini /usr/local/etc/php/conf.d/degov.ini

WORKDIR /tmp

RUN curl -sSL https://getcomposer.org/installer > composer-setup.php \
  && echo "3137ad86bd990524ba1dedc2038309dfa6b63790d3ca52c28afea65dcc2eaead16fb33e9a72fd2a7a8240afaf26e065939a2d472f3b0eeaa575d1e8648f9bf19  composer-setup.php" | sha512sum -c - \
  && php composer-setup.php --check \
  && php composer-setup.php --1 --install-dir=/usr/local/bin/ --filename=composer \
  && chmod +x /usr/local/bin/composer \
  && set +x \
  && printf "%s\n\n" "$(composer --ansi --version)" \
  && composer --ansi diagnose \
  && rm -rf composer-setup.php

RUN touch ~/.profile \
  && curl -sSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh > install.sh \
  && echo "1a28103411ec0092aab7859a3bbc7eb7be9a2a8bedc458177c452df2fa965b761440151b33e0c7cf165910866c74938917d7d1deaf544227f2b295062f8e5059  install.sh"  | sha512sum -c - \
  && bash install.sh \
  && rm install.sh
