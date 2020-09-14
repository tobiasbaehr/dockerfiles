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
  && echo "99e9112582eb02ac678f74f57e069c29911ef11c6dd2d5ba840053bc6ffc56219a0c15a38561866cedf86fe5492ba6b917d00cf98fb9e4ccb269f907eb2e3bfd  composer-setup.php" | sha512sum -c - \
  && php composer-setup.php --check \
  && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer \
  && rm -rf /tmp/composer-setup.php \
  && set +x \
  && printf "$(composer --version)\n\n"\
  && composer diagnose

RUN set -xe; \
  cd /tmp \
	&& curl -sSL https://github.com/drush-ops/drush/releases/download/8.4.1/drush.phar -o /usr/local/bin/drush8 \
  && chmod +x /usr/local/bin/drush8 \
  && echo "ddfaa6637f8fdf162a4be73850167c2c5fdd5c2edfa74fbc238adda2e1c75c830d644c22075077e739525c682c35b9f61df9c73e56a81ffd21674c9d2392b72d  /usr/local/bin/drush8"  | sha512sum -c -

RUN set -xe; \
  cd /tmp \
	&& curl -sSL https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar -o /usr/local/bin/drush \
  && chmod +x /usr/local/bin/drush \
  && echo "820f5428ac5fa41072717123020a5aebc92400a2d58445c8aae639a73faad479aeeb17847f1c0ce9fd73255204ae68a2134d7dc1619727fc216c890ef7fb9089  /usr/local/bin/drush"  | sha512sum -c -

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
  npm install --production --no-color --no-progress -g npm yarn gulp-cli cloudron@3.1.1\
  && rm -rf /root/.npm \
  && rm -rf /usr/share/man/* \
  && rm -rf /tmp/*
