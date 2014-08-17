FROM reinblau/php

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2

# Apache
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install apache2-mpm-prefork apache2-utils libapache2-mod-php5;\
    a2enmod rewrite;\
    echo "ServerName localhost" | tee /etc/apache2/conf.d/fqdn
ADD conf/apache/000-default /etc/apache2/sites-enabled/000-default

EXPOSE 80

VOLUME /var/log/apache2

CMD ["/usr/sbin/apache2", "-DFOREGROUND"]
