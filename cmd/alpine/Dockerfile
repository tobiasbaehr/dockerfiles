FROM alpine:3.4

# skip installing gem documentation
RUN set -ex; \
  mkdir -p /usr/local/etc \
  && { \
    echo 'install: --no-document --quiet'; \
    echo 'update: --no-document --quiet'; \
    } >> /usr/local/etc/gemrc; \
  echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  && apk add --no-cache tzdata \
  && cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
  && echo "Europe/Berlin" >  /etc/timezone

# install things globally, for great justice
# and don't create ".bundle" in all our apps
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
    BUNDLE_BIN="$GEM_HOME/bin" \
    BUNDLE_SILENCE_ROOT_WARNING=1 \
    BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH
RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \
  && chmod 777 "$GEM_HOME" "$BUNDLE_BIN"


RUN set -ex; \
  apk add --no-cache --virtual .persistent-deps \
  git \
  sudo \
  rsync \
  curl \
  ruby-bundler@edge \
  ruby@edge \
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
  zsh && \
  echo "date.timezone=Europe/Berlin" >> /etc/php5/php.ini

RUN set -ex; \
  apk add --no-cache --virtual .ruby-builddeps \
  ruby-dev \
  autoconf \
  bison \
  bzip2-dev \
  ca-certificates \
  coreutils \
  gcc \
  gdbm-dev \
  glib-dev \
  libc-dev \
  libffi-dev \
  libxml2-dev \
  libxslt-dev \
  linux-headers \
  make \
  ncurses-dev \
  openssl \
  openssl-dev \
  procps \
  readline-dev \
  yaml-dev \
  zlib-dev \
  make \
  xz

# Ruby gems
RUN set -xe; \
  gem update --system --no-document \
  && gem update --no-document \
  && gem install --quiet --no-document compass \
  && gem install --quiet --no-document bundler \
  && gem install --quiet --no-document singularitygs \
  && gem install --quiet --no-document jekyll \
  && rm -rf /root/.gem

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
  adduser dev -s /bin/zsh -D &&\
  su dev -c "git clone --quiet --depth=1 https://github.com/zsh-users/antigen.git /home/dev/antigen" &&\
  echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev &&\
  chmod 0440 /etc/sudoers.d/dev

# Fix bug https://github.com/npm/npm/issues/9863
RUN set -xe; \
  cd $(npm root -g)/npm \
  && npm install --no-color --no-progress fs-extra \
  && sed -i -e s/graceful-fs/fs-extra/ -e s/fs\.rename/fs.move/ ./lib/utils/rename.js \
	&& npm install --production --no-color --no-progress -g npm yarn

# sassc
RUN set -xe; \
  apk add --no-cache --virtual .build-deps \
  g++ \
  && cd /tmp && git clone https://github.com/sass/sassc && cd sassc \
  && git clone https://github.com/sass/libsass \
  && SASS_LIBSASS_PATH=/tmp/sassc/libsass make -s\
  && mv /tmp/sassc/bin/sassc /usr/local/bin/sassc \
  && rm -rf /tmp/* \
  && apk del .build-deps

COPY .zshrc /home/dev/.zshrc

RUN su dev -c "source /home/dev/.zshrc" &&\
  find /home/dev/ -type d -name \.git -exec rm -rf -- {} +
