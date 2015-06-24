FROM php:5.6-apache

MAINTAINER Tobias Bähr "tobias.baehr@reinblau.de"

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev imagemagick \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql zip \
	&& rm -rf /usr/local/etc/php/conf.d/docker-php-ext-{curl,pdo}.ini \
	&& rm -rf /tmp/*

RUN usermod -u 1000 www-data
