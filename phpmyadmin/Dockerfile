FROM tobiasb/debian

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

# PHP
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -yqq install mysql-client\
    php5 \
    php5-curl \
    php5-gd \
    php-apc \
    php5-mysql \
    php5-mcrypt

# Apache
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install apache2-mpm-prefork apache2-utils;\
    a2enmod rewrite;\
    echo "ServerName localhost" | tee /etc/apache2/conf.d/fqdn;

# PhpMyadmin
RUN mkdir -p /root/phpmyadmin
ADD conf/phpmyadmin/config.inc.php /root/phpmyadmin/config.inc.php
ADD scripts/build_phpmyadmin.sh /root/phpmyadmin/build_phpmyadmin.sh
RUN sh /root/phpmyadmin/build_phpmyadmin.sh

ADD conf/php/apc.ini /etc/php5/mods-available/apc.ini

ADD scripts/start.sh /opt/start.sh

RUN chmod +x /opt/start.sh

EXPOSE 80

# Define default command.
CMD ["bin/bash", "/opt/start.sh"]
