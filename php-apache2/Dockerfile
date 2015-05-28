FROM reinblau/debian

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_USER_UID 0

# PHP && Apache
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yqq install --no-install-recommends\
    php5\
    php5-curl\
    php5-gd\
    php-apc\
    php5-imagick\
    imagemagick\
    apache2-mpm-prefork\
    apache2-utils\
    libapache2-mod-php5 &&\
    rm -rf /var/lib/apt/lists/* &&\
    a2enmod rewrite &&\
    echo "ServerName localhost" | tee /etc/apache2/conf.d/fqdn

# Config files.
COPY conf/apache/000-default /etc/apache2/sites-enabled/000-default
COPY conf/php5/apc.ini /etc/php5/mods-available/apc.ini
COPY conf/php5/php.ini /tmp/php.ini
COPY script/start.bash /root/start.bash

RUN cat /tmp/php.ini >> /etc/php5/apache2/php.ini && rm /tmp/php.ini

EXPOSE 80

VOLUME ["/var/log/apache2","/etc/php5/apache2/"]

CMD ["/bin/bash", "/root/start.bash"]
