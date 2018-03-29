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
  php5-pdo_mysql \
  php5-dom \
  php5-xml \
  nodejs \
  bash \
  zsh \
  tzdata \
  openssh-client \
  postgresql-client \
  && echo "date.timezone=Europe/Berlin" >> /etc/php5/php.ini \
  && echo "memory_limit=256M" >> /etc/php5/php.ini \
  && cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
  && echo "Europe/Berlin" > /etc/timezone

RUN set -xe; \
  cd /tmp && curl -sSL https://getcomposer.org/installer > composer-setup.php \
  && echo "4190f971ff4e8d4ddff9fa167d6bad4e7d2dc5cf5bbd1aafc87dcecbdb0fe7415aa7305adb16d8a03acd93bcc69c5b39a4e9f1017bb1bec8feab3a81a44ddb93  composer-setup.php" | sha512sum -c - \
  && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer \
  && rm -rf /root/.composer/ \
  && rm -rf /tmp/*

RUN set -xe; \
  curl -sSL https://drupalconsole.com/installer -o /usr/local/bin/drupal \
	&& chmod +x /usr/local/bin/drupal

RUN set -xe; \
  cd /tmp \
	&& curl -sSL https://github.com/drush-ops/drush/releases/download/8.1.15/drush.phar -o /usr/local/bin/drush \
  && chmod +x /usr/local/bin/drush \
  && echo "21b22fb1e25172aa5f33e66013cd963f6eccb083242095e9f901c94fb837276ab4a607e2658c61771c787c6c21dd96d8cb84e74d72abb1bd3d85488dba124336  /usr/local/bin/drush"  | sha512sum -c -

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
  g++ \
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
  && su -l dev -c ".rbenv/bin/rbenv install 2.5.0" \
  && su -l dev -c ".rbenv/bin/rbenv global 2.5.0" \
  && su -l dev -c ".rbenv/shims/gem update --quiet --no-document" \
  && su -l dev -c ".rbenv/shims/gem install --quiet --no-document compass" \
  && su -l dev -c ".rbenv/shims/gem install --quiet --no-document jekyll" \
  && apk del .build-deps \
  && rm -rf /tmp/* \
  && rm -rf /home/dev/.gem/ \
  && rm -rf /home/dev/.rbenv/plugins/ruby-build
