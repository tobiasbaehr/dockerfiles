FROM tobiasb/debian

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && apt-get install -yqq git-core

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

# Setup Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer;

# xhprof
RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq install make graphviz

ADD conf/php5/xhprof.conf /etc/apache2/conf.d/xhprof.conf
ADD conf/php5/xhprof.ini /etc/php5/mods-available/xhprof.ini

RUN cd /opt && git clone https://github.com/facebook/xhprof.git &&\
    cd xhprof/extension && phpize && ./configure && make && make install &&\
    cd /opt/xhprof && composer install

RUN DEBIAN_FRONTEND=noninteractive apt-get -yqq purge make; apt-get clean -y
