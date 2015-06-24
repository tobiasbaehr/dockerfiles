FROM debian:squeeze

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -yqq\
    apt-utils\
    dialog\
    debconf-utils

RUN echo "Europe/Berlin" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

# PHP
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    php5\
    php5-curl\
    php5-gd\
    php-apc\
    php5-mcrypt
COPY conf/php5/apc.ini /etc/php5/mods-available/apc.ini
COPY conf/php5/php.ini /tmp/php.ini
RUN cat /tmp/php.ini >> /etc/php5/apache2/php.ini && rm /tmp/php.ini

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_USER_UID 0

# Apache
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq\
    apache2-mpm-prefork\
    apache2-utils\
    libapache2-mod-php5;\
    a2enmod rewrite;\
    echo "ServerName localhost" | tee /etc/apache2/conf.d/fqdn
COPY conf/apache/000-default /etc/apache2/sites-enabled/000-default

# Mysql
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq\
    mysql-common\
    mysql-client\
    php5-mysql &&\
    rm -rf /tmp/* &&\
    rm -rf /var/lib/apt/lists/*

VOLUME ["/var/log/apache2/", "/etc/php5/apache2/"]

EXPOSE 80

COPY script/start.bash /root/start.bash

CMD ["/bin/bash", "/root/start.bash"]
