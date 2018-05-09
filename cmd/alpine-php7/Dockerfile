FROM gzevd/alpine:3.7

RUN set -xe; \
  apk add --update --no-cache --virtual .persistent-deps \
  git \
  patch \
  sudo \
  rsync \
  curl \
  nano \
  bzip2 \
  nodejs \
  bash \
  zsh \
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
  && echo "date.timezone=Europe/Berlin" >> /etc/php7/php.ini \
  && echo "memory_limit=256M" >> /etc/php7/php.ini \
  && rm -rf /var/cache/* \
  && mkdir -p /var/cache/apk
  
RUN set -xe; \
  cd /tmp && curl -sSL https://getcomposer.org/installer > composer-setup.php \
  && echo "4190f971ff4e8d4ddff9fa167d6bad4e7d2dc5cf5bbd1aafc87dcecbdb0fe7415aa7305adb16d8a03acd93bcc69c5b39a4e9f1017bb1bec8feab3a81a44ddb93  composer-setup.php" | sha512sum -c - \
  && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer \
  && rm -rf /root/.composer/ \
  && rm -rf /tmp/*

RUN set -xe; \
  cd /tmp && curl -sSL https://drupalconsole.com/installer -o /usr/local/bin/drupal \
  && chmod +x /usr/local/bin/drupal \
  && echo "ecdaf34abfd82bea614c067ce8769194f2e9835553da76da32e1a1a66b8505d99f30b4c9143ae58e5fad21829dba62eb0167e26dba9dac84f58724c045cc273b  /usr/local/bin/drupal" | sha512sum -c -

RUN set -xe; \
  cd /tmp \
	&& curl -sSL https://github.com/drush-ops/drush/releases/download/8.1.16/drush.phar -o /usr/local/bin/drush8 \
  && chmod +x /usr/local/bin/drush8 \
  && echo "aa1a524fc0787a0aab90687ec3810149bc4e739ba3c8960226af5fc8d9d136f60ad7b686fc2768d60f1c6930c251402ca7518e610f8780cd82943bcd2f8d00c5  /usr/local/bin/drush8"  | sha512sum -c -

RUN set -xe; \
  cd /tmp \
	&& curl -sSL https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar -o /usr/local/bin/drush \
  && chmod +x /usr/local/bin/drush \
  && echo "820f5428ac5fa41072717123020a5aebc92400a2d58445c8aae639a73faad479aeeb17847f1c0ce9fd73255204ae68a2134d7dc1619727fc216c890ef7fb9089  /usr/local/bin/drush"  | sha512sum -c -

ENV DRUSH_LAUNCHER_FALLBACK /usr/local/bin/drush8

COPY .zshrc /tmp/.zshrc

# Setup dev user
RUN set -xe; \
  adduser dev -s /bin/zsh -D \
  && su dev -c "git clone --quiet --depth=1 https://github.com/zsh-users/antigen.git /home/dev/antigen" \
  && echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev \
  && chmod 0440 /etc/sudoers.d/dev \
  && cp /tmp/.zshrc /home/dev/.zshrc \
  && su dev -c "source /home/dev/.zshrc" \
  && find /home/dev/ -type d -name \.git -exec rm -rf -- {} + 
    
# sassc
RUN set -xe; \
  apk add --update --no-cache --virtual .build-deps \
  make \
  g++ \
  ; \
  cd /tmp && git clone https://github.com/sass/sassc && . sassc/script/bootstrap \
  && make -C sassc -s\
  && mv /tmp/sassc/bin/sassc /usr/local/bin/sassc \
  && rm -rf /tmp/* \
  && apk del --no-cache .build-deps
  
