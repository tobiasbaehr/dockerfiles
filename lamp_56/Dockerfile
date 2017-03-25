FROM php:5.6-apache

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN a2enmod rewrite vhost_alias

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev \
	imagemagick libxml2-dev libldap2-dev unzip libicu-dev libmcrypt-dev libfreetype6-dev\
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr --with-freetype-dir=/usr --enable-gd-native-ttf \
	&& docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql zip exif soap ldap mysqli intl mcrypt opcache \
	&& pecl install xdebug \
	&& docker-php-ext-enable xdebug \
	&& echo xdebug.remote_enable=On >> /usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini \
	&& echo xdebug.remote_connect_back=1 >> /usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini; \
	rm -rvf /usr/local/etc/php/conf.d/docker-php-ext-pdo.ini; \
	rm -rvf /usr/local/etc/php/conf.d/docker-php-ext-curl.ini; \
	rm -rf /tmp/*

COPY php.ini /usr/local/etc/php/conf.d/custom_php.ini
COPY xdebug_for_mac.sh /usr/local/bin/xdebug_for_mac
RUN usermod -u 1000 www-data
