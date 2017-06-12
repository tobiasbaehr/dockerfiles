FROM reinblau/php:5.4-alpine

RUN set -xe; \
  mkdir -p /run/apache2/ \
  && apk add --no-cache apache2 apache2-utils \
  && sed -i 's/^#ServerName.*/ServerName localhost/' /etc/apache2/httpd.conf \
  && ln -sf /dev/stdout /var/log/apache2/access.log \
  && ln -sf /dev/stderr /var/log/apache2/error.log

COPY docker-php-entrypoint /usr/local/bin/
COPY apache2-foreground /usr/local/bin/
WORKDIR /var/www/localhost/htdocs

EXPOSE 80
ENTRYPOINT ["docker-php-entrypoint"]
CMD ["apache2-foreground"]
