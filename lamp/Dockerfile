FROM reinblau/php-apache2

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

# Mysql
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yqq\
    mysql-common\
    mysql-client\
    php5-mysql\
    php5-mcrypt &&\
    rm -rf /var/lib/apt/lists/*
