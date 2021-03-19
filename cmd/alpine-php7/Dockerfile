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
  && echo "3137ad86bd990524ba1dedc2038309dfa6b63790d3ca52c28afea65dcc2eaead16fb33e9a72fd2a7a8240afaf26e065939a2d472f3b0eeaa575d1e8648f9bf19  composer-setup.php" | sha512sum -c - \
  && php composer-setup.php --check \
  && php composer-setup.php --1 --install-dir=/usr/local/bin/ --filename=composer \
  && rm -rf /tmp/composer-setup.php \
  && set +x \
  && printf "$(composer --version)\n\n"\
  && composer diagnose

RUN set -xe; \
  cd /tmp \
	&& curl -sSL https://github.com/drush-ops/drush/releases/download/8.4.6/drush.phar -o /usr/local/bin/drush8 \
  && chmod +x /usr/local/bin/drush8 \
  && echo "2e43c1ea8308a3fdeebd8b51f778ffefe3e17f9df1d15a89dffcadf099996dee30e05100a5b13599bcb5d2643a79818423b7fa7ba1f869cd9d02d995ee3f3d05  /usr/local/bin/drush8"  | sha512sum -c -

RUN set -xe; \
  cd /tmp \
	&& curl -sSL https://github.com/drush-ops/drush-launcher/releases/download/0.9.0/drush.phar -o /usr/local/bin/drush \
  && chmod +x /usr/local/bin/drush \
  && echo "abc7138f6c86d2d9f157a6507889819ccc422ec053daaabe9778e48d58ea8a3d185353388b995ac5e81856578a5f52a2d8ea625693c8bf255c9bd1b94ee550bc  /usr/local/bin/drush"  | sha512sum -c -

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
