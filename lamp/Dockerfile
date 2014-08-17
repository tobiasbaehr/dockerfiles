FROM reinblau/php-apache2

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

# Mysql
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    mysql-common\
    mysql-client\
    php5-mysql\
    php5-mcrypt
