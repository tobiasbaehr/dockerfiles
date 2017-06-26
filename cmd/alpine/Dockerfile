FROM alpine:3.4

RUN set -xe; \
  apk add --no-cache --virtual .persistent-deps \
  git \
  sudo \
  rsync \
  curl \
  nano \
  bzip2 \
  mysql-client \
  php5-cli \
  php5-mcrypt \
  php5-gd \
  php5-curl \
  php5-json \
  php5-phar \
  php5-openssl \
  php5-ctype \
  php5-zip \
  php5-zlib \
  nodejs \
  bash \
  zsh \
  tzdata \
  && echo "date.timezone=Europe/Berlin" >> /etc/php5/php.ini \
  && cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
  && echo "Europe/Berlin" > /etc/timezone

RUN set -xe; \
  cd /tmp && curl -sSL https://getcomposer.org/installer > composer-setup.php \
  && echo "e56b2c87bd9dc948f8464df64080d271f5bc63d84a5febf06a68e648c56d5daddbd05e68e5559cac64e14cc0736f28d480ded563d809e4a2796d19bc4f1ba28d  composer-setup.php" | sha512sum -c - \
  && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer \
  && rm -rf /root/.composer/ \
  && rm -rf /tmp/*

RUN set -xe; \
  curl -sSL https://drupalconsole.com/installer -o /usr/local/bin/drupal \
	&& chmod +x /usr/local/bin/drupal

RUN set -xe; \
  cd /tmp \
	&& curl -sSL https://github.com/drush-ops/drush/releases/download/8.1.12/drush.phar -o /usr/local/bin/drush \
  && chmod +x /usr/local/bin/drush \
  && echo "d282af8064d40119c1fbb93796ad4ae7aaeab0f4cbf420759a7fab0a50a847eb1880c86ce63e9863bafcb63fddd134ee4d7ae3bf4ed557dd0f06dfcedb76632b  /usr/local/bin/drush"  | sha512sum -c -

# Contrib drush commands
RUN set -xe; \
  mkdir -p /usr/share/drush/commands && cd /usr/share/drush/commands &&\
  drush -q dl registry_rebuild-7.x-2.x-dev site_audit grn-7.x-2.x-dev composer_generate-7.x-1.2 &&\
  rm -rf /root/.drush

# Setup dev user
RUN set -xe; \
  adduser dev -s /bin/zsh -D \
  && su dev -c "git clone --quiet --depth=1 https://github.com/zsh-users/antigen.git /home/dev/antigen" \
  && echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev \
  && chmod 0440 /etc/sudoers.d/dev

# Fix bug https://github.com/npm/npm/issues/9863
RUN set -xe; \
  cd $(npm root -g)/npm \
  && npm install --no-color --no-progress fs-extra \
  && sed -i -e s/graceful-fs/fs-extra/ -e s/fs\.rename/fs.move/ ./lib/utils/rename.js \
	&& npm install --production --no-color --no-progress -g npm yarn

# sassc
RUN set -xe; \
  apk add --no-cache --virtual .build-deps \
  make \
  g++ \
  ; \
  cd /tmp && git clone https://github.com/sass/sassc && cd sassc \
  && git clone https://github.com/sass/libsass \
  && SASS_LIBSASS_PATH=/tmp/sassc/libsass make -s\
  && mv /tmp/sassc/bin/sassc /usr/local/bin/sassc \
  && rm -rf /tmp/* \
  && apk del .build-deps

COPY .zshrc /home/dev/.zshrc

RUN su dev -c "source /home/dev/.zshrc" \
    && find /home/dev/ -type d -name \.git -exec rm -rf -- {} +

RUN set -xe; \
  export CONFIGURE_OPTS="--disable-install-doc"; \
  apk add --no-cache gmp yaml \
  && apk add --no-cache --virtual .build-deps \
  gcc \
  make \
  zlib-dev \
  openssl-dev \
  gdbm-dev \
  db-dev \
  libedit-dev \
  libffi-dev \
  coreutils \
  linux-headers \
  autoconf \
  libc-dev \
  gmp-dev \
  yaml-dev \
  ; \
  su -l dev -c "git clone --depth=1 https://github.com/rbenv/rbenv.git .rbenv" \
  && su -l dev -c "mkdir -p .rbenv/plugins/" \
  && su -l dev -c "git clone --depth=1 https://github.com/rbenv/ruby-build.git .rbenv/plugins/ruby-build" \
  && su -l dev -c ".rbenv/bin/rbenv install 2.4.1" \
  && su -l dev -c ".rbenv/bin/rbenv global 2.4.1" \
  && su -l dev -c ".rbenv/shims/gem update --quiet --no-document" \
  && su -l dev -c ".rbenv/shims/gem install --quiet --no-document compass" \
  && su -l dev -c ".rbenv/shims/gem install --quiet --no-document jekyll" \
  && apk del .build-deps \
  && rm -rf /tmp/* \
  && rm -rf /home/dev/.gem/ \
  && rm -rf /home/dev/.rbenv/plugins/ruby-build
