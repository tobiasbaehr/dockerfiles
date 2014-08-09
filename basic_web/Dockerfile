FROM tobiasb/debian

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && apt-get install -yqq \
    nano \
    openssh-server \
    passwd \
    supervisor \
    git-core \
    sudo

ADD conf/supervisor/debian.conf /etc/supervisor/conf.d/debian.conf
ADD conf/ssh/supervisor-sshd.conf /etc/supervisor/conf.d/supervisor-sshd.conf

RUN useradd dev -m -s /bin/bash &&\
    echo dev:dev | chpasswd &&\
    usermod -a -G sudo dev &&\
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev &&\
    chmod 0440 /etc/sudoers.d/dev

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
ADD conf/php5/php.ini /tmp/php.ini

RUN cat /tmp/php.ini >> /etc/php5/apache2/php.ini

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

# Nodejs and npm packages for frontend stuff
RUN echo "deb http://ftp2.de.debian.org/debian wheezy-backports main" >> /etc/apt/sources.list;\
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq nodejs-legacy &&\
    curl --insecure https://www.npmjs.org/install.sh | sudo clean=no sh &&\
    npm install --silent -g grunt-cli \
        grunt-contrib-csslint \
        grunt-contrib-jshint \
        live-reload \
        grunt-contrib-sass

# Ruby stuff
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq ruby-compass &&\
    gem install bundler

EXPOSE 22 80

CMD ["/usr/bin/supervisord", "-n"]
