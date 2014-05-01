FROM debian:squeeze

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && apt-get install -yqq \
    apt-utils \
    dialog \
    debconf-utils

# Setup locale
RUN echo "locales locales/locales_to_be_generated multiselect de_DE.UTF-8 UTF-8"|debconf-set-selections
RUN echo "locales locales/default_environment_locale  select  de_DE.UTF-8"|debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get install locales -yqq &&\
    dpkg-reconfigure -f noninteractive locales
ENV LC_ALL de_DE.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    locales \
    nano \
    openssh-server \
    passwd \
    supervisor \
    git-core \
    sudo \
    unzip \
    wget \
    curl

ADD conf/supervisor/debian.conf /etc/supervisor/conf.d/debian.conf
ADD conf/ssh/supervisor-sshd.conf /etc/supervisor/conf.d/supervisor-sshd.conf

RUN echo "Europe/Berlin" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

RUN echo 'alias ll="ls -lah --color=auto"' >> /etc/bash.bashrc

RUN useradd dev -m -s /bin/bash &&\
    echo dev:dev | chpasswd &&\
    usermod -a -G sudo dev &&\
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev &&\
    chmod 0440 /etc/sudoers.d/dev
ADD conf/git/.gitconfig /home/dev/.gitconfig

# Generate a host key
RUN mkdir -p /var/run/sshd && service ssh start; service ssh stop

# Apache
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install apache2-mpm-prefork apache2-utils;\
    a2enmod rewrite;\
    echo "ServerName localhost" | tee /etc/apache2/conf.d/fqdn;\
    echo "export APACHE_RUN_USER=dev" >> /etc/apache2/envvars &&\
    echo "export APACHE_RUN_GROUP=dev" >> /etc/apache2/envvars
ADD conf/apache/000-default /etc/apache2/sites-enabled/000-default
ADD conf/apache/supervisor-apache2.conf /etc/supervisor/conf.d/supervisor-apache2.conf

# PHP
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install libapache2-mod-php5 \
    php5 \
    php5-cli \
    php5-curl \
    php5-dev \
    php5-gd \
    php-apc \
    php-pear
ADD conf/php5/apc.ini /etc/php5/mods-available/apc.ini
ADD conf/php5/php.ini /etc/php5/conf.d/99-php.ini

# Mysql
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    mysql-common\
    mysql-server\
    mysql-client\
    php5-mysql\
    php5-mcrypt
RUN service mysql start;sleep 2;mysqladmin -uroot password root;service mysql stop
ADD conf/mysql/debian-mysql.conf /etc/supervisor/conf.d/debian-mysql.conf

# PhpMyadmin
RUN mkdir -p /root/phpmyadmin
ADD conf/phpmyadmin/config.inc.php /root/phpmyadmin/config.inc.php
ADD scripts/build_phpmyadmin.sh /root/phpmyadmin/build_phpmyadmin.sh
RUN sh /root/phpmyadmin/build_phpmyadmin.sh 4.1.14
ADD conf/phpmyadmin/phpmyadmin.conf /etc/apache2/conf.d/phpmyadmin.conf

# Setup Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer;

# Setup https://github.com/drush-ops/drush
RUN sudo -u dev mkdir -p /home/dev/.composer && sudo -u dev composer global require drush/drush:dev-master -d /home/dev/.composer
RUN sed -i '1i export PATH="$HOME/.composer/vendor/bin:$PATH"' /home/dev/.bashrc

EXPOSE 22 80

CMD ["/usr/bin/supervisord", "-n"]