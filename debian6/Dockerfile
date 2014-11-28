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
    unzip \
    wget \
    curl \
    git-core

RUN echo "Europe/Berlin" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
RUN echo 'alias ll="ls -lah --color=auto"' >> /etc/bash.bashrc


# PHP
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install php5 \
    php5-cli \
    php5-curl \
    php5-dev \
    php5-gd \
    php-apc \
    php-pear
ADD conf/php5/apc.ini /etc/php5/mods-available/apc.ini
ADD conf/php5/php.ini /tmp/php.ini

RUN cat /tmp/php.ini >> /etc/php5/apache2/php.ini && rm /tmp/php.ini

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_USER_UID 0

# Apache
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install apache2-mpm-prefork apache2-utils libapache2-mod-php5;\
    a2enmod rewrite;\
    echo "ServerName localhost" | tee /etc/apache2/conf.d/fqdn
ADD conf/apache/000-default /etc/apache2/sites-enabled/000-default

# Mysql
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    mysql-common\
    mysql-client\
    php5-mysql\
    php5-mcrypt

VOLUME ["/var/log/apache2/", "/etc/php5/apache2/"]

EXPOSE 80

ADD script/start.bash /root/start.bash

CMD ["/bin/bash", "/root/start.bash"]
