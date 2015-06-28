FROM php:5.4-apache

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev imagemagick \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql zip \
	&& pecl install memcache-3.0.8 && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/docker-php-ext-memcache.ini \
	&& a2enmod vhost_alias \
	&& rm -rvf /usr/local/etc/php/conf.d/docker-php-ext-{curl,pdo}.ini \
	&& rm -rf /tmp/*

COPY php.ini /usr/local/etc/php/conf.d/custom_php.ini

RUN usermod -u 1000 www-data
